context("create_variable_mapping()")

library(ecocomDP)

# create_variable_mapping() ---------------------------------------------------

testthat::test_that("Standard L1 column inputs", {
  for (i in c("df", "tbbl")) {
    if (i == "df") { # test w/data.frame
      flat <- as.data.frame(ants_L0_flat)
    } else {      # test w/tibble
      flat <- ants_L0_flat
    }
    crit <- read_criteria()
    # Create input tables
    observation <- create_observation(
      L0_flat = flat, 
      observation_id = "observation_id", 
      event_id = "event_id", 
      package_id = "package_id",
      location_id = "location_id", 
      datetime = "datetime", 
      taxon_id = "taxon_id", 
      variable_name = "variable_name",
      value = "value",
      unit = "unit")
    observation_ancillary <- create_observation_ancillary(
      L0_flat = flat,
      observation_id = "observation_id", 
      variable_name = c("trap.type", "trap.num", "moose.cage"))
    location_ancillary <- create_location_ancillary(
      L0_flat = flat,
      location_id = "location_id",
      variable_name = "treatment")
    taxon_ancillary <- create_taxon_ancillary(
      L0_flat = flat,
      taxon_id = "taxon_id",
      variable_name = c(
        "subfamily", "hl", "rel", "rll", "colony.size", 
        "feeding.preference", "nest.substrate", "primary.habitat", 
        "secondary.habitat", "seed.disperser", "slavemaker.sp", 
        "behavior", "biogeographic.affinity", "source"),
      unit = c("unit_hl", "unit_rel", "unit_rll"))
    # Create variable mapping
    res <- create_variable_mapping(
      observation = observation,
      observation_ancillary = observation_ancillary,
      location_ancillary = location_ancillary, 
      taxon_ancillary = taxon_ancillary)
    # Has expected classes and columns
    if (i == "df") {
      expect_true(all(class(res) %in% "data.frame"))
    } else {
      expect_true(all(c("tbl_df", "tbl", "data.frame") %in% class(res)))
    }
    crit_cols <- stats::na.omit(crit$column[crit$table == "variable_mapping"])
    expect_true(all(crit_cols %in% colnames(res)))
    # Is not empty
    expect_true(nrow(res) != 0)
  }
})
