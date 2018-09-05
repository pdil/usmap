context("Plotting US maps")

library(proto)

example_data <- data.frame(
  state = c("AK", "CA", "New Jersey"),
  values = c(5, 8, 7)
)

p <- plot_usmap("counties")
q <- plot_usmap(data = statepop, values = "pop_2015")
r <- plot_usmap(data = example_data)
s <- plot_usmap(labels = TRUE)

test_that("ggplot object is returned", {
  expect_is(p, "ggplot")
  expect_is(q, "ggplot")
  expect_is(r, "ggplot")
  expect_is(s, "ggplot")
})

test_that("correct data is used", {
  p_map_data <- us_map(regions = "counties")
  expect_identical(p$data, p_map_data)

  q_map_data <- map_with_data(statepop, values = "pop_2015")
  expect_identical(q$data, q_map_data)

  r_map_data <- map_with_data(example_data)
  expect_identical(r$data, r_map_data)

  s_map_data <- us_map(regions = "states")
  expect_identical(s$data, s_map_data)
})

test_that("layer parameters are correct", {
  # remove version check once ggplot2 v2.3 is released
  if (packageVersion("ggplot2") <= "2.2.1") {
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

    expect_is(s$layers[[1]], "ggproto")
    expect_equal(deparse(s$layers[[1]]$mapping$x), "map_df$long")
    expect_equal(deparse(s$layers[[1]]$mapping$y), "map_df$lat")
    expect_equal(deparse(s$layers[[1]]$mapping$group), "map_df$group")
    expect_equal(as.character(s$layers[[1]]$aes_params$colour), "black")
    expect_equal(s$layers[[1]]$aes_params$size, 0.4)
  } else {
    expect_is(p$layers[[1]], "ggproto")
    expect_equal(deparse(p$layers[[1]]$mapping$x), "~map_df$long")
    expect_equal(deparse(p$layers[[1]]$mapping$y), "~map_df$lat")
    expect_equal(deparse(p$layers[[1]]$mapping$group), "~map_df$group")
    expect_equal(as.character(p$layers[[1]]$aes_params$colour), "black")
    expect_equal(as.character(p$layers[[1]]$aes_params$fill), "white")
    expect_equal(p$layers[[1]]$aes_params$size, 0.4)

    expect_is(q$layers[[1]], "ggproto")
    expect_equal(deparse(q$layers[[1]]$mapping$x), "~map_df$long")
    expect_equal(deparse(q$layers[[1]]$mapping$y), "~map_df$lat")
    expect_equal(deparse(q$layers[[1]]$mapping$group), "~map_df$group")
    expect_equal(deparse(q$layers[[1]]$mapping$fill), "~map_df[, values]")
    expect_equal(as.character(q$layers[[1]]$aes_params$colour), "black")
    expect_equal(q$layers[[1]]$aes_params$size, 0.4)

    expect_is(r$layers[[1]], "ggproto")
    expect_equal(deparse(r$layers[[1]]$mapping$x), "~map_df$long")
    expect_equal(deparse(r$layers[[1]]$mapping$y), "~map_df$lat")
    expect_equal(deparse(r$layers[[1]]$mapping$group), "~map_df$group")
    expect_equal(deparse(r$layers[[1]]$mapping$fill), "~map_df[, values]")
    expect_equal(as.character(r$layers[[1]]$aes_params$colour), "black")
    expect_equal(r$layers[[1]]$aes_params$size, 0.4)

    expect_is(s$layers[[1]], "ggproto")
    expect_equal(deparse(s$layers[[1]]$mapping$x), "~map_df$long")
    expect_equal(deparse(s$layers[[1]]$mapping$y), "~map_df$lat")
    expect_equal(deparse(s$layers[[1]]$mapping$group), "~map_df$group")
    expect_equal(as.character(s$layers[[1]]$aes_params$colour), "black")
    expect_equal(s$layers[[1]]$aes_params$size, 0.4)
  }
})

test_that("singular regions can be used", {
  expect_equal(plot_usmap(regions = "states")$layers,
               plot_usmap(regions = "state")$layers)
  expect_equal(plot_usmap(regions = "counties")$layers,
               plot_usmap(regions = "county")$layers)
})

# This test should be removed when label support is added to county maps
test_that("warning occurs when attempting to use labels with county map", {
  expect_warning(plot_usmap(regions = "counties", labels = TRUE))
  expect_warning(plot_usmap(regions = "county", labels = TRUE))
})
