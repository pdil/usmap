#' usmap: US maps including Alaska and Hawaii
#'
#' @description
#' It is usually difficult or inconvenient to create US maps that
#'   include both Alaska and Hawaii in a convenient spot. All map
#'   data frames produced by this package use the Albers Equal Area
#'   projection.
#'
#' @section Map data frames:
#' Alaska and Hawaii have been manually moved to a new location so that
#' their new coordinates place them to the bottom-left corner of
#' the map. These maps can be accessed by using the \code{\link{usmap}} function.
#'
#' The function provides the ability to retrieve maps with either
#' state borders or county borders using the \code{regions} parameter
#' for convenience.
#'
#' States (or counties) can be included such that all other states (or counties)
#' are excluded using the \code{include} parameter.
#'
#' @section FIPS lookup tools:
#' Several functions have been included to lookup the US state or county
#' pertaining to a FIPS code.
#'
#' Likewise a reverse lookup can be done where a FIPS code can be used to
#' retrieve the associated state(s) or county(ies). This can be useful when
#' preparing data to be merged with the map data frame.
#'
#' @section Plot US map data:
#' A convenience function \code{\link{plot_usmap}} has been included which
#' takes similar parameters to \code{\link{us_map}} and returns a \pkg{ggplot2}
#' object. Since the output is a \code{ggplot} object, other layers can be
#' added such as scales, themes, and labels. Including data in the function call
#' will color the map according to the values in the data, creating a choropleth.
#'
#' @author Paolo Di Lorenzo \cr
#' \itemize{
#'   \item Email: \email{paolo@@dilorenzo.pl}
#'   \item Website: \url{http://dilorenzo.pl}
#'   \item Twitter: \url{http://twitter.com/dilorenzopl}
#'   \item Github: \url{http://www.github.com/pdil/}
#' }
#'
#' @seealso
#' Helpful links:
#' \itemize{
#'   \item FIPS code information \cr
#'     \url{http://en.wikipedia.org/wiki/FIPS_county_code}
#'     \url{http://en.wikipedia.org/wiki/FIPS_state_code}
#'   \item US Census Shapefiles \cr
#'     \url{https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html}
#'   \item Map Features \cr
#'     \url{https://en.wikipedia.org/wiki/Map_projection}
#'     \url{https://en.wikipedia.org/wiki/Albers_projection}
#'     \url{https://en.wikipedia.org/wiki/Choropleth}
#' }
#'
#' @references
#' Rudis, Bob. "Moving The Earth (well, Alaska & Hawaii) With R."
#' Blog post. Rud.is., 16 Nov. 2014. Web. 10 Aug. 2015.
#' <\url{https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/}>.
#'
#' @docType package
#' @name usmap
"_PACKAGE"

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

  regions_ <- match.arg(regions)

  if (regions_ == "state") regions_ <- "states"
  else if (regions_ == "county") regions_ <- "counties"

  df <- utils::read.csv(system.file("extdata", paste0("us_", regions_, ".csv"), package = "usmap"),
                        colClasses = col_classes(regions_),
                        stringsAsFactors = FALSE)

  if (length(include) > 0) {
    df <- df[df$full %in% include |
               df$abbr %in% include |
               df$fips %in% include |
               substr(df$fips, 1, 2) %in% include, ]
  }

  if (length(exclude) > 0) {
    df <- df[!(df$full %in% exclude |
                 df$abbr %in% exclude |
                 df$fips %in% exclude |
                 substr(df$fips, 1, 2) %in% exclude), ]
  }

  df
}

#' Map data column classes
#'
#' @keywords internal
col_classes <- function(regions) {
  result <- c("numeric", "numeric", "integer", "logical", "integer", rep("character", 4))

  if (regions %in% c("county", "counties")) {
    result <- c(result, "character")    # add extra column for county name
  }

  result
}
