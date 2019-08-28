context("test-all-restrooms.R")

test_that("all restrooms works", {
  skip_on_cran()
  skip_on_travis() # takes a long time and is fine to test locally
  skip_on_appveyor()

  all <- rfg_all_restrooms(accessible = TRUE, unisex = TRUE)
  expect_true(tibble::is.tibble(all))

  all2 <- rfg_all_restrooms(accessible = FALSE, unisex = FALSE)
  expect_true(tibble::is.tibble(all2))
})
