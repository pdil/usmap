context("Loading US map data")

states_map <- us_map(region = "states")

test_that("length of us_map states is 51", {
  expect_equal(length(unique(states_map$id)), 51)
})