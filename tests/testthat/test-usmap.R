context("Loading US map data")

states_map <- us_map(region = "states")
counties_map <- us_map(region = "counties")

test_that("structure of states df is correct", {
  expect_equal(length(unique(states_map$id)), 51)
})

test_that("structure of counties df is correct", {
  expect_equal(length(unique(counties_map$id)), 3142)
})

test_that("error occurs for invalid region", {
  expect_error(us_map(region = "cities"))
})
