context("Retrieving FIPS codes")

test_that("returns correct FIPS code for NJ", {
  expect_match(fips(state = "NJ"), "34")
})

test_that("returns correct FIPS code for NEW JERSEY", {
  expect_match(fips(state = "NEW JERSEY"), "34")
})

test_that("error occurs for entering both state and county", {
  expect_error(fips(state = "NJ", county = "Mercer"))
})