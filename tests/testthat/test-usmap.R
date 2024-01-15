context("Retrieving US map data")

test_that("state data frame is returned", {
  data <- us_map()

  expect_equal(ncol(data), 4)
  expect_equal(nrow(data), 51)

  expect_identical(us_map("state"), data)
  expect_identical(us_map("states"), data)
})

test_that("county data frame is returned", {
  data <- us_map("counties")

  expect_equal(ncol(data), 5)
  expect_equal(nrow(data), 3144)

  expect_identical(us_map("county"), data)
})
