#' usmap: US maps including Alaska and Hawaii
#' 
#' It is usually difficult or inconvenient to create US maps that
#'   include both Alaska and Hawaii in a convenient spot. 
#'   
#' 
#' @section Map data frames  
#' Alaska and Hawaii have been manually moved to a new location so that
#'   their new coordinates place them to the bottom-left corner of
#'   the map. These maps can be accessed by using the \code{usmap} function.
#'   
#' The function provides the ability to retrieve maps with either
#'   state borders or county borders using the \code{regions} parameter 
#'   for convenience.
#'   
#' States (or counties) can be included such that all other states (or counties)
#'   are excluded using the \code{include} parameter.
#'   
#' @section FIPS lookup tools
#' Several functions have been included to lookup the US state or county
#'   pertaining to a FIPS code.
#'   
#' Likewise a reverse lookup can be done where a FIPS code can be used to
#'   retrieve the associated state(s) or county(ies). This can be useful when
#'   preparing data to be merged with the map data frame.
#'   
#' @section Merge data with map
#' Before plotting, the data can be merged with the map data frame internally
#'   and returned as a complete data frame, ready for use. This is done by using
#'   a data frame in which each row is identified by a state, county, or FIPS
#'   code (and specifying which type). The returned data frame can be easily
#'   plotted with \code{base::plot} or \code{ggplot2} (or any other plotting solution).
#'   
#' @docType package
#' @name usmap
NULL

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
