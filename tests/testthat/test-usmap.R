context("Loading US map data")

states_map <- us_map(regions = "states")
counties_map <- us_map(regions = "counties")

test_that("structure of states df is correct", {
  expect_equal(length(unique(states_map$fips)), 51)
})

test_that("correct states are included", {
  include_abbr <- c("AK", "AL", "AZ")
  map_abbr <- us_map(regions = "states", include = include_abbr)

  include_full <- c("Alaska", "Alabama", "Arizona")
  map_full <- us_map(regions = "states", include = include_full)

  include_fips <- c("02", "01", "04")
  map_fips <- us_map(regions = "states", include = include_fips)

  expect_equal(length(unique(map_abbr$fips)), length(include_abbr))
  expect_equal(length(unique(map_full$fips)), length(include_full))
  expect_equal(length(unique(map_fips$fips)), length(include_fips))
})

test_that("structure of counties df is correct", {
  expect_equal(length(unique(counties_map$fips)), 3142)
})

test_that("error occurs for invalid region", {
  expect_error(us_map(regions = "cities"))
})
