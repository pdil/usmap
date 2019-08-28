context("test-location.R")

test_that("location works", {
  skip_on_cran()
  c <- rfg_location(lat = 39, lng = -75, accessible = TRUE, tidy = TRUE)
  expect_true(tibble::is.tibble(c))
  expect_true("NJ" %in% c$state)
  expect_true("directions" %in% names(c))
  expect_gte(nrow(c), 5)


  e <- rfg_location(
    lat = 39, lng = -75, accessible = FALSE,
    unisex = FALSE, tidy = TRUE
  )
  expect_gte(nrow(e), nrow(c))


  expect_error(
    rfg_location(lat = 90, lng = 0),
    "No restrooms available with given search parameters."
  )

  expect_error(
    rfg_location(),
    "Values for the `lat` and `lng` parameters must be included."
  )
})
