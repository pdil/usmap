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
#' @param input_names A character vector of length two which specifies the
#'   longitude and latitude columns of the input data (the ones that should be
#'   transformed), respectively. Defaults to `c("lon", "lat")`.
#'
#' @param output_names A character vector of length two which specifies the
#'   longitude and latitude columns of the output data (after transformation),
#'   respectively. Defaults to `c("x", "y")`.
#'
#' @return A data frame containing the transformed coordinates from the
#'   input data frame with the Albers Equal Area projection applied. The
#'   transformed columns will be appended to the data frame so that all
#'   original columns should remain intact.
#'
#' @examples
#' data <- data.frame(
#'   lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
#'   lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31),
#'   pop = c(8398748, 2325502, 3990456, 2705994, 32113, 347397)
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
#'   aes(x = x, y = y, size = pop),
#'   color = "red", alpha = 0.5
#' )
#'
#' @rdname usmap_transform
#' @export
usmap_transform <- function(data,
                            input_names = c("lon", "lat"),
                            output_names = c("x", "y")) {

  # check for sf
  set_sp_evolution_status()
  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("`sf` must be installed to use `usmap_transform`.
         Use: install.packages(\"sf\") and try again.")
  }

  # check for sp
  if (!requireNamespace("sp", quietly = TRUE)) {
    stop("`sp` must be installed to use `usmap_transform`.
         Use: install.packages(\"sp\") and try again.")
  }

  UseMethod("usmap_transform", data)
}

#' @rdname usmap_transform
#' @export
usmap_transform.data.frame <- function(data,
                                       input_names = c("lon", "lat"),
                                       output_names = c("x", "y")) {
  # ensure data is data.frame
  data <- as.data.frame(data)

  # validation
  if (length(input_names) != 2 && !any(is.na(as.character(input_names)))) {
    stop("`input_names` must be a character vector of length 2.")
  } else {
    input_names <- as.character(input_names)
  }

  if (!all(input_names %in% colnames(data))) {
    stop("All `input_names` must exist as column names in `data`.")
  }

  if (ncol(data) < 2 ||
        !is.numeric(data[, input_names[1]]) ||
        !is.numeric(data[, input_names[2]])) {
    stop("`data` must contain at least two numeric columns.")
  }

  if (length(output_names) != 2 && !any(is.na(as.character(output_names)))) {
    stop("`output_names` must be a character vector of length 2.")
  } else {
    output_names <- as.character(output_names)
  }

  # create SpatialPointsDataFrame
  longlat <- sp::CRS(SRS_string = "EPSG:4326") # long/lat coordinates

  spdf <- sp::SpatialPointsDataFrame(
    coords = data[, c(input_names[1], input_names[2])],
    data = data,
    proj4string = longlat
  )

  # transform to canonical projection
  transformed <- sp::spTransform(spdf, usmap_crs())

  # transform Alaska points

  ak_bbox <- sp::bbox(
    matrix(
      c(
        -4377000, # min transformed longitude
        -1519000, # max transformed longitude
        1466000,  # min transformed latitude
        3914000   # max transformed latitude
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
    alaska <- sp::elide(
      alaska,
      rotate = -50,
      scale = max(apply(ak_bbox, 1, diff)) / 2.3,
      bb = ak_bbox
    )
    alaska <- sp::elide(alaska, shift = c(-1298669, -3018809))
    sp::proj4string(alaska) <- usmap_crs()
    names(alaska) <- names(transformed)
  }

  # transform Hawaii points

  hi_bbox <- sp::bbox(
    matrix(
      c(
        -5750000, # min transformed longitude
        -5450000, # max transformed longitude
        -1050000, # min transformed latitude
        -441000   # max transformed latitude
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
    hawaii <- sp::elide(
      hawaii,
      rotate = -35,
      bb = hi_bbox
    )
    hawaii <- sp::elide(hawaii, shift = c(5400000, -1400000))
    sp::proj4string(hawaii) <- usmap_crs()
    names(hawaii) <- names(transformed)
  }

  # combine all points
  combined <- rbind(transformed, alaska, hawaii)

  result <- as.data.frame(
    combined[!duplicated(combined@data, fromLast = TRUE), ]
  )
  row.names(result) <- NULL

  colnames(result) <- c(colnames(data), output_names)

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
  set_sp_evolution_status()

  if (!requireNamespace("sf", quietly = TRUE)) {
    stop("`sf` must be installed to use `usmap_transform`.
         Use: install.packages(\"sf\") and try again.")
  }

  if (!requireNamespace("sp", quietly = TRUE)) {
    stop("`sp` must be installed to use `usmap_crs`.
         Use: install.packages(\"sp\") and try again.")
  }

  sp::CRS(paste("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0",
                "+a=6370997 +b=6370997 +units=m +no_defs"))
}

#' Set sp evolution status
#'
#' @description
#' Sets the `sp` evolution status to "2" to
#' force usage of `sf` instead of `rgdal`
#' which is being retired.
#'
#' This can be removed in the future when the evolution status
#' is set to >= 2 by default in `sf`.
#'
#' @keywords internal
set_sp_evolution_status <- function() {
  if (sp::get_evolution_status() < 2L)
    sp::set_evolution_status(2L)
}
