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
  if (state != "" & county != "") {
    stop("Please enter EITHER a `state` or a `county`, not both.")
  }
  
  if (state != "") {
    df <- read.csv(system.file("extdata", "state_fips.csv", package = "usmap"))
    
    if (!(state %in% df$abbr) & !(state %in% df$full)) {
      stop("The `state` you entered is invalid.")
    } else {
      if (state %in% df$abbr) {
        as.character(df$fips[which(df$abbr == state)])
      } else {
        as.character(df$fips[which(df$full == state)])
      }
    }
  } else {
    0
  }
}