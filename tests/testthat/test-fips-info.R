context("Retrieving FIPS code info")

test_that("returns correct FIPS information", {
  ak_result <- data.frame(abbr = "AK", fips = "02", full = "Alaska", stringsAsFactors = FALSE)
  
  expect_equivalent(fips_info(2), ak_result)
  expect_equivalent(fips_info("2"), ak_result)
  expect_equivalent(fips_info("02"), ak_result)
})