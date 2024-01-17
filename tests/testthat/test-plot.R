context("Plotting US maps")

test_that("dependencies are verified", {
  expect_package_error("ggplot2", plot_usmap())
})

library(proto)

example_data <- data.frame(
  state = c("AK", "CA", "New Jersey"),
  values = c(5, 8, 7)
)

p <- plot_usmap("counties", fill = "red")
q <- plot_usmap(data = statepop, values = "pop_2015", color = "blue")
r <- plot_usmap(data = example_data, linewidth = 0.8)
s <- plot_usmap(include = c("AL", "FL", "GA"), labels = TRUE, label_color = "blue")
t <- plot_usmap("county", include = "AZ", labels = TRUE, fill = "yellow", linewidth = 0.6)
u <- plot_usmap(include = .new_england, exclude = "ME", labels = TRUE)
v <- plot_usmap("state", labels = TRUE)

test_that("ggplot object is returned", {
  expect_is(p, "ggplot")
  expect_is(q, "ggplot")
  expect_is(r, "ggplot")
  expect_is(s, "ggplot")
  expect_is(t, "ggplot")
  expect_is(u, "ggplot")
  expect_is(v, "ggplot")
})

test_that("no warnings are produced", {
  expect_silent(p)
  expect_silent(q)
  expect_silent(r)
  expect_silent(s)
  expect_silent(t)
  expect_silent(u)
  expect_silent(v)
})

test_that("correct data is used", {
  p_map_data <- us_map(regions = "counties")
  expect_identical(p$data, p_map_data)

  q_map_data <- map_with_data(statepop, values = "pop_2015")
  expect_identical(q$data, q_map_data)

  r_map_data <- map_with_data(example_data)
  expect_identical(r$data, r_map_data)

  s_map_data <- us_map(regions = "states", include = c("AL", "FL", "GA"))
  expect_identical(s$data, s_map_data)

  t_map_data <- us_map(regions = "counties", include = "AZ")
  expect_identical(t$data, t_map_data)

  u_map_data <- us_map(include = .new_england, exclude = "ME")
  expect_identical(u$data, u_map_data)

  v_map_data <- us_map()
  expect_identical(v$data, v_map_data)
})

test_that("plots are stable", {
  vdiffr::expect_doppelganger("State population map with blue outlines", q)
  vdiffr::expect_doppelganger("Example data state map with custom linewidth", r)
  vdiffr::expect_doppelganger("Southeastern states map with labels", s)
  vdiffr::expect_doppelganger("Arizona county map with labels and fill", t)
  vdiffr::expect_doppelganger("New England state map with labels excluding Maine", u)
  vdiffr::expect_doppelganger("State map with labels", v)

  rivers_t <- usmap_transform(usrivers)
  river_map <- plot_usmap() + ggplot2::geom_sf(data = rivers_t, color = "blue")
  vdiffr::expect_doppelganger("State map with major rivers", river_map)
})

test_that("layer parameters are correct", {
  expect_is(p$layers[[1]], "ggproto")
  expect_is(p$layers[[1]]$geom, "GeomSf")
  expect_equal(as.character(p$layers[[1]]$aes_params$colour), "black")
  expect_equal(as.character(p$layers[[1]]$aes_params$fill), "red")
  expect_equal(p$layers[[1]]$aes_params$linewidth, 0.4)

  expect_is(q$layers[[1]], "ggproto")
  expect_is(q$layers[[1]]$geom, "GeomSf")
  expect_equal(deparse(q$layers[[1]]$mapping$fill), "~.data[[\"pop_2015\"]]")
  expect_equal(as.character(q$layers[[1]]$aes_params$colour), "blue")
  expect_equal(q$layers[[1]]$aes_params$linewidth, 0.4)

  expect_is(r$layers[[1]], "ggproto")
  expect_is(r$layers[[1]]$geom, "GeomSf")
  expect_equal(deparse(r$layers[[1]]$mapping$fill), "~.data[[\"values\"]]")
  expect_equal(as.character(r$layers[[1]]$aes_params$colour), "black")
  expect_equal(r$layers[[1]]$aes_params$linewidth, 0.8)

  expect_is(s$layers[[1]], "ggproto")
  expect_is(s$layers[[1]]$geom, "GeomSf")
  expect_equal(as.character(s$layers[[1]]$aes_params$fill), "white")
  expect_equal(as.character(s$layers[[1]]$aes_params$colour), "black")
  expect_equal(s$layers[[1]]$aes_params$linewidth, 0.4)
  expect_is(s$layers[[2]], "ggproto")
  expect_is(s$layers[[2]]$geom, "GeomText")
  expect_equal(deparse(s$layers[[2]]$mapping$label), "~.data$abbr")
  expect_equal(as.character(s$layers[[2]]$aes_params$colour), "blue")

  expect_is(t$layers[[1]], "ggproto")
  expect_is(s$layers[[1]]$geom, "GeomSf")
  expect_equal(as.character(t$layers[[1]]$aes_params$fill), "yellow")
  expect_equal(as.character(t$layers[[1]]$aes_params$colour), "black")
  expect_equal(t$layers[[1]]$aes_params$linewidth, 0.6)
  expect_is(t$layers[[2]], "ggproto")
  expect_is(t$layers[[2]]$geom, "GeomText")
  expect_equal(deparse(t$layers[[2]]$mapping$label),
               "~sub(\" County\", \"\", .data$county)")

  expect_is(u$layers[[1]], "ggproto")
  expect_is(u$layers[[1]]$geom, "GeomSf")
  expect_equal(as.character(u$layers[[1]]$aes_params$fill), "white")
  expect_equal(as.character(u$layers[[1]]$aes_params$colour), "black")
  expect_equal(u$layers[[1]]$aes_params$linewidth, 0.4)
  expect_is(u$layers[[2]], "ggproto")
  expect_is(u$layers[[2]]$geom, "GeomText")
  expect_equal(deparse(u$layers[[2]]$mapping$label), "~.data$abbr")

  expect_is(v$layers[[1]], "ggproto")
  expect_is(v$layers[[1]]$geom, "GeomSf")
  expect_equal(as.character(v$layers[[1]]$aes_params$fill), "white")
  expect_equal(as.character(v$layers[[1]]$aes_params$colour), "black")
  expect_equal(v$layers[[1]]$aes_params$linewidth, 0.4)
  expect_is(v$layers[[2]], "ggproto")
  expect_is(v$layers[[2]]$geom, "GeomText")
  expect_equal(deparse(v$layers[[2]]$mapping$label), "~.data$abbr")
})

test_that("county data works without specifying `region`", {
  data <- data.frame(
    fips = c("36001", "36003", "36005", "36007"),
    values = c(1, 3, 3, 5)
  )

  p <- plot_usmap(data = data, include = "NY", labels = TRUE)
  expect_equal(deparse(p$layers[[2]]$mapping$label),
               "~sub(\" County\", \"\", .data$county)")
})
