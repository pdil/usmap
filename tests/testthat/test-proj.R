context("Transforming coordinate data frames")

test_that("data frame with AK and HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31)
  )

  result <- data.frame(
    lon = c(2147110.0, 451625.4, -1672256.6, 1018522.4, -774218.3, -456562.5),
    lat = c(-133148.4, -1677546.4, -1035039.5, -273371.4, -2083498.9, -2044963.7)
  )

  expect_equal(usmap_proj(data), result, tolerance = 1e-05)
})

test_that("data frame with AK points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30)
  )

  result <- data.frame(
    lon = c(2147110.0, 451625.4, -1672256.6, 1018522.4, -774218.3),
    lat = c(-133148.4, -1677546.4, -1035039.5, -273371.4, -2083498.9)
  )

  expect_equal(usmap_proj(data), result, tolerance = 1e-05)
})

test_that("data frame with HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 21.31)
  )

  result <- data.frame(
    lon = c(2147110.0, 451625.4, -1672256.6, 1018522.4, -456562.5),
    lat = c(-133148.4, -1677546.4, -1035039.5, -273371.4, -2044963.7)
  )

  expect_equal(usmap_proj(data), result, tolerance = 1e-05)
})

test_that("data frame with no AK or HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85)
  )

  result <- data.frame(
    lon = c(2147110.0, 451625.4, -1672256.6, 1018522.4),
    lat = c(-133148.4, -1677546.4, -1035039.5, -273371.4)
  )

  expect_equal(usmap_proj(data), result, tolerance = 1e-05)
})

test_that("error occurs for data without 2 columns", {
  invalid_data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85),
    something_else = c(1, 2, 3, 4)
  )

  expect_error(usmap_proj(invalid_data))
  expect_error(usmap_proj(data.frame()))
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

  expect_error(usmap_proj(invalid_data1))
  expect_error(usmap_proj(invalid_data2))
  expect_error(usmap_proj(invalid_data3))
})
