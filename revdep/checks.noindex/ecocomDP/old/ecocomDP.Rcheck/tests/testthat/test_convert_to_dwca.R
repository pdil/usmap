context("convert_to_dwca()")

library(ecocomDP)

# create_eml() ----------------------------------------------------------------

testthat::test_that("Creates tables, meta, and valid EML", {
  testthat::skip_on_cran()
  
  # Create directory for DwC-A outputs
  mypath <- paste0(tempdir(), "/data")
  dir.create(mypath)
  
  # Convert an EDI published ecocomDP dataset to a DwC-A
  suppressWarnings(
    convert_to_dwca(
      path = mypath, 
      core_name = "event", 
      source_id = "edi.193.4", 
      derived_id = "edi.834.1", 
      user_id = "ecocomdp",
      user_domain = "EDI"))
  
  # Test
  expect_true(EML::eml_validate(paste0(mypath, "/edi.834.1.xml")))
  expect_true("event.csv" %in% dir(mypath))
  expect_true("extendedmeasurementorfact.csv" %in% dir(mypath))
  expect_true("meta.xml" %in% dir(mypath))
  expect_true("occurrence.csv" %in% dir(mypath))
  
  # Clean up
  unlink(mypath, recursive = TRUE)
})

