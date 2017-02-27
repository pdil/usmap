#' Join county or state level data to US map data
#'
#' @param data The data that should be joined to a US map. This
#'   parameter should be a data frame consisting of two columns,
#'   a fips code (2 characters for state, 5 characters for county)
#'   and the value that should be associated with that region. The
#'   columns of \code{data} _must_ be \code{fips} and \code{value}.
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
#' map_with_data(state_data, na = 0)
#' @export
map_with_data <- function(data, na = NA) {
  if (!is.data.frame(data) || ncol(data) != 2 || !("fips" %in% names(data)) || !("value" %in% names(data))) {
    stop("`data` must be a data frame with two columns, `fips` and `value`")
  }

  if (length(data$fips) < 1) {
    stop("`data` must have at least one row")
  }

  if (!is.character(data$fips)) {
    stop("The `fips` column must be of type `character`")
  }

  map_df <- us_map(regions = ifelse(nchar(data$fips[1]) == 2, "state", "county"))

  result <- merge(map_df, data, by = "fips", all.x = TRUE, sort = FALSE)
  result$value[is.na(result$value)] <- na
  result <- result[c(setdiff(names(result), names(data)), names(data))]

  result
}
