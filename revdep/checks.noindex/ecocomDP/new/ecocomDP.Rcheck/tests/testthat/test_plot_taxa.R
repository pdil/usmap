context("plot_taxa")

library(ecocomDP)

# Warns if datetimes are chars ------------------------------------------------

testthat::test_that("Warns if datetimes are chars", {
  id <- ants_L1$id
  d <- ants_L1$tables$observation
  d$datetime <- as.character(d$datetime)
  expect_warning(
    format_for_comm_plots(observation = d, id = id),
    regexp = "Input datetimes are character strings. Accuracy may be improved")
})

# Warns if > 1 measurement variable -------------------------------------------

testthat::test_that("Warns if > 1 measurement variable", {
  d <- ants_L1
  obs2 <- d$tables$observation                      # add a var and unit
  obs2$variable_name <- "Another var"
  obs2$unit <- "Another unit"
  d$tables$observation <- rbind(d$tables$observation, obs2)
  id <- d$id
  d <- d$tables$observation
  expect_warning(
    format_for_comm_plots(observation = d, id = id),
    regexp = "has > 1 unique variable_name and unit combination")
})

