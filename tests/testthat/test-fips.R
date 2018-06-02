context("Retrieving FIPS codes")

test_that("returns correct FIPS code for NJ", {
  expect_equal(fips(state = "nj"), "34")
  expect_equal(fips(state = "NJ"), "34")
  expect_equal(fips(state = "New Jersey"), "34")
  expect_equal(fips(state = "new jersey"), "34")
})

test_that("multiple states return appropriate FIPS codes", {
  expect_equal(fips(c("CA", "NJ", "AL", "XX", "SD")), c("06", "34", "01", NA, "46"))
  expect_equal(fips(c("CA", "New jersey", "AL", "XX", "sOutH dAkoTA")), c("06", "34", "01", NA, "46"))
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

test_that("NA is returned for invalid state", {
  expect_true(is.na(fips(state = "Puerto Rico")))
})

test_that("error occurs for missing state", {
  expect_error(fips(county = "Mercer County"))
})

test_that("error occurs for county with list of states", {
  expect_error(fips("CA", "NJ", county = "Mercer"))
})

test_that("error occurs for invalid county", {
  expect_error(fips(state = "CA", county = "Fake County"))
})

# This is to ensure that the Shannon County -> Oglala Lakota County
# change that occurred in South Dakota (May 1, 2015) is properly reflected.
test_that("Oglala Lakota County is correctly in the data", {
  expect_error(fips(state = "SD", county = "Shannon County"))
  expect_equal(fips(state = "SD", county = "Oglala Lakota County"), "46102")
})
