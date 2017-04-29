context("Plotting US maps")

library(proto)
p <- plot_usmap()
q <- plot_usmap(data = statepop, values = "pop_2015")

test_that("ggplot object is returned", {
  expect_is(p, "ggplot")
  expect_is(q, "ggplot")
})

test_that("correct data is used", {
  p_map_data <- us_map(regions = "states")
  expect_identical(p$data, p_map_data)

  q_map_data <- map_with_data(statepop, values = "pop_2015")
  expect_identical(q$data, q_map_data)
})

test_that("layer parameters are correct", {
  expect_is(p$layers[[1]], "ggproto")
  expect_equal(deparse(p$layers[[1]]$mapping$x), "map_df$long")
  expect_equal(deparse(p$layers[[1]]$mapping$y), "map_df$lat")
  expect_equal(deparse(p$layers[[1]]$mapping$group), "map_df$group")
  expect_equal(as.character(p$layers[[1]]$aes_params$colour), "black")
  expect_equal(as.character(p$layers[[1]]$aes_params$fill), "white")
  expect_equal(p$layers[[1]]$aes_params$size, 0.4)

  expect_is(q$layers[[1]], "ggproto")
  expect_equal(deparse(q$layers[[1]]$mapping$x), "map_df$long")
  expect_equal(deparse(q$layers[[1]]$mapping$y), "map_df$lat")
  expect_equal(deparse(q$layers[[1]]$mapping$group), "map_df$group")
  expect_equal(deparse(q$layers[[1]]$mapping$fill), "map_df[, values]")
  expect_equal(as.character(q$layers[[1]]$aes_params$colour), "black")
  expect_equal(q$layers[[1]]$aes_params$size, 0.4)
})

test_that("singular regions can be used", {
  expect_equal(plot_usmap(regions = "states")$layers,
               plot_usmap(regions = "state")$layers)
  expect_equal(plot_usmap(regions = "counties")$layers,
               plot_usmap(regions = "county")$layers)
})
