context("Retrieving FIPS codes")

test_that("returns correct FIPS code for NJ", {
  expect_match(fips(state = "NJ"), "34")
  expect_match(fips(state = "NEW JERSEY"), "34")
})

# this will be replaced once county functionality is added
test_that("returns 0 when county is entered", {
  expect_equal(fips(county = "Anything"), 0)
})

test_that("error occurs for entering both state and county", {
  expect_error(fips(state = "NJ", county = "Mercer"))
})

test_that("error occurs for invalid state", {
  expect_error(fips(state = "Puerto Rico"))
})