context("Transforming coordinate data frames")

test_that("dependencies are verified", {
  expect_package_error("sf", { usmap_transform(data.frame()) })
  expect_package_error("sp", { usmap_transform(data.frame()) })
  expect_package_error("sf", { usmap_crs() })
  expect_package_error("sp", { usmap_crs() })
})

test_that("data frame with AK and HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31)
  )

  result <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31),
    x = c(2147110.0, 451625.4, -1672256.6, 1018522.4, -769682.2, -453273.9),
    y = c(-133148.4, -1677546.4, -1035039.5, -273371.4, -2078025.3, -2051494.0)
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
    x = c(2147110.0, 451625.4, -1672256.6, 1018522.4, -769682.2),
    y = c(-133148.4, -1677546.4, -1035039.5, -273371.4, -2078025.3)
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
    x = c(2147110.0, 451625.4, -1672256.6, 1018522.4, -453273.9),
    y = c(-133148.4, -1677546.4, -1035039.5, -273371.4, -2051494.0)
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
    x = c(2147110.0, 451625.4, -1672256.6, 1018522.4),
    y = c(-133148.4, -1677546.4, -1035039.5, -273371.4)
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

test_that("error occurs for invalid input and output names", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85)
  )

  expect_error(usmap_transform(data, input_names = c("longitude")))
  expect_error(usmap_transform(data, input_names = c("longitude", "latitude")))
  expect_error(usmap_transform(data, output_names = c("x")))
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

test_that("sp evolution status is set correctly", {
  sp::set_evolution_status(1L)
  usmap_transform(data.frame(lon = 0, lat = 0))
  expect_equal(sp::get_evolution_status(), 2L)
})
