## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----fig.align='center', fig.width=7------------------------------------------
usmap::plot_usmap()

## ----fig.align='center', fig.width=7------------------------------------------
usmap::plot_usmap(regions = "counties")

## ----eval = FALSE-------------------------------------------------------------
# states_df <- usmap::us_map()
# counties_df <- usmap::us_map(regions = "counties")

## -----------------------------------------------------------------------------
# Get FIPS code for a state
usmap::fips(state = "MA")
usmap::fips(state = "Massachusetts")

# Get FIPS code for a county
usmap::fips(state = "NJ", county = "Bergen")
usmap::fips(state = "CA", county = "Orange County")

# The parameters are NOT case sensitive!
usmap::fips(state = "ca", county = "oRanGe cOUNty")

## -----------------------------------------------------------------------------
usmap::fips_info(c("30", "33", "34"))

## -----------------------------------------------------------------------------
usmap::fips_info(c("01001", "01003", "01005", "01007"))

