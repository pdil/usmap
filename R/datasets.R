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
#'   \item \code{full} The full state name.
#'   \item \code{pop_est_2015} The 2015 population estimate (in number of people)
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
#'   \item \code{pop_est_2015} The 2015 population estimate (in number of people)
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
