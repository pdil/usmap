#' Convert coordinate date frame to usmap projection
#'
#' @description Converting an external data frame of map coordinates will
#'   allow those points to line up with the regular usmap plot by applying
#'   the same Albers Equal Area projection to those points as well.
#'
#' @param data A data frame containing coordinates in a two column format
#'   where the first column represents longitude and the second data frame
#'   represents latitude. The names of the data frame column do not matter,
#'   just that the order of the columns is kept intact.
#'
#' @return A data frame containing the transformed coordinates from the
#'   input data frame with the Albers Equal Area projection applied.
#'
#' @examples
#' data <- data.frame(
#'   lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
#'   lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31)
#' )
#'
#' # Transform data
#' transformed_data <- usmap_transform(data)
#'
#' # Plot transformed data on map
#' library(ggplot2)
#'
#' plot_usmap() + geom_point(
#'   data = transformed_data,
#'   aes(x = lon, y = lat),
#'   colour = "red",
#'   size = 2
#' )
#'
#' @rdname usmap_transform
#' @export
usmap_transform <- function(data) {
  UseMethod("usmap_transform", data)
}

#' @rdname usmap_transform
#' @export
usmap_transform.data.frame <- function(data) {
  # check for maptools
  if (!requireNamespace("maptools", quietly = TRUE)) {
    stop("`maptools` must be installed to use `usmap_proj`.
         Use: install.packages(\"maptools\") and try again.")
  }

  # check for sp
  if (!requireNamespace("sp", quietly = TRUE)) {
    stop("`sp` must be installed to use `usmap_proj`.
         Use: install.packages(\"sp\") and try again.")
  }

  # check for rgdal
  if (!requireNamespace("rgdal", quietly = TRUE)) {
    stop("`rgdal` must be installed to use `usmap_proj`.
         Use: install.packages(\"rgdal\") and try again.")
  }

  # validation
  if (ncol(data) != 2) {
    stop("`data` must contain two numeric columns with longitude
         in the first column and latitude in the second.")
  } else if (class(data[, 1]) != "numeric" | class(data[, 2]) != "numeric") {
    stop("`data` must contain two numeric columns with longitude
         in the first column and latitude in the second.")
  }

  # create SpatialPointsDataFrame
  spdf <- sp::SpatialPointsDataFrame(
    coords = data[, c(1, 2)],
    data = data,
    proj4string = sp::CRS("+proj=longlat +datum=WGS84")
  )

  # transform to canonical projection
  transformed <- sp::spTransform(spdf, usmap_crs())

  # transform Alaska points

  ak_bbox <- sp::bbox(
    matrix(
      c(
        -4360650, # min transformed longitude
        -1512250, # max transformed longitude
        1466100,  # min transformed latitude
        3911200   # max transformed latitude
      ), ncol = 2
    )
  )

  alaska <- transformed[
    transformed@coords[, 1] >= ak_bbox[1, 1] &
    transformed@coords[, 1] <= ak_bbox[1, 2] &
    transformed@coords[, 2] >= ak_bbox[2, 1] &
    transformed@coords[, 2] <= ak_bbox[2, 2],
  ]

  if (length(alaska) > 0) {
    alaska <- maptools::elide(
      alaska,
      rotate = -50,
      scale = max(apply(ak_bbox, 1, diff)) / 2.3,
      bb = ak_bbox
    )
    alaska <- maptools::elide(alaska, shift = c(-1298669, -3018809))
    sp::proj4string(alaska) <- sp::proj4string(transformed)
    names(alaska) <- names(transformed)
  }

  # transform Hawaii points

  hi_bbox <- sp::bbox(
    matrix(
      c(
        -5762000, # min transformed longitude
        -5451950, # max transformed longitude
        -1051950, # min transformed latitude
        -441850   # max transformed latitude
      ), ncol = 2
    )
  )

  hawaii <- transformed[
    transformed@coords[, 1] >= hi_bbox[1, 1] &
    transformed@coords[, 1] <= hi_bbox[1, 2] &
    transformed@coords[, 2] >= hi_bbox[2, 1] &
    transformed@coords[, 2] <= hi_bbox[2, 2],
  ]

  if (length(hawaii) > 0) {
    hawaii <- maptools::elide(
      hawaii,
      rotate = -35,
      bb = hi_bbox
    )
    hawaii <- maptools::elide(hawaii, shift = c(5400000, -1400000))
    sp::proj4string(hawaii) <- sp::proj4string(transformed)
  }

  # combine all points
  if (length(alaska) > 0 & length(hawaii) > 0) {
    combined <- rbind(transformed, alaska, hawaii)
  } else if (length(alaska) > 0) {
    combined <- rbind(transformed, alaska)
  } else if (length(hawaii) > 0) {
    combined <- rbind(transformed, hawaii)
  } else {
    combined <- transformed
  }

  result <- as.data.frame(
    combined@coords[!duplicated(combined@data[, c(1, 2)], fromLast = TRUE), ]
  )
  row.names(result) <- NULL

  result
}

#' usmap coordinate reference system
#'
#' @description This coordinate reference system (CRS) represents
#' the canonical projection used by the \code{usmap} package. It can
#' be used to transform shape files, spatial points, spatial data
#' frames, etc. to the same coordinate representation that is used
#' by the \code{plot_usmap} function.
#'
#' @export
usmap_crs <- function() {
  if (!requireNamespace("sp", quietly = TRUE)) {
    stop("`sp` must be installed to use `usmap_proj`.
         Use: install.packages(\"sp\") and try again.")
  }

  sp::CRS("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0
                     +a=6370997 +b=6370997 +units=m +no_defs")
}
