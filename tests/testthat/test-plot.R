context("Test plotting US maps")

library(proto)
p <- plot_usmap(regions = "states")

test_that("ggplot object is returned", {
  expect_is(p, "ggplot")
})

test_that("correct data is used", {
  map_data <- us_map(regions = "states")
  expect_identical(p$data, map_data)
})

test_that("correct layers are used", {
  skip("`objname` not in ggproto object")
  expect_is(p$layers[[1]], "ggproto")
  expect_identical(p$layers[[1]]$geom$objname, "polygon")
})
