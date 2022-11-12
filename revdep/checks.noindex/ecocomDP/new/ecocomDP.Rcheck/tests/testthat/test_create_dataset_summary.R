context("create_dataset_summary()")

library(ecocomDP)

# create_dataset_summary() ----------------------------------------------------

testthat::test_that("Standard L1 column inputs", {
  for (i in c("df", "tbbl")) {
    if (i == "df") { # test w/data.frame
      flat <- as.data.frame(ants_L0_flat)
    } else {      # test w/tibble
      flat <- ants_L0_flat
    }
    crit <- read_criteria()
    res <- create_dataset_summary(
      L0_flat = flat, 
      package_id = "package_id", 
      original_package_id = "original_package_id", 
      length_of_survey_years = "length_of_survey_years",
      number_of_years_sampled = "number_of_years_sampled", 
      std_dev_interval_betw_years = "std_dev_interval_betw_years", 
      max_num_taxa = "max_num_taxa", 
      geo_extent_bounding_box_m2 = "geo_extent_bounding_box_m2")
    # Is input class
    if (i == "df") { # test w/data.frame
      expect_true(all(class(res) %in% "data.frame"))
    } else {         # test w/tibble
      expect_true(all(c("tbl_df", "tbl", "data.frame") %in% class(res)))
    }
    crit_cols <- stats::na.omit(crit$column[crit$table == "dataset_summary"])
    expect_true(all(crit_cols %in% colnames(res)))
    # Is not empty
    expect_true(nrow(res) != 0)
  }
})

testthat::test_that("Non-Standard column inputs", {
  for (i in c("df", "tbbl")) {
    if (i == "df") { # test w/data.frame
      flat <- as.data.frame(ants_L0_flat)
    } else {      # test w/tibble
      flat <- ants_L0_flat
    }
    crit <- read_criteria()
    cols <- colnames(flat)
    cols[cols == "package_id"] <- "pkgid"
    cols[cols == "original_package_id"] <- "og_pkgid"
    cols[cols == "length_of_survey_years"] <- "lsy"
    cols[cols == "number_of_years_sampled"] <- "nys"
    cols[cols == "std_dev_interval_betw_years"] <- "sdiby"
    cols[cols == "max_num_taxa"] <- "mnt"
    cols[cols == "geo_extent_bounding_box_m2"] <- "gebb"
    colnames(flat) <- cols
    res <- create_dataset_summary(
      L0_flat = flat, 
      package_id = "pkgid", 
      original_package_id = "og_pkgid", 
      length_of_survey_years = "lsy",
      number_of_years_sampled = "nys", 
      std_dev_interval_betw_years = "sdiby", 
      max_num_taxa = "mnt", 
      geo_extent_bounding_box_m2 = "gebb")
    # Is input class
    if (i == "df") { # test w/data.frame
      expect_true(all(class(res) %in% "data.frame"))
    } else {         # test w/tibble
      expect_true(all(c("tbl_df", "tbl", "data.frame") %in% class(res)))
    }
    crit_cols <- stats::na.omit(crit$column[crit$table == "dataset_summary"])
    expect_true(all(crit_cols %in% colnames(res)))
    # Is not empty
    expect_true(nrow(res) != 0)
  }
})

# calc_geo_extent_bounding_box_m2() -------------------------------------------

testthat::test_that("calc_geo_extent_bounding_box_m2()", {
  res <- calc_geo_extent_bounding_box_m2(west = -123, east = -120, north = 45, 
                                         south = 23)
  expect_true(is.numeric(res))
})

# calc_length_of_survey_years() -----------------------------------------------

testthat::test_that("calc_length_of_survey_years()", {
  flat <- ants_L0_flat
  res <- calc_length_of_survey_years(dates = flat$datetime)
  expect_true(is.numeric(res))
})

# calc_number_of_years_sampled() ----------------------------------------------

testthat::test_that("calc_number_of_years_sampled()", {
  flat <- ants_L0_flat
  res <- calc_number_of_years_sampled(dates = flat$datetime)
  expect_true(is.numeric(res))
})

# calc_std_dev_interval_betw_years() ------------------------------------------

testthat::test_that("calc_std_dev_interval_betw_years()", {
  flat <- ants_L0_flat
  res <- calc_std_dev_interval_betw_years(dates = flat$datetime)
  expect_true(is.numeric(res))
})


