context("Joining state and county data to map")

state_data <- data.frame(fips = c("01", "02", "04"), values = c(3, 5, 10))
county_data <- data.frame(fips = c("01001", "01003", "01005"), values = c(3, 5, 10))

test_that("values are assigned to states correctly", {
  df <- map_with_data(state_data)

  expect_equal(unique(state_data$value[state_data$fips == "01"]), unique(df$value[df$fips == "01"]))
  expect_equal(unique(state_data$value[state_data$fips == "02"]), unique(df$value[df$fips == "02"]))
  expect_equal(unique(state_data$value[state_data$fips == "04"]), unique(df$value[df$fips == "04"]))
})

test_that("values are assigned to counties correctly", {
  df <- map_with_data(county_data)

  expect_equal(unique(county_data$value[county_data$fips == "01001"]), unique(df$value[df$fips == "01001"]))
  expect_equal(unique(county_data$value[county_data$fips == "01003"]), unique(df$value[df$fips == "01003"]))
  expect_equal(unique(county_data$value[county_data$fips == "01005"]), unique(df$value[df$fips == "01005"]))
})

test_that("values are appropriately assigned if county FIPS codes are missing leading zeroes", {
  county_data2 <- data.frame(fips = c(1001, 1003, 1005), values = c(3, 5, 10))
  df <- map_with_data(county_data2)

  expect_equal(unique(county_data2$value[county_data2$fips == 1001]), unique(df$value[df$fips == "01001"]))
  expect_equal(unique(county_data2$value[county_data2$fips == 1003]), unique(df$value[df$fips == "01003"]))
  expect_equal(unique(county_data2$value[county_data2$fips == 1005]), unique(df$value[df$fips == "01005"]))
})

test_that("values are appropriately assigned if state FIPS codes are missing leading zeroes", {
  state_data2 <- data.frame(fips = c(1, 2, 4), values = c(3, 5, 10))
  df <- map_with_data(state_data2)

  expect_equal(unique(state_data2$value[state_data2$fips == 1]), unique(df$value[df$fips == "01"]))
  expect_equal(unique(state_data2$value[state_data2$fips == 2]), unique(df$value[df$fips == "02"]))
  expect_equal(unique(state_data2$value[state_data2$fips == 4]), unique(df$value[df$fips == "04"]))
})

test_that("error occurs for invalid column names", {
  bad_data_states <- data.frame(state_fips <- c("01", "02"), values = c(3, 5))
  bad_data_values <- data.frame(fips <- c("01", "02"), the_values = c(3, 5))

  expect_error(map_with_data(bad_data_states))
  expect_error(map_with_data(bad_data_values))
})

test_that("error occurs for non-data frame input", {
  expect_error(map_with_data(data = "1"))
})

test_that("warning occurs for empty (yet valid) data frame", {
  expect_warning(map_with_data(data.frame(fips = c(), values = c())))
  expect_equal(suppressWarnings(map_with_data(data.frame(fips = c(), values = c()))), us_map())

  expect_warning(map_with_data(data.frame(fips = c(), values = c()), include = c("01")), "*state*")
  expect_warning(map_with_data(data.frame(fips = c(), values = c()), include = c("01001")), "*county*")
})
