#' Retrieve FIPS code for either a US state or county
#'
#' @param state The state for which to obtain a FIPS code.
#' @param county The county for which to obtain a FIPS code.
#' 
#' @note Either a `state` or a `county` should be specified, but not both.
#' 
#' @return The FIPS code of given `state` or `county`.
#' @examples 
#' print("Examples will go here.")
fips <- function(state = "", county = "") {
  state_ <- tolower(state)
  county_ <- tolower(county)
  
  if (state_ != "" & county_ != "") {
    stop("Please enter EITHER a `state` or a `county`, not both.")
  }
  
  if (state_ != "") {
    df <- read.csv(system.file("extdata", "state_fips.csv", package = "usmap"))
    abbr <- tolower(df$abbr)
    full <- tolower(df$full)
    
    if (!(state_ %in% abbr) & !(state_ %in% full)) {
      stop(paste(state_, "is not a valid state.") 
    } else {
      if (state_ %in% abbr) {
        as.character(df$fips[which(abbr == state_)])
      } else {
        as.character(df$fips[which(full == state_)])
      }
    }
  } else {
    df <- read.csv(system.file("extdata", "county_fips.csv", package = "usmap"))
    name <- tolower(df$county)
    
    if (!county_ %in% name) {
      stop(paste(county_, "is not a valid county.")  
    } else {
      as.character(df$fips[which(name == county_)])  
    }
  }
}
