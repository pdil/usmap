#' Retrieve US map data
#'
#' @param regions The region breakdown for the map, can be one of
#'   (\code{"states"}, \code{"state"}, \code{"counties"}, \code{"county"}).
#'   The default is \code{"states"}.
#' @param include The regions to include in the resulting map. If \code{regions} is
#'  \code{"states"}/\code{"state"}, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name. If states are provided in the county map, only counties in the included states
#'  will be returned.
#' @param exclude The regions to exclude in the resulting map. If \code{regions} is
#'  \code{"states"}/\code{"state"}, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name. The regions listed in the \code{include} parameter are applied first and the
#'  \code{exclude} regions are then removed from the resulting map. Any excluded regions
#'  not present in the included regions will be ignored.
#'
#' @seealso [usmapdata::us_map()] of which this function is a wrapper for.
#'
#' @return A data frame of US map coordinates divided by the desired \code{regions}.
#'
#' @examples
#' str(us_map())
#'
#' df <- us_map(regions = "counties")
#' west_coast <- us_map(include = c("CA", "OR", "WA"))
#'
#' south_atl_excl_FL <- us_map(include = .south_atlantic, exclude = "FL")
#' @export
us_map <- function(regions = c("states", "state", "counties", "county"),
                   include = c(),
                   exclude = c()) {
  usmapdata::us_map(regions = regions, include = include, exclude = exclude)
}
