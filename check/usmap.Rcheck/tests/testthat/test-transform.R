test_that("data frame with AK and HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30, 21.31)
  )

  result <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(2152550, -133046.5)),
        sf::st_point(c(452399.8, -1674650)),
        sf::st_point(c(-1675528, -1033610)),
        sf::st_point(c(1021166, -273151.2)),
        sf::st_point(c(-1062738, -2125993)),
        sf::st_point(c(-618107.8, -1962880))
      )
    ),
    crs = usmap_crs()
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-02)
})

test_that("data frame with AK points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -134.42),
    lat = c(40.71, 29.76, 34.05, 41.85, 58.30)
  )

  result <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(2152550, -133046.5)),
        sf::st_point(c(452399.8, -1674650)),
        sf::st_point(c(-1675528, -1033610)),
        sf::st_point(c(1021166, -273151.2)),
        sf::st_point(c(-1062738, -2125993))
      )
    ),
    crs = usmap_crs()
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-02)
})

test_that("data frame with HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65, -157.86),
    lat = c(40.71, 29.76, 34.05, 41.85, 21.31)
  )

  result <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(2152550, -133046.5)),
        sf::st_point(c(452399.8, -1674650)),
        sf::st_point(c(-1675528, -1033610)),
        sf::st_point(c(1021166, -273151.2)),
        sf::st_point(c(-618107.8, -1962880))
      )
    ),
    crs = usmap_crs()
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-02)
})

test_that("data frame with no AK or HI points is transformed", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85)
  )

  result <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(2152550, -133046.5)),
        sf::st_point(c(452399.8, -1674650)),
        sf::st_point(c(-1675528, -1033610)),
        sf::st_point(c(1021166, -273151.2))
      )
    ),
    crs = usmap_crs()
  )

  expect_equal(usmap_transform(data), result, tolerance = 1e-02)
})

test_that("sf object is transformed", {
  sf <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(-74.01, 40.71)),
        sf::st_point(c(-95.36, 29.76)),
        sf::st_point(c(-118.24, 34.05)),
        sf::st_point(c(-87.65, 41.85)),
        sf::st_point(c(-134.42, 58.30)),
        sf::st_point(c(-157.86, 21.31))
      )
    ),
    crs = sf::st_crs(4326)
  )

  result <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(2152550, -133046.5)),
        sf::st_point(c(452399.8, -1674650)),
        sf::st_point(c(-1675528, -1033610)),
        sf::st_point(c(1021166, -273151.2)),
        sf::st_point(c(-1062738, -2125993)),
        sf::st_point(c(-618107.8, -1962880))
      )
    ),
    crs = usmap_crs()
  )

  expect_equal(usmap_transform(sf), result, tolerance = 1e-02)
})

test_that("sf object with non-lon/lat CRS is transformed", {
  sf <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(-8238756, 4969660)),
        sf::st_point(c(-10615427, 3472737)),
        sf::st_point(c(-13162417, 4035518)),
        sf::st_point(c(-9757153, 5138537)),
        sf::st_point(c(-14963566, 8030604)),
        sf::st_point(c(-17572895, 2428881))
      )
    ),
    crs = sf::st_crs(3857)
  )

  result <- sf::st_as_sf(
    data.frame(
      geometry = sf::st_sfc(
        sf::st_point(c(2152550, -133046.5)),
        sf::st_point(c(452399.8, -1674650)),
        sf::st_point(c(-1675528, -1033610)),
        sf::st_point(c(1021166, -273151.2)),
        sf::st_point(c(-1062738, -2125993)),
        sf::st_point(c(-618107.8, -1962880))
      )
    ),
    crs = usmap_crs()
  )

  # test without explicit CRS
  expect_equal(usmap_transform(sf), result, tolerance = 1e-02)
  # test with explicit CRS
  expect_equal(usmap_transform(sf, crs = sf::st_crs(3857)), result, tolerance = 1e-02)
})

test_that("error occurs for data with less than 2 columns", {
  invalid_data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65)
  )

  expect_error(usmap_transform(invalid_data))
  expect_error(usmap_transform(data.frame()))
})

test_that("error occurs for invalid input names", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85)
  )

  expect_error(usmap_transform(data, input_names = c("longitude")))
  expect_error(usmap_transform(data, input_names = c("longitude", "latitude")))
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

test_that("warning occurs for use of defunct output_names", {
  data <- data.frame(
    lon = c(-74.01, -95.36, -118.24, -87.65),
    lat = c(40.71, 29.76, 34.05, 41.85)
  )

  expect_warning(usmap_transform(data, output_names = c("x", "y")))
})
