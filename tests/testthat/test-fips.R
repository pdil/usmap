context("Retrieving FIPS codes")

test_that("returns correct FIPS code for NJ", {
  expect_match(fips(state = "NJ"), "34")
  expect_match(fips(state = "New Jersey"), "34")
})

test_that("returns correct FIPS code for Mercer County, NJ", {
  expect_equal(fips(county = "Mercer County"), "34021")
})

test_that("error occurs for entering both state and county", {
  expect_error(fips(state = "NJ", county = "Mercer County"))
})

test_that("error occurs for invalid state", {
  expect_error(fips(state = "Puerto Rico"))
})

test_that("error occurs for invalid county", {
  expect_error(fips(county = "Fake County"))
})
