context("create_taxon_ancillary()")

library(ecocomDP)

# create_taxon_ancillary() ----------------------------------------------------

testthat::test_that("Standard L1 column inputs", {
  for (i in c("df", "tbbl")) {
    if (i == "df") { # test w/data.frame
      flat <- as.data.frame(ants_L0_flat)
    } else {      # test w/tibble
      flat <- ants_L0_flat
    }
    crit <- read_criteria()
    res <- create_taxon_ancillary(
      L0_flat = flat,
      taxon_id = "taxon_id",
      variable_name = c(
        "subfamily", "hl", "rel", "rll", "colony.size", 
        "feeding.preference", "nest.substrate", "primary.habitat", 
        "secondary.habitat", "seed.disperser", "slavemaker.sp", 
        "behavior", "biogeographic.affinity", "source"),
      unit = c("unit_hl", "unit_rel", "unit_rll"))
    # Has expected classes and columns
    if (i == "df") {
      expect_true(all(class(res) %in% "data.frame"))
    } else {
      expect_true(all(c("tbl_df", "tbl", "data.frame") %in% class(res)))
    }
    crit_cols <- stats::na.omit(crit$column[crit$table == "taxon_ancillary"])
    expect_true(all(crit_cols %in% colnames(res)))
    # Is not empty
    expect_true(nrow(res) != 0)
  }
})
