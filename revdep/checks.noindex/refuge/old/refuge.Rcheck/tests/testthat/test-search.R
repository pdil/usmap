context("test-search.R")

test_that("searching works", {
  skip_on_cran()

  x <- rfg_search("toronto")
  expect_true(tibble::is.tibble(x))
  # expect_equal(length(x), 17)

  toronto <- rfg_search("toronto", accessible = TRUE, unisex = TRUE)
  expect_true(tibble::is.tibble(toronto))
  expect_true("comment" %in% names(toronto))

  expect_gte(nrow(x), nrow(toronto))

  expect_error(
    rfg_search(),
    "Values for the `search` parameter must be included"
  )
})
