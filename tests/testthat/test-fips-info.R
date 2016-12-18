context("Retrieving FIPS code info")

test_that("returns correct state FIPS information", {
  ak_result <- data.frame(
    abbr = c("AK", "NJ"),
    fips = c("02", "34"),
    full = c("Alaska", "New Jersey"),
    stringsAsFactors = FALSE
  )

  expect_equivalent(fips_info(c(2, 34)), ak_result)
  expect_equivalent(fips_info(c("2", "34")), ak_result)
  expect_equivalent(fips_info(c("02", "34")), ak_result)
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

# non-existent yet valid means a FIPS such as "03", which falls
# within the prescribed boundaries yet is not assigned to any US state
# and therefore returns a warning
test_that("warning occurs for non-existent yet valid FIPS", {
  expect_warning(fips_info("03"))
  expect_warning(fips_info("03055"))
})

test_that("error occurs for non-numeric/character FIPS", {
  expect_error(fips_info(data.frame()))
})
