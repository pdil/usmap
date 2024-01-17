#' Join county or state level data to US map data
#'
#' @inheritParams us_map
#' @param data The data that should be joined to a US map. This
#'   parameter should be a data frame consisting of two columns,
#'   a fips code (2 characters for state, 5 characters for county)
#'   and the value that should be associated with that region. The
#'   columns of \code{data} \emph{must} be \code{fips} or \code{state} and
#'   the value of the `values` parameter. If both \code{fips} and \code{state}
#'   are provided, this function uses the \code{fips}.
#' @param values The name of the column that contains the values to be associated
#'   with a given region. The default is \code{"values"}.
#' @param na The value to be inserted for states or counties that don't have
#'   a value in \code{data}. This value must be of the same type as the \code{value}
#'   column of \code{data}.
#'
#' @return A data frame composed of the map data frame (from \code{\link{us_map}}) except
#'   an extra column containing the values in \code{data} is included.
#'
#'   The result can be plotted using \code{ggplot2}. See \code{\link{us_map}} or
#'   \code{\link{plot_usmap}} for more details.
#'
#' @examples
#' state_data <- data.frame(fips = c("01", "02", "04"), values = c(1, 5, 8))
#' df <- map_with_data(state_data, na = 0)
#'
#' state_data <- data.frame(state = c("AK", "CA", "Utah"), values = c(6, 9, 3))
#' df <- map_with_data(state_data, na = 0)
#'
#' @export
map_with_data <- function(data,
                          values = "values",
                          include = c(),
                          exclude = c(),
                          na = NA) {

  if (!is.data.frame(data)) {
    stop("`data` must be a data frame")
  }

  if (nrow(data) == 0) {
    if (length(include) == 0) {
      region_type <- "state"
    } else {
      region_type <- ifelse(nchar(include[1]) == 2, "state", "county")
    }

    warning(paste("`data` is empty, returning basic", region_type, "US map data frame"))
    return(usmap::us_map(regions = region_type, include = include, exclude = exclude))
  }

  if (!(values %in% names(data))) {
    stop(paste0("\"", values, "\" column not found in `data`."))
  }

  if ("fips" %in% names(data)) {
    # do nothing
  } else if ("state" %in% names(data)) {
    # convert to fips
    data$fips <- usmap::fips(data$state)
  } else {
    # error
    stop("`data` must be a data.frame containing either a `state` or `fips` column.")
  }

  data$fips <- as.character(data$fips)

  region_type <- ifelse(nchar(data$fips[1]) <= 2, "state", "county")
  map_df <- usmap::us_map(regions = region_type, include = include, exclude = exclude)

  # Remove columns in data that are already in map_df
  data$abbr <- NULL
  data$full <- NULL
  data$county <- NULL
  data$geom <- NULL
  #

  padding <- ifelse(region_type == "state", 2, 5)
  data$fips <- sprintf(paste0("%0", padding, "d"), as.numeric(data$fips))

  result <- merge(map_df, data, by = "fips", all.x = TRUE, sort = FALSE)
  result[is.na(result[, values]), values] <- na

  result <- result[, c(setdiff(names(result), names(data)), names(data))]

  if (region_type == "state") {
    result <- result[order(result$full), ]
  } else {
    result <- result[order(result$full, result$county), ]
  }

  result
}
