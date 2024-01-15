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

  # Convert data to sf
  data_sf <- sf::st_as_sf(data, coords = input_names)
  sf::st_crs(data_sf) <- sf::st_crs(4326) # long/lat CRS

  # Transform to canonical projection
  transformed <- sf::st_transform(data_sf, usmap_crs())
  sf::st_agr(transformed) <- "constant"

  # Transform Alaska points
  ak_bbox <- sf::st_as_sfc(
    sf::st_bbox(
      c(
        xmin = -4377000,
        xmax = -1519000,
        ymin = 1466000,
        ymax = 3914000
      ),
      crs = usmap_crs()
    )
  )
  alaska <- sf::st_intersection(transformed, ak_bbox)

  if (nrow(alaska) > 0) {
    sf::st_geometry(alaska) <- sf::st_geometry(alaska) * usmapdata:::transform2D(-50, 1 / 2)
    sf::st_geometry(alaska) <- sf::st_geometry(alaska) + c(3e5, -2e6)
    sf::st_crs(alaska) <- usmap_crs()
  }

  # Transform Hawaii points
  hi_bbox <- sf::st_as_sfc(
    sf::st_bbox(
      c(
        xmin = -5750000,
        xmax = -5450000,
        ymin = -1050000,
        ymax = -441000
      ),
      crs = usmap_crs()
    )
  )
  hawaii <- sf::st_intersection(transformed, hi_bbox)

  if (nrow(hawaii) > 0) {
    sf::st_geometry(hawaii) <- sf::st_geometry(hawaii) * usmapdata:::transform2D(-35)
    sf::st_geometry(hawaii) <- sf::st_geometry(hawaii) + c(3.6e6, 1.8e6)
    sf::st_crs(hawaii) <- usmap_crs()
  }

  # Re-combine all points
  transformed_excl_ak <- sf::st_difference(transformed, ak_bbox)
  sf::st_agr(transformed_excl_ak) <- "constant"

  transformed_excl_ak_hi <- sf::st_difference(transformed_excl_ak, hi_bbox)
  sf::st_agr(transformed_excl_ak_hi) <- "constant"

  rbind(transformed_excl_ak_hi, alaska, hawaii)
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
  sf::st_crs(9311)
}
