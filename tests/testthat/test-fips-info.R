context("Retrieving FIPS code info")

test_that("returns correct state FIPS information", {
  ak_result <- data.frame(abbr = "AK", fips = "02", full = "Alaska", stringsAsFactors = FALSE)

  expect_equivalent(fips_info(2), ak_result)
  expect_equivalent(fips_info("2"), ak_result)
  expect_equivalent(fips_info("02"), ak_result)
})

test_that("returns correct county FIPS information", {
  ak_result <- data.frame(
    full = rep("Alaska", 2),
    abbr = rep("AK", 2),
    county = c("Aleutians West Census Area", "Anchorage Municipality"),
    fips = c("02016", "02020"),
    stringsAsFactors = FALSE
  )

  expect_equivalent(fips_info(c(2016, 2020)), ak_result)
  expect_equivalent(fips_info(c("02016", "02020")), ak_result)
})

test_that("error occurs for non-numeric/character FIPS", {
  expect_error(fips_info(data.frame()))
})
