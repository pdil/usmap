#' Join county or state level data to US map data
#'
#' @param data The data that should be joined to a US map. This
#'   parameter should be a data frame consisting of two columns,
#'   a fips code (2 characters for state, 5 characters for county)
#'   and the value that should be associated with that region. The
#'   columns of \code{data} _must_ be \code{fips} and the value of the
#'   `values` parameter.
#' @param values The name of the column that contains the values to be associated
#'   with a given region. The default is \code{"value"}.
#' @param na The value to be inserted for states or counties that don't have
#'   a value in \code{data}. This value must be of the same type as the \code{value}
#'   column of \code{data}.
#'
#' @return A data frame composed of the map data frame (from \code{\link{us_map}}) except
#'   an extra column containing the values in \code{data} is included.
#'
#'   The result can be plotted using \code{ggplot2}. See \code{\link{us_map}} for more details.
#'
#' @examples
#' state_data <- data.frame(fips = c("01", "02", "04"), value = c(1, 5, 8))
#' df <- map_with_data(state_data, na = 0)
#' str(df)
#'
#' @export
map_with_data <- function(data, values = "value", na = NA) {
  if (!is.data.frame(data) || ncol(data) != 2 || !("fips" %in% names(data)) || !(values %in% names(data))) {
    stop(paste0("`data` must be a data frame with two columns, `fips` and `", values, "`"))
  }

  if (length(data$fips) < 1) {
    stop("`data` must have at least one row")
  }

  data$fips <- as.character(data$fips)

  region_type <- ifelse(nchar(data$fips[1]) == 2, "state", "county")

  map_df <- us_map(regions = region_type)

  result <- merge(map_df, data, by = "fips", all.x = TRUE, sort = FALSE)
  result[is.na(result[, values]), values] <- na
  result <- result[c(setdiff(names(result), names(data)), names(data))]

  if (region_type == "state") {
    result <- result <- result[order(result$full, result$piece, result$order), ]
  } else {
    result <- result <- result[order(result$full, result$county, result$piece, result$order), ]
  }

  result
}
