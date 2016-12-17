context("Loading US map data")

states_map <- us_map(regions = "states")
# counties_map <- us_map(regions = "counties")

test_that("structure of states df is correct", {
  expect_equal(length(unique(states_map$fips)), 51)
})

test_that("correct states are included", {
  include_states <- c("AK", "AL", "AZ")
  map <- us_map(regions = "states", include = include_states)
  
  expect_equal(length(unique(map$fips)), length(include_states))
})

# test_that("structure of counties df is correct", {
#   expect_equal(length(unique(counties_map$id)), 3142)
# })

test_that("error occurs for invalid region", {
  expect_error(us_map(regions = "cities"))
})
