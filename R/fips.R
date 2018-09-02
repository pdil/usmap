#' Retrieve FIPS code for either a US state or county
#'
#' @description Each US state and county has a unique FIPS
#'   (Federal Information Processing Standards) code. Use
#'   this function to obtain the FIPS code for a state or
#'   county.
#'
#' @param state The state(s) for which to obtain a FIPS code(s).
#'  Can be entered as either a state abbreviation or full name (case-insensitive).
#'
#'  `state` can be entered as either a single state or a vector of states.
#'  If `state` is a vector, `county` must be omitted.
#'
#' @param county The county for which to obtain a FIPS code.
#'  Can be entered with or without "county" (case-insensitive).
#'
#' @note A \code{state} must be included when searching for \code{county},
#'  otherwise multiple results may be returned for duplicate county names.
#'
#' @details State and county FIPS (Federal Information Processing Standards) are
#'   two and five digit codes, respectively. They uniquely identify all states and
#'   counties within the United States. The first two digits of the five digit county
#'   codes correspond to the state that the county belongs to. FIPS codes also exist
#'   for US territories and minor outlying islands, though this package only provides
#'   information for the 50 US states (and their associated counties and
#'   census designated areas).
#'
#' @return The FIPS code(s) of given \code{state} or \code{county}.
#'
#' If only states are entered, a vector of length equal to the number of states
#' is returned. If any states are not found or are invalid, `NA` is returned in their place.
#'
#' If a state and county are entered, a single value with the FIPS code
#' for the given county is returned. If the county is invalid for the given state,
#' an error is thrown.
#'
#' @examples
#' fips("NJ")
#' fips("California")
#'
#' fips(c("AK", "CA", "UT"))
#'
#' fips("CA", county = "orange")
#' fips(state = "AL", county = "autauga")
#' fips(state = "Alabama", county = "Autauga County")
#' @export
fips <- function(state, county = c()) {
  if (missing(state)) {
    stop("`state` must be specified. Use full name (e.g. \"Alabama\") or two-letter abbreviation (e.g. \"AL\").")
  }

  state_ <- tolower(state)
  county_ <- tolower(county)

  if (length(county_) == 0) {
    df <- utils::read.csv(system.file("extdata", "state_fips.csv", package = "usmap"))
    abbr <- tolower(df$abbr)
    full <- tolower(df$full)
    fips2 <- c(df$fips, df$fips)

    result <- fips2[match(state_, c(abbr, full))]

    formatted_result <- sprintf("%02d", result)
    formatted_result[formatted_result == "NA"] <- NA
    formatted_result
  } else {
    if (length(state_) > 1) {
      stop("`county` parameter cannot be used with multiple states.")
    }

    df <- utils::read.csv(system.file("extdata", "county_fips.csv", package = "usmap"))
    name <- tolower(df$county)
    state_abbr <- tolower(df$abbr)
    state_full <- tolower(df$full)

    result <- c()

    for (county_i in county_) {
      result <- c(
        result,
        df$fips[which(
          (name %in% county_i | name %in% paste(county_i, "county"))
          &
          (state_abbr %in% state_ | state_full %in% state_)
        )]
      )
    }

    if (length(result) == 0) {
      if (length(county) == 1) {
        stop(paste0(county, " is not a valid county in ", state, ".\n"))
      } else {
        stop(paste0(county, " are not valid counties in ", state, ".\n"))
      }
    } else {
      sprintf("%05d", result)
    }
  }
}

#' Retrieve states or counties using FIPS codes
#'
#' @param fips A one to five digit, either \code{numeric}
#'  or \code{character}, vector of FIPS codes for which to look up states or counties.
#'  States have a two digit FIPS code and counties have a five digit FIPS
#'  code (where the first 2 numbers pertain to the state).
#'
#' @return A data frame with the states or counties and the associated
#'  FIPS codes.
#'
#' @examples
#' fips_info(2)
#' fips_info("2")
#' fips_info(c("02", "03", "04"))
#'
#' fips_info(2016)
#' fips_info(c("02016", "02017"))
#'
#' @rdname fips_info
#' @export
fips_info <- function(fips) {
  UseMethod("fips_info", fips)
}

#' @rdname fips_info
#' @export
fips_info.numeric <- function(fips) {
  if (all(fips >= 1001 & fips <= 56043)) {
    fips_ <- sprintf("%05d", fips)
  } else if (all(fips >= 1 & fips <= 56)) {
    fips_ <- sprintf("%02d", fips)
  } else {
    stop("Invalid FIPS code(s), must be either 2 digit (states) or 5 digit (counties), but not both.")
  }

  getFipsInfo(fips_)
}

#' @rdname fips_info
#' @export
fips_info.character <- function(fips) {
  if (all(nchar(fips) %in% 4:5)) {
    fips_ <- sprintf("%05s", fips)
  } else if (all(nchar(fips) %in% 1:2)) {
    fips_ <- sprintf("%02s", fips)
  } else {
    stop("Invalid FIPS code, must be either 2 digit (states) or 5 digit (counties), but not both.")
  }

  getFipsInfo(fips_)
}

#' Gets FIPS info for either states or counties depending on input.
#' Helper function for S3 method \code{fips_info}.
#' @keywords internal
getFipsInfo <- function(fips) {
  if (all(nchar(fips) == 2)) {
    df <- utils::read.csv(
      system.file("extdata", "state_fips.csv", package = "usmap"),
      colClasses = rep("character", 3), stringsAsFactors = FALSE
    )

    result <- df[df$fips %in% fips, ]
  } else if (all(nchar(fips) == 5)) {
    df <- utils::read.csv(
      system.file("extdata", "county_fips.csv", package = "usmap"),
      colClasses = rep("character", 4), stringsAsFactors = FALSE
    )

    result <- df[df$fips %in% fips, ]
  }

  # Present warning if no results found.
  if (nrow(result) == 0) {
    warning(paste("FIPS code(s)", toString(fips), "not found, returned 0 results."))
  }

  # Present warning if any FIPS codes included are not found.
  if (!all(fips %in% result$fips)) {
    excluded_fips <- fips[which(!fips %in% result$fips)]
    warning(paste("FIPS code(s)", toString(excluded_fips), "not found, excluded from result."))
  }

  rownames(result) <- NULL
  result
}

