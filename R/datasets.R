#' Population estimates (2015), county level
#'
#' @description US census population estimates by county for 2015. \cr\cr
#'   The data is formatted for easy merging with output from \code{\link[usmap]{us_map}}.
#'
#' @usage data(countypop)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 5-digit FIPS code corresponding to the county.
#'   \item \code{abbr} The 2-letter state abbrevation.
#'   \item \code{county} The full county name.
#'   \item \code{pop_2015} The 2015 population estimate (in number of people)
#'     for the corresponding county.
#' }
#'
#' @name countypop
#' @format A data frame with 3142 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{http://www.census.gov/programs-surveys/popest.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets/download-data.aspx}
#'   }
#' @keywords data
"countypop"

#' Population estimates (2015), state level
#'
#' @description US census population estimates by state for 2015. \cr\cr
#'   The data is formatted for easy merging with output from \code{\link[usmap]{us_map}}.
#'
#' @usage data(statepop)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 2-digit FIPS code corresponding to the state.
#'   \item \code{abbr} The 2-letter state abbrevation.
#'   \item \code{full} The full state name.
#'   \item \code{pop_2015} The 2015 population estimate (in number of people)
#'     for the corresponding state.
#' }
#'
#' @name statepop
#' @format A data frame with 51 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{http://www.census.gov/programs-surveys/popest.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets/download-data.aspx}
#'   }
#' @keywords data
"statepop"

#' Poverty percentage estimates (2014), county level
#'
#' @description US census poverty percentage estimates by county for 2014. \cr\cr
#'   The data is formatted for easy merging with output from \code{\link[usmap]{us_map}}.
#'
#' @usage data(countypov)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 5-digit FIPS code corresponding to the county.
#'   \item \code{abbr} The 2-letter state abbrevation.
#'   \item \code{county} The full county name.
#'   \item \code{pct_pov_2014} The 2014 poverty estimate (in percent of county population)
#'     for the corresponding county.
#' }
#'
#' @name countypov
#' @format A data frame with 3142 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/topics/income-poverty/poverty.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets/download-data.aspx}
#'   }
#' @keywords data
"countypov"

#' Poverty percentage estimates (2014), state level
#'
#' @description US census poverty percentage estimates by state for 2014. \cr\cr
#'   The data is formatted for easy merging with output from \code{\link[usmap]{us_map}}.
#'
#' @usage data(statepov)
#'
#' @details
#' \itemize{
#'   \item \code{fips} The 2-digit FIPS code corresponding to the state.
#'   \item \code{abbr} The 2-letter state abbrevation.
#'   \item \code{full} The full state name.
#'   \item \code{pct_pov_2014} The 2014 poverty estimate (in percent of state population)
#'     for the corresponding state
#' }
#'
#' @name statepov
#' @format A data frame with 51 rows and 4 variables.
#' @docType data
#' @references
#'   \itemize{
#'     \item \url{https://www.census.gov/topics/income-poverty/poverty.html}
#'     \item \url{https://www.ers.usda.gov/data-products/county-level-data-sets/download-data.aspx}
#'   }
#' @keywords data
"statepov"
