#' Population estimates (2022), county level
#'
#' @description US census population estimates by county for 2022. \cr\cr
#'   The data is formatted for easy merging with output from [usmap::us_map()].
#'
#' @usage data(countypop)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 5-digit FIPS code corresponding to the county.
#'   \item \code{abbr} The 2-letter state abbreviation.
#'   \item \code{county} The full county name.
#'   \item \code{pop_2022} The 2022 population estimate (in number of people)
#'     for the corresponding county.
#' }
#'
#' @name countypop
#' @format A data frame with 3222 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/programs-surveys/popest.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets}
#'   }
#' @keywords data
"countypop"

#' Population estimates (2022), state level
#'
#' @description US census population estimates by state for 2022. \cr\cr
#'   The data is formatted for easy merging with output from [usmap::us_map()].
#'
#' @usage data(statepop)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 2-digit FIPS code corresponding to the state.
#'   \item \code{abbr} The 2-letter state abbreviation.
#'   \item \code{full} The full state name.
#'   \item \code{pop_2022} The 2022 population estimate (in number of people)
#'     for the corresponding state.
#' }
#'
#' @name statepop
#' @format A data frame with 52 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/programs-surveys/popest.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets}
#'   }
#' @keywords data
"statepop"

#' Poverty percentage estimates (2021), county level
#'
#' @description US census poverty percentage estimates by county for 2021. \cr\cr
#'   The data is formatted for easy merging with output from [usmap::us_map()].
#'
#' @usage data(countypov)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 5-digit FIPS code corresponding to the county.
#'   \item \code{abbr} The 2-letter state abbreviation.
#'   \item \code{county} The full county name.
#'   \item \code{pct_pov_2021} The 2021 poverty estimate (in percent of county population)
#'     for the corresponding county.
#' }
#'
#' @name countypov
#' @format A data frame with 3194 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/topics/income-poverty/poverty.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets}
#'   }
#' @keywords data
"countypov"

#' Poverty percentage estimates (2021), state level
#'
#' @description US census poverty percentage estimates by state for 2021. \cr\cr
#'   The data is formatted for easy merging with output from [usmap::us_map()].
#'
#' @usage data(statepov)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 2-digit FIPS code corresponding to the state.
#'   \item \code{abbr} The 2-letter state abbreviation.
#'   \item \code{full} The full state name.
#'   \item \code{pct_pov_2021} The 2021 poverty estimate (in percent of state population)
#'     for the corresponding state
#' }
#'
#' @name statepov
#' @format A data frame with 51 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/topics/income-poverty/poverty.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets}
#'   }
#' @keywords data
"statepov"

#' Most populous city in each state (2010)
#'
#' @description The most populous city in each US state, as of the 2010 US Census.\cr\cr
#'   The data is formatted for transforming with [usmap::usmap_transform()].
#'   Once the longitude and latitude is transformed, it can be added to
#'   [usmap::plot_usmap()] using [ggplot2::ggplot()] layers.
#'
#' @usage data(citypop)
#'
#' @details
#' \itemize{
#'   \item \code{lon} The longitude of the most populous city.
#'   \item \code{lat} The latitude of the most populous city.
#'   \item \code{state} The name of the state containing the city.
#'   \item \code{abbr} The abbreviation of the state containing the city.
#'   \item \code{most_populous_city} The name of the city.
#'   \item \code{city_pop} The population of the city.
#' }
#'
#' @name citypop
#' @format A data frame with 51 rows and 5 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/programs-surveys/decennial-census/decade.2010.html}
#'   }
#' @keywords data
"citypop"

#' Earthquakes (2019)
#'
#' @description US earthquakes with a magnitude of 2.5 or greater, occurring in the
#'   first half of 2019, from January 1 to June 30, from USGS.\cr\cr
#'   The data is formatted for transforming with [usmap::usmap_transform()].
#'   Once the longitude and latitude is transformed, it can be added to
#'   [usmap::plot_usmap()] using [ggplot2::ggplot()] layers.
#'
#' @usage data(earthquakes)
#'
#' @details
#' \itemize{
#'   \item \code{lon} The longitude of the earthquake's location.
#'   \item \code{lat} The latitude of the earthquake's location.
#'   \item \code{mag} The magnitude of the earthquake.
#' }
#'
#' @name earthquakes
#' @format A data frame with 2254 rows and 3 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.usgs.gov/programs/earthquake-hazards/earthquakes}
#'     \item \url{https://earthquake.usgs.gov/earthquakes/search/}
#'   }
#' @keywords data
"earthquakes"

#' US Major Rivers (2010)
#'
#' @description Major rivers in the United States.\cr\cr
#'   The data is can be transformed with [usmap::usmap_transform()].
#'   Once the `Shape` strings are transformed, it can be added to
#'   [plot_usmap()] using a [ggplot2::geom_sf()] layer.
#'
#' @usage data(usrivers)
#'
#' @details
#' \itemize{
#'   \item \code{NAME} The name of the river.
#'   \item \code{SYSTEM} The system the river belongs to.
#'   \item \code{MILES} The length of the river in miles.
#'   \item \code{Shape_Length} The length of the river in the coordinate system.
#'   \item \code{Shape} The MULTILINESTRING features depicting the river, for plotting.
#' }
#'
#' @name usrivers
#' @format A simple features (sf) data frame with 55 rows and 5 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.arcgis.com/home/item.html?id=290e4ab8a07f4d2c8392848d011add32#!}
#'     \item Sources: Esri; Rand McNally; Bartholemew and Times Books;
#'     Digital Chart of the World (DCW), U.S. National Geospatial-Intelligence Agency (NGA); i-cubed
#'   }
#' @keywords data
"usrivers"
