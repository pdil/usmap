#' Retrieve US map data
#'
#' @param regions The region breakdown for the map, can be one of
#'   (`"states"`, `"state"`, `"counties"`, `"county"`).
#'   The default is `"states"`.
#' @param include The regions to include in the resulting map. If `regions` is
#'  `"states"`/`"state"`, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name. If states are provided in the county map, only counties in the included states
#'  will be returned.
#' @param exclude The regions to exclude in the resulting map. If `regions` is
#'  `"states"`/`"state"`, the value can be either a state name, abbreviation or FIPS code.
#'  For counties, the FIPS must be provided as there can be multiple counties with the
#'  same name. The regions listed in the `include` parameter take precedence over
#'  regions listed in `exclude`. If both parameters include the same region(s) they
#'  will be included in the map.
#' @param data_year The year for which to obtain map data.
#'  If the value is `NULL`, the most recent year's data is used. If the
#'  provided year is not found from the available map data sets, the next most
#'  recent year's data is used. This can be used if an older data set is being
#'  plotted on the US map so that the data matches the map more accurately.
#'  Therefore, the provided value should match the year of the plotted data set.
#'  The default is `NULL`, i.e. the most recent available year is used.
#'
#' @seealso [usmapdata::us_map()] of which this function is a wrapper for.
#'
#' @return An `sf` data frame of US map coordinates divided by the desired `regions`.
#'
#' @examples
#' str(us_map())
#'
#' df <- us_map(regions = "counties")
#' west_coast <- us_map(include = c("CA", "OR", "WA"))
#'
#' excl_west_coast <- us_map(exclude = c("CA", "OR", "WA"))
#'
#' ct_counties_as_of_2022 <- us_map(regions = "counties", include = "CT", data_year = 2022)
#' @export
us_map <- function(
  regions = c("states", "state", "counties", "county"),
  include = c(),
  exclude = c(),
  data_year = NULL
) {
  usmapdata::us_map(
    regions = regions,
    include = include,
    exclude = exclude,
    data_year = data_year
  )
}
