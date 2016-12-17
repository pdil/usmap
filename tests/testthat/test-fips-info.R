context("Retrieving FIPS code info")

test_that("returns correct state FIPS information", {
  ak_result <- data.frame(abbr = "AK", fips = "02", full = "Alaska", stringsAsFactors = FALSE)
  
  expect_equivalent(fips_info(2), ak_result)
  expect_equivalent(fips_info("2"), ak_result)
  expect_equivalent(fips_info("02"), ak_result)
})

test_that("returns correct county FIPS information", {
  ak_result <- data.frame(
    full = "Alaska", 
    abbr = "AK", 
    county = "Aleutians West Census Area", 
    fips = "02016",
    stringsAsFactors = FALSE
  )
  
  expect_equivalent(fips_info(2016), ak_result)
  expect_equivalent(fips_info("02016"), ak_result)
})