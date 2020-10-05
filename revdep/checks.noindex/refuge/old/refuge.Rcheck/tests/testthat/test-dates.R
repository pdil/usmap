context("test-dates.R")

test_that("dates works", {
  skip_on_cran()

  d <- rfg_date(
    date = "2018-11-25", unisex = TRUE,
    accessible = TRUE, updated = FALSE
  )
  expect_true(tibble::is.tibble(d))
})
