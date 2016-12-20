#' Retrieve US map data
#'
#' @param regions The region breakdown for the map, either \code{"states"}
#'  or \code{"counties"}.
#' @param include The regions to include in the output data frame. If \code{regions} is
#'  \code{"states"}, the value can be either a state name, abbreviation or FIPS code. 
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name.
#'
#' @return A data frame of US map coordinates divided by the desired \code{regions}.
#' @examples
#' df <- us_map(regions = "states")
#' plot(df$long, df$lat)
#' @export
us_map <- function(regions, include = c()) {
  if (regions %in% c("states", "counties", "state", "county")) {
    if (regions == "state") {
      regions_ <- "states"
    } else if (regions == "county") {
      regions_ <- "counties"
    } else {
      regions_ <- regions
    }
    
    df <- utils::read.csv(system.file("extdata", paste0("us_", regions_, ".csv"), package = "usmap"))

    if (length(include) > 0) {
      if (regions_ %in% c("counties", "county")) {
        df <- df[sprintf("%05d", df$fips) %in% include, ]
      } else {
        df <- df[df$full %in% include | df$abbr %in% include | sprintf("%02d", df$fips) %in% include, ]
      }
    }

    df
  } else {
    stop("Regions must be either `states`, `state`, `counties`, or `county`.")
  }
}
