context("Plotting US maps")

library(proto)

example_data <- data.frame(
  state = c("AK", "CA", "New Jersey"),
  values = c(5, 8, 7)
)

p <- plot_usmap()
q <- plot_usmap(data = statepop, values = "pop_2015")
r <- plot_usmap(data = example_data)

test_that("ggplot object is returned", {
  expect_is(p, "ggplot")
  expect_is(q, "ggplot")
  expect_is(r, "ggplot")
})

test_that("correct data is used", {
  p_map_data <- us_map(regions = "states")
  expect_identical(p$data, p_map_data)

  q_map_data <- map_with_data(statepop, values = "pop_2015")
  expect_identical(q$data, q_map_data)

  r_map_data <- map_with_data(example_data)
  expect_identical(r$data, r_map_data)
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

  expect_is(r$layers[[1]], "ggproto")
  expect_equal(deparse(r$layers[[1]]$mapping$x), "map_df$long")
  expect_equal(deparse(r$layers[[1]]$mapping$y), "map_df$lat")
  expect_equal(deparse(r$layers[[1]]$mapping$group), "map_df$group")
  expect_equal(deparse(r$layers[[1]]$mapping$fill), "map_df[, values]")
  expect_equal(as.character(r$layers[[1]]$aes_params$colour), "black")
  expect_equal(r$layers[[1]]$aes_params$size, 0.4)
})

test_that("singular regions can be used", {
  expect_equal(plot_usmap(regions = "states")$layers,
               plot_usmap(regions = "state")$layers)
  expect_equal(plot_usmap(regions = "counties")$layers,
               plot_usmap(regions = "county")$layers)
})
