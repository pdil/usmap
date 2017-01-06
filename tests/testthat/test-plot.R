context("Test plotting US maps")

library(proto)
p <- plot_usmap()

test_that("ggplot object is returned", {
  expect_is(p, "ggplot")
})

test_that("correct data is used", {
  map_data <- us_map(regions = "states")
  expect_identical(p$data, map_data)
})

test_that("layer parameters are correct", {
  expect_is(p$layers[[1]], "ggproto")
  expect_equal(as.character(p$layers[[1]]$mapping$x), "long")
  expect_equal(as.character(p$layers[[1]]$mapping$y), "lat")
  expect_equal(as.character(p$layers[[1]]$mapping$group), "group")
  expect_equal(as.character(p$layers[[1]]$aes_params$colour), "black")
  expect_equal(as.character(p$layers[[1]]$aes_params$fill), "white")
  expect_equal(p$layers[[1]]$aes_params$size, 0.4)
})

test_that("singular regions can be used", {
  expect_equal(plot_usmap(regions = "states")$layers,
               plot_usmap(regions = "state")$layers)
  expect_equal(plot_usmap(regions = "counties")$layers,
               plot_usmap(regions = "county")$layers)
})
