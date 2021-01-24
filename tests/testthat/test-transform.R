context("Transforming coordinate data frames")

test_that("data frame with AK and HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31)
  )

  result <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31),
    lon.1 = c(2152527.4, 452368.1, -1675573.8, 1021136.9, -772150.3, -460168.7),
    lat.1 = c(-133036.6, -1674661.0, -1033609.5, -273152.7, -2080259.3, -2054676.9)
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-05)
})

test_that("data frame with AK points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30)
  )

  result <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30),
    lon.1 = c(2152527.4, 452368.1, -1675573.8, 1021136.9, -772150.3),
    lat.1 = c(-133036.6, -1674661.0, -1033609.5, -273152.7, -2080259.3)
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-05)
})

test_that("data frame with HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 21.31)
  )

  result <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 21.31),
    lon.1 = c(2152527.4, 452368.1, -1675573.8, 1021136.9, -460168.7),
    lat.1 = c(-133036.6, -1674661.0, -1033609.5, -273152.7, -2054676.9)
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-05)
})

test_that("data frame with no AK or HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85)
  )

  result <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85),
    lon.1 = c(2152527.4, 452368.1, -1675573.8, 1021136.9),
    lat.1 = c(-133036.6, -1674661.0, -1033609.5, -273152.7)
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-05)
})

test_that("error occurs for data with less than 2 columns", {
  invalid_data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65)
  )

  expect_error(usmap_transform(invalid_data))
  expect_error(usmap_transform(data.frame()))
})

test_that("error occurs for data with non-numeric columns", {
  invalid_data1 <- data.frame(
    lon = c("a", "b", "c"),
    lat = c("d", "e", "f")
  )

  invalid_data2 <- data.frame(
    lon = c("a", "b", "c"),
    lat = c(1, 2, 3)
  )

  invalid_data3 <- data.frame(
    lon = c(1, 2, 3),
    lat = c("d", "e", "f")
  )

  expect_error(usmap_transform(invalid_data1))
  expect_error(usmap_transform(invalid_data2))
  expect_error(usmap_transform(invalid_data3))
})
