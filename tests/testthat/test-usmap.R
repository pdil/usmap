context("Retrieving US map data")

test_that("dependencies are verified", {
  expect_package_error("usmapdata", { us_map() })
})

test_that("data frame is returned", {
  data <- us_map()
  expect_equal(length(data), 9)
  expect_equal(length(data$x), 13663)
})
