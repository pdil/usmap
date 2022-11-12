context("create_eml()")

library(ecocomDP)

# create_eml() ----------------------------------------------------------------

testthat::test_that("Creates valid EML", {
  testthat::skip_on_cran()
  
  # Create directory with ecocomDP tables for create_eml()
  mypath <- paste0(tempdir(), "/data")
  dir.create(mypath)
  inpts <- c(ants_L1$tables, path = mypath)
  inpts$taxon$authority_system <- NA_character_ # Reduce func run time by minimizing web API calls
  inpts$taxon$authority_taxon_id <- NA_character_
  do.call(write_tables, inpts)
  file.copy(system.file("extdata", "create_ecocomDP.R", package = "ecocomDP"), mypath)
  
  # Describe, with annotations, what the source L0 dataset "is about"
  dataset_annotations <- c(
    `species abundance` = "http://purl.dataone.org/odo/ECSO_00001688",
    Population = "http://purl.dataone.org/odo/ECSO_00000311",
    `level of ecological disturbance` = "http://purl.dataone.org/odo/ECSO_00002588",
    `type of ecological disturbance` = "http://purl.dataone.org/odo/ECSO_00002589")
  
  # Add self as contact information incase questions arise
  additional_contact <- data.frame(
    givenName = 'Colin',
    surName = 'Smith',
    organizationName = 'Environmental Data Initiative',
    electronicMailAddress = 'ecocomdp@gmail.com',
    stringsAsFactors = FALSE)
  
  # Create EML
  eml <- create_eml(
    path = mypath,
    source_id = "knb-lter-hfr.118.32",
    derived_id = "edi.193.4",
    is_about = dataset_annotations,
    script = "create_ecocomDP.R",
    script_description = "A function for converting knb-lter-hrf.118 to ecocomDP",
    contact = additional_contact,
    user_id = 'ecocomdp',
    user_domain = 'EDI',
    basis_of_record = "HumanObservation")
  
  # Test
  expect_true(EML::eml_validate(eml))
  
  # Clean up
  unlink(mypath, recursive = TRUE)
})

