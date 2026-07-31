#' Convert spatial data to usmap projection
#'
#' @description Converting a spatial object of map coordinates will
#'   allow those points to line up with the regular usmap plot by applying
#'   the same US National Atlas Equal Area projection (including Alaska and
#'   Hawaii of course) to those points as well.
#'
#'   The input `data` is assumed to contain longitude and latitude coordinates
#'   by default. If this is not the case, provide an [sf::st_crs] object
#'   to the `crs` parameter with the appropriate coordinate reference system.
#'
#' @param data A data frame containing coordinates in a two column format
#'   where the first column represents longitude and the second data frame
#'   represents latitude. The names of the data frame column do not matter,
#'   just that the order of the columns is kept intact.
#'
#' @param ... Additional parameters passed onto [sf::st_as_sf].
#'   By default, `crs = sf::st_crs(4326)` is used, implying longitude and latitude
#'   coordinates.
#'
#' @param input_names A character vector of length two which specifies the
#'   longitude and latitude columns of the input data (the ones that should be
#'   transformed), respectively. Only required if the input data is
#'   a `data.frame` object. Defaults to `c("lon", "lat")`.
#'
#' @param output_names Defunct, this parameter is no longer used. The output
#'   of this function will have a column named `"geometry"` with the transformed
#'   coordinates. This parameter may be removed in a future version.
#'
#' @return An `sf` object containing the transformed coordinates from the
#'   input data frame with the US National Atlas Equal Area projection applied.
#'   The transformed columns will be appended to the data frame so that all
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
#' plot_usmap() + geom_sf(
#'   data = transformed_data,
#'   aes(size = pop),
#'   color = "red", alpha = 0.5
#' )
#'
#' @rdname usmap_transform
#' @export
usmap_transform <- function(data, ...) {
  UseMethod("usmap_transform")
}

#' @rdname usmap_transform
#' @export
usmap_transform.sf <- function(data, ...) {
  perform_transform(data, ...)
}

#' @rdname usmap_transform
#' @export
usmap_transform.data.frame <- function(
  data,
  ...,
  input_names = c("lon", "lat"),
  output_names = NULL
) {
  # ensure input is data.frame
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

  if (!is.null(output_names)) {
    warning("`output_names` is no longer used. This parameter will be removed in a future version of `usmap`.")
  }

  # convert to sf and perform transformation
  data <- sf::st_as_sf(data, coords = input_names)
  perform_transform(data, ...)
}

#' Transform `sf` coordinates to `usmap` transform
#'
#' Internal function with common functionality for transforming coordinates.
#' Using this function directly is not recommended.
#'
#' @keywords internal
perform_transform <- function(data, ...) {
  data_sf <- sf::st_as_sf(data, ...)

  if (is.na(sf::st_crs(data_sf))) {
    crs <- list(...)[["crs"]]
    if (is.null(crs)) crs <- sf::st_crs(4326)
    sf::st_crs(data_sf) <- crs
  }

  # Transform to canonical projection
  transformed <- sf::st_transform(data_sf, usmap_crs())
  sf::st_agr(transformed) <- "constant"

  # Transform Alaska points
  ak_bbox <- usmapdata:::alaska_bbox()
  alaska <- sf::st_intersection(transformed, ak_bbox)
  alaska <- usmapdata:::transform_alaska(alaska)

  # Transform Hawaii points
  hi_bbox <- usmapdata:::hawaii_bbox()
  hawaii <- sf::st_intersection(transformed, hi_bbox)
  hawaii <- usmapdata:::transform_hawaii(hawaii)

  # Transform Puerto Rico points
  pr_bbox <- usmapdata:::puerto_rico_bbox()
  puerto_rico <- sf::st_intersection(transformed, pr_bbox)
  puerto_rico <- usmapdata:::transform_puerto_rico(puerto_rico)

  # Re-combine all points
  transformed_excl_ak <- sf::st_difference(transformed, ak_bbox)
  sf::st_agr(transformed_excl_ak) <- "constant"

  transformed_excl_ak_hi <- sf::st_difference(transformed_excl_ak, hi_bbox)
  sf::st_agr(transformed_excl_ak_hi) <- "constant"

  transformed_excl_ak_hi_pr <- sf::st_difference(transformed_excl_ak_hi, pr_bbox)
  sf::st_agr(transformed_excl_ak_hi_pr) <- "constant"

  rbind(transformed_excl_ak_hi_pr, alaska, hawaii, puerto_rico)
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
  usmapdata:::ea_crs()
}
