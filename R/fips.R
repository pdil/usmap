#' Retrieve FIPS code for either a US state or county
#'
#' @param state The state for which to obtain a FIPS code.
#'  Can be entered as either a state abbrevation or full name (case-insensitive).
#' @param county The county for which to obtain a FIPS code.
#'  Can be entered with or without "county" (case-insensitive).
#' 
#' @note A `state` must be included when searching for `county`,
#'  otherwise multiple results may be returned for duplicate county names.
#' 
#' @return The FIPS code of given \code{state} or \code{county}.
#' @examples 
#' fips("NJ")
#' fips("California")
#' fips("CA", county = "orange")
#' fips(state = "AL", county = "autauga")
#' fips(state = "Alabama", county = "Autauga County")
#' @export
fips <- function(state, county = "") {
  state_ <- tolower(state)
  county_ <- tolower(county)
  
  if (county_ == "") {
    df <- utils::read.csv(system.file("extdata", "state_fips.csv", package = "usmap"))
    abbr <- tolower(df$abbr)
    full <- tolower(df$full)
    
    if (!(state_ %in% abbr) & !(state_ %in% full)) {
      stop(paste(state_, "is not a valid state."))
    } else {
      sprintf("%02d", df$fips[which(abbr == state_ | full == state_)])
    }
  } else {
    df <- utils::read.csv(system.file("extdata", "county_fips.csv", package = "usmap"))
    name <- tolower(df$county)
    state_abbr <- tolower(df$abbr)
    state_full <- tolower(df$full)

    if (!(county_ %in% name) & !(county_ %in% trimws(sub("county", "", name)))) {
      stop(paste(county_, "is not a valid county."))
    } else {
      sprintf("%05d", df$fips[which(
        (name == county_ | name == paste(county_, "county")) & 
          (state_abbr == state_ | state_full == state_)
      )])
    }
  }
}

#' @export
fips_info <- function(fips) {
  if (is.numeric(fips) & fips >= 1001 & fips <= 56043) {
    fips_ <- sprintf("%05d", fips)
  } else if (is.numeric(fips) & fips >= 1 & fips <= 56) {
    fips_ <- sprintf("%02d", fips)
  } else if (is.character(fips)) {
    fips_ <- fips
  } else {
    stop("`fips` must be a numeric or character type.")
  }
  
  if (nchar(fips_) == 2) {
    df <- utils::read.csv(system.file("extdata", "state_fips.csv", package = "usmap"))
    df[df$fips == fips_, ]
  } else if (nchar(fips_) == 5) {
    df <- utils::read.csv(system.file("extdata", "county_fips.csv", package = "usmap"))
    df[df$fips == fips_, ]
  } else {
    stop("Invalid FIPS code `fips`.")
  }
}
