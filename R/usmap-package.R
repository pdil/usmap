#' usmap: US maps including Alaska and Hawaii
#'
#' @description
#' It is usually difficult or inconvenient to create US maps that
#'   include both Alaska and Hawaii in a convenient spot. All map
#'   data presented in this package uses the US National Atlas Equal Area
#'   projection.
#'
#' @section Map data:
#' Alaska and Hawaii have been manually moved to a new location so that
#' their new coordinates place them to the bottom-left corner of
#' the map. These maps can be accessed by using the [us_map()] function.
#'
#' The function provides the ability to retrieve maps with either
#' state borders or county borders using the \code{regions} parameter
#' for convenience.
#'
#' States (or counties) can be included and excluded using the provided
#' \code{include} and \code{exclude} parameters. These parameters can be used
#' together with any combination of names, abbreviations, or FIPS code to
#' create more complex maps.
#'
#' @section FIPS lookup tools:
#' Several functions have been included to lookup the US state or county
#' pertaining to a FIPS code.
#'
#' Likewise a reverse lookup can be done where a FIPS code can be used to
#' retrieve the associated states or counties. This can be useful when
#' preparing data to be merged with the map data frame.
#'
#' @section Plot US map data:
#' A convenience function [plot_usmap()] has been included which
#' takes similar parameters to [us_map()] and returns a [ggplot2::ggplot2]
#' object. Since the output is a \code{ggplot} object, other layers can be
#' added such as scales, themes, and labels. Including data in the function call
#' will color the map according to the values in the data, creating a choropleth.
#'
#' @section Transforming data:
#' It is also possible to add spatial data to the map, in the form of either
#' data frames or simple features ([sf::sf]) objects. If necessary, the
#' data can be transformed to be in the same coordinate reference system as
#' [usmap] by using [usmap_transform()] and then plotted using [ggplot2::geom_sf()].
#'
#' @author Paolo Di Lorenzo \cr
#' \itemize{
#'   \item Email: \email{dilorenzo@@hey}
#'   \item GitHub: \url{https://github.com/pdil/}
#' }
#'
#' @seealso
#' Helpful links:
#' \itemize{
#'   \item FIPS code information \cr
#'     \url{https://en.wikipedia.org/wiki/FIPS_county_code}
#'     \url{https://en.wikipedia.org/wiki/FIPS_state_code}
#'   \item US Census Shapefiles \cr
#'     \url{https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html}
#'   \item Map Features \cr
#'     \url{https://en.wikipedia.org/wiki/Map_projection} \cr
#'     \url{https://en.wikipedia.org/wiki/Equal-area_projection} \cr
#'     \url{https://en.wikipedia.org/wiki/Choropleth} \cr
#'     \url{https://epsg.io/9311} (US National Atlas Equal Area)
#' }
#'
#' @references
#' Rudis, Bob. "Moving The Earth (well, Alaska & Hawaii) With R."
#' Blog post. Rud.is., 16 Nov. 2014. Web. 10 Aug. 2015.
#' \url{https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/}.
#'
#' @docType package
#' @name usmap
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
