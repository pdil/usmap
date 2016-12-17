context("Retrieving FIPS codes")

test_that("returns correct FIPS code for NJ", {
  expect_match(fips(state = "nj"), "34")
  expect_match(fips(state = "NJ"), "34")
  expect_match(fips(state = "New Jersey"), "34")
  expect_match(fips(state = "new jersey"), "34")
})

test_that("returns correct FIPS code for Mercer County, NJ", {
  expect_equal(fips(state = "NJ", county = "mercer"), "34021")
  expect_equal(fips(state = "NJ", county = "mercer county"), "34021")
  expect_equal(fips(state = "NJ", county = "Mercer County"), "34021")
  expect_equal(fips(state = "new jersey", county = "mercer"), "34021")
  expect_equal(fips(state = "New Jersey", county = "Mercer County"), "34021")
})

test_that("returns correct FIPS if it starts with a 0", {
  expect_equal(fips(state = "AL"), "01")
  expect_equal(fips(state = "CA"), "06")
  expect_equal(fips(state = "AL", county = "autauga"), "01001")
  expect_equal(fips(state = "AL", county = "baldwin"), "01003")
  expect_equal(fips(state = "AL", county = "barbour"), "01005")
})

test_that("error occurs for invalid state", {
  expect_error(fips(state = "Puerto Rico"))
})

test_that("error occurs for missing state", {
  expect_error(fips(county = "Mercer County"))
})

test_that("error occurs for invalid county", {
  expect_error(fips(state = "CA", county = "Fake County"))
})
