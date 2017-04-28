context("Joining state and county data to map")

state_data <- data.frame(fips = c("01", "02", "04"), value = c(3, 5, 10))
county_data <- data.frame(fips = c("01001", "01003", "01005"), value = c(3, 5, 10))

test_that("values are assigned to states correctly", {
  df <- map_with_data(state_data)

  expect_equal(unique(state_data$value[state_data$fips == "01"]), unique(df$value[df$fips == "01"]))
  expect_equal(unique(state_data$value[state_data$fips == "02"]), unique(df$value[df$fips == "02"]))
  expect_equal(unique(state_data$value[state_data$fips == "04"]), unique(df$value[df$fips == "04"]))
})

test_that("values are assigned to counties correctly", {
  # df <- map_with_data(county_data)
  # expect_equal(length(unique(df$county[df$value == 3])), 1)
  # expect_equal(length(unique(df$county[df$value == 5])), 1)
  # expect_equal(length(unique(df$county[df$value == 10])), 1)
})

test_that("error occurs for not having correct number of columns", {
  bad_data <- data.frame(fips = c("01", "02"), value = c(3, 5), extra_col = c("abc", "def"))
  expect_error(map_with_data(bad_data))
})

test_that("error occurs for invalid column names", {
  bad_data <- data.frame(state_fips <- c("01", "02"), the_values = c(3, 5))
  expect_error(map_with_data(bad_data))
})
