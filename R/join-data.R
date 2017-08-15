#' Join county or state level data to US map data
#'
#' @param data The data that should be joined to a US map. This
#'   parameter should be a data frame consisting of two columns,
#'   a fips code (2 characters for state, 5 characters for county)
#'   and the value that should be associated with that region. The
#'   columns of \code{data} \emph{must} be \code{fips} and the value of the
#'   `values` parameter.
#' @param values The name of the column that contains the values to be associated
#'   with a given region. The default is \code{"values"}.
#' @param include The regions to include in the output data frame. If \code{regions} is
#'  \code{"states"}/\code{"state"}, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name.
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
#' state_data <- data.frame(fips = c("01", "02", "04"), values = c(1, 5, 8))
#' df <- map_with_data(state_data, na = 0)
#'
#' @export
map_with_data <- function(data, values = "values", include = c(), na = NA) {
  if (nrow(data) == 0) {
    if (length(include) == 0) {
      region_type <- "state"
    } else {
      region_type <- ifelse(nchar(include[1]) == 2, "state", "county")
    }

    warning(paste("`data` is empty, returning basic", region_type, "US map data frame"))
    return(us_map(regions = region_type, include = include))
  }

  if (!is.data.frame(data) || !("fips" %in% names(data)) || !(values %in% names(data))) {
    stop(paste0("* `data` must be a data frame with columns `fips` and `", values,
                "`\n  * Make sure the `values` parameter has been set correctly."))
  }

  data$fips <- as.character(data$fips)

  region_type <- ifelse(nchar(data$fips[1]) <= 2, "state", "county")
  map_df <- us_map(regions = region_type, include = include)

  df <- data[, c("fips", values)]

  padding <- ifelse(region_type == "state", 2, 5)
  df$fips <- stringr::str_pad(df$fips, width = padding, side = "left", pad = "0")

  result <- merge(map_df, df, by = "fips", all.x = TRUE, sort = FALSE)
  result[is.na(result[, values]), values] <- na
  result <- result[, c(setdiff(names(result), names(df)), names(df))]

  if (region_type == "state") {
    result <- result <- result[order(result$full, result$piece, result$order), ]
  } else {
    result <- result <- result[order(result$full, result$county, result$piece, result$order), ]
  }

  result
}
