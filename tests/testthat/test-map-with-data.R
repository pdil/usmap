context("Joining state and county data to map")

state_data <- data.frame(fips = c("01", "02", "04"), value = c(3, 5, 10))
county_data <- data.frame(fips = c("01001", "01003", "01005"), value = c(3, 5, 10))

test_that("values are assigned to correct region", {

})

test_that("error occurs for not having correct number of columns", {
  bad_data <- data.frame(fips = c("01", "02"), value = c(3, 5), extra_col = c("abc", "def"))
  expect_error(map_with_data(bad_data))
})

test_that("error occurs for invalid column names", {
  bad_data <- data.frame(state_fips <- c("01", "02"), the_values = c(3, 5))
  expect_error(map_with_data(bad_data))
})

test_that("error occurs for not having character type `fips` column", {
  bad_data <- data.frame(fips = c(1, 2), value = c(3, 5))
  expect_error(map_with_data(bad_data))
})
