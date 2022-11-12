context("create_location()")

library(ecocomDP)

# create_location() ----------------------------------------------------

testthat::test_that("Standard L1 column inputs", {
  for (i in c("df", "tbbl")) {
    if (i == "df") { # test w/data.frame
      flat <- as.data.frame(ants_L0_flat)
    } else {      # test w/tibble
      flat <- ants_L0_flat
    }
    crit <- read_criteria()
    res <- create_location(
      L0_flat = flat, 
      location_id = "location_id", 
      location_name = c("block", "plot"), 
      latitude = "latitude", 
      longitude = "longitude", 
      elevation = "elevation")
    # Has expected classes and columns
    if (i == "df") { # test w/data.frame
      expect_true(all(class(res) %in% "data.frame"))
    } else {         # test w/tibble
      expect_true(all(c("tbl_df", "tbl", "data.frame") %in% class(res)))
    }
    crit_cols <- stats::na.omit(crit$column[crit$table == "location"])
    expect_true(all(crit_cols %in% colnames(res)))
    # Is not empty
    expect_true(nrow(res) != 0)
  }
})

# sort_by_alphanumeric() ------------------------------------------------------

testthat::test_that("sort_by_alphanumeric()", {
  df <- data.frame(                                        # A randomized set of ids
    location_id = c("a1", "1b", "3b", "2b", "", "2", "3", "1", "a3", "a2", 
                    "c137", "c1"),
    stringsAsFactors = FALSE)
  res <- sort_by_alphanumeric(x = df, col = "location_id") # Result
  # Has expected order
  expect_equal(
    res$location_id, 
    c("1", "2", "3", "", "a1", "a2", "a3", "1b", "2b", "3b", "c1", "c137"))
})

# suffix_colname_to_vals() ----------------------------------------------------

testthat::test_that("suffix_colname_to_vals()", {
  df <- data.frame(block = c(1, 2, 3), 
                   plot = c("a", "b", "c"), 
                   stringsAsFactors = FALSE)
  res <- suffix_colname_to_vals(tbl = df, cols = c("block", "plot"))
  expect_equal(
    res,
    data.frame(block = c("block__1", "block__2", "block__3"), 
               plot = c("plot__a", "plot__b", "plot__c"), 
               stringsAsFactors = FALSE))
})
