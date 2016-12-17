#' Retrieve FIPS code for either a US state or county
#'
#' @param state The state for which to obtain a FIPS code.
#' @param county The county for which to obtain a FIPS code.
#' 
#' @note A `state` must be included when searching for `county`,
#'  otherwise multiple results may be returned for duplicate county names.
#' 
#' @return The FIPS code of given `state` or `county`.
#' @examples 
#' fips(state = "NJ")
#' fips(state = "California")
#' fips(state = "AL", county = "autauga")
#' @export
fips <- function(state, county = "") {
  state_ <- tolower(state)
  county_ <- tolower(county)
  
  if (county_ == "") {
    df <- read.csv(system.file("extdata", "state_fips.csv", package = "usmap"))
    abbr <- tolower(df$abbr)
    full <- tolower(df$full)
    
    if (!(state_ %in% abbr) & !(state_ %in% full)) {
      stop(paste(state_, "is not a valid state."))
    } else {
      sprintf("%02d", df$fips[which(abbr == state_ | full == state_)])
    }
  } else {
    df <- read.csv(system.file("extdata", "county_fips.csv", package = "usmap"))
    name <- tolower(df$county)
    state_abbr <- tolower(df$state)

    if (!(county_ %in% name) & !(county_ %in% trimws(sub("county", "", name)))) {
      stop(paste(county_, "is not a valid county."))
    } else {
      sprintf("%05d", df$fips[which(
        (name == county_ | name == paste(county_, "county")) & state_abbr == state_
      )])
    }
  }
}
