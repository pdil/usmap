test_that("provided data sets plot correctly", {
  skip_on_ci()

  a <- plot_usmap(data = countypop, values = "pop_2022", include = "TX")
  b <- plot_usmap(data = countypov, values = "pct_pov_2021", include = "TX")
  c <- plot_usmap(data = statepop, values = "pop_2022", include = .south_region)
  d <- plot_usmap(data = statepov, values = "pct_pov_2021", include = .south_region)

  vdiffr::expect_doppelganger("countypop", a)
  vdiffr::expect_doppelganger("countypov", b)
  vdiffr::expect_doppelganger("statepop", c)
  vdiffr::expect_doppelganger("statepov", d)
})
