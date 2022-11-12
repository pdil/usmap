context("create_taxon()")

library(ecocomDP)

# create_taxon() --------------------------------------------------------------

testthat::test_that("Standard L1 column inputs", {
  for (i in c("df", "tbbl")) {
    if (i == "df") { # test w/data.frame
      flat <- as.data.frame(ants_L0_flat)
    } else {      # test w/tibble
      flat <- ants_L0_flat
    }
    crit <- read_criteria()
    res <- create_taxon(
      L0_flat = flat, 
      taxon_id = "taxon_id", 
      taxon_rank = "taxon_rank", 
      taxon_name = "taxon_name", 
      authority_system = "authority_system", 
      authority_taxon_id = "authority_taxon_id")
    # Has expected classes and columns
    if (i == "df") {
      expect_true(all(class(res) %in% "data.frame"))
    } else {
      expect_true(all(c("tbl_df", "tbl", "data.frame") %in% class(res)))
    }
    crit_cols <- stats::na.omit(crit$column[crit$table == "taxon"])
    expect_true(all(crit_cols %in% colnames(res)))
    # Is not empty
    expect_true(nrow(res) != 0)
  }
})
