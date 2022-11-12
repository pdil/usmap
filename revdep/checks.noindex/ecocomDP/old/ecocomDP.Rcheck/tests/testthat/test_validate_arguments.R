# Tests are organized around function calls (e.g. all tests listed under 
# search_data() are relevant to the argument inputs to that function).

context("validate_arguments()")

library(ecocomDP)

# convert_*() -----------------------------------------------------------------

testthat::test_that("convert_to_dwca()", {
  # core_name
  inputs <- as.list(
    list(core_name = "core"))
  expect_error(validate_arguments("convert_to_dwca", inputs), 
               regexp = "Invalid input to 'core_name'")
})

# create_eml() ----------------------------------------------------------------

testthat::test_that("create_eml()", {
  
  # parameterize
  testdir <- paste0(tempdir(), "/testing")
  dir.create(testdir)
  file.copy(system.file("extdata", "create_ecocomDP.R", package = "ecocomDP"), testdir)
  
  # basis_of_record (supported types)
  expect_null(
    validate_arguments("create_eml", 
                       as.list(list(path = testdir,
                                    basis_of_record = "HumanObservation",
                                    script = "create_ecocomDP.R",
                                    script_description = "A description."))))
  expect_null(
    validate_arguments("create_eml", 
                       as.list(list(path = testdir,
                                    basis_of_record = "MachineObservation",
                                    script = "create_ecocomDP.R",
                                    script_description = "A description."))))
  expect_error(
    validate_arguments("create_eml", 
                       as.list(list(path = testdir,
                                    basis_of_record = "not_an_option",
                                    script = "create_ecocomDP.R",
                                    script_description = "A description."))),
    regexp = "Invalid input to 'basis_of_record'")
  
  # basis_of_record (only one is allowed)
  expect_error(
    validate_arguments("create_eml", 
                       as.list(list(basis_of_record = c("HumanObservation", "MachineObservation")))),
    regexp = "Only one basis_of_record is allowed.")
  
  # script (Input arg 'script' and 'script_description' is missing)
  expect_error(
    validate_arguments("create_eml", as.list(list(path = "test"))),
    regexp = "Input \'script\' is missing.")
  expect_error(
    validate_arguments("create_eml", 
                       as.list(
                         list(path = testdir,
                              script = "create_ecocomDP.R"))),
    regexp = "Input \'script_description\' is missing.")
  
  # script (Only one is allowed)
  expect_error(
    validate_arguments("create_eml", 
                       as.list(
                         list(script = c("create_ecocomDP.R", "another.R"),
                              script_description = "A description."))),
    regexp = "Only one \'script\' is allowed.")
  
  # script (Can be found in path)
  expect_error(
    validate_arguments("create_eml", 
                       as.list(
                         list(path = testdir,
                              script = "not_in_path.R",
                              script_description = "A description."))),
    regexp = "The \'script\' not_in_path.R cannot be found")
  
  # script (Has name 'create_ecocomDP.R')
  file.rename(
    paste0(testdir, "/create_ecocomDP.R"),
    paste0(testdir, "/create_ecocom.R"))
  expect_error(
    validate_arguments("create_eml", 
                       as.list(
                         list(path = testdir,
                              script = "create_ecocom.R",
                              script_description = "A description."))),
    regexp = "The \'script\' must have the name:")
  file.rename(
    paste0(testdir, "/create_ecocom.R"),
    paste0(testdir, "/create_ecocomDP.R"))
  
  # script (When sourced has 'create_ecocomDP()' and expected arguments)
  expect_null(
    validate_arguments("create_eml", 
                       as.list(
                         list(path = testdir,
                              script = "create_ecocomDP.R",
                              script_description = "A description."))))
  # Clean up
  unlink(testdir, recursive = TRUE)
})

# create_tables() -------------------------------------------------------------

# NOTE: validate_arguments() returns values to the calling environment (here),
# so tests are confined to func calls which are garbage collected.

testthat::test_that("create_*(): L0 cols match L1 cols", {
  flat <- ants_L0_flat
  inputs <- as.list(
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      datetime = "datetime",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("unit_hl", "unit_rel")))
  validate_arguments("create_taxon_ancillary", inputs)
  # Outputs match inputs
  expect_true(identical(inputs$L0_flat, L0_flat))
  expect_equal(inputs$taxon_id, taxon_id)
  expect_equal(inputs$datetime, datetime)
  expect_equal(inputs$variable_name, variable_name)
  expect_equal(inputs$unit, unit)
})

testthat::test_that("create_*(): L0 cols map to L1 cols", {
  flat <- ants_L0_flat
  cols <- colnames(flat) # change some L0 col names
  cols[cols == "taxon_id"] <- "taxon_code"
  cols[cols == "datetime"] <- "date"
  cols[cols == "hl"] <- "head_length"
  cols[cols == "unit_hl"] <- "unit_head_length"
  colnames(flat) <- cols
  inputs <- as.list(
    list(
      L0_flat = flat,
      taxon_id = "taxon_code",
      datetime = "date",
      variable_name = c("head_length", "rel", "colony.size"),
      unit = c("unit_head_length", "unit_rel")))
  validate_arguments("create_taxon_ancillary", inputs)
  # After validation, the L0 cols have been replaced by L1 cols
  expect_false(identical(inputs$L0_flat, L0_flat))
  expect_true(!any(c("date", "taxon_code") %in% colnames(L0_flat)))
  expect_true(all(c("datetime", "taxon_id") %in% colnames(L0_flat)))
  expect_true(taxon_id == "taxon_id")
  expect_true(datetime == "datetime")
  # but the variable_name and unit cols have been untouched.
  expect_equal(inputs$variable_name, variable_name)
  expect_equal(inputs$unit, unit)
})

testthat::test_that("create_*(): Error if inputs cols are not in L0_flat", {
  
  flat <- ants_L0_flat
  
  inputs <- as.list( # An _id column
    list(
      L0_flat = flat,
      taxon_id = "not_an_id_col",
      datetime = "datetime",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("unit_hl", "unit_rel")))
  expect_error(validate_arguments("create_taxon_ancillary", inputs), 
               regexp = "Columns not in \'L0_flat\': not_an_id_col")
  
  inputs <- as.list( # A datetime column
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      datetime = "not_a_datetime_column",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("unit_hl", "unit_rel")))
  expect_error(validate_arguments("create_taxon_ancillary", inputs), 
               regexp = "Columns not in \'L0_flat\': not_a_datetime_column")
  
  inputs <- as.list( # A variable_name column
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      datetime = "datetime",
      variable_name = c("hl", "rel", "colony.size", "not_a_varname_col"),
      unit = c("unit_hl", "unit_rel")))
  expect_error(validate_arguments("create_taxon_ancillary", inputs), 
               regexp = "Columns not in \'L0_flat\': not_a_varname_col")
  
  inputs <- as.list(  # A unit column
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      datetime = "datetime",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("unit_hl", "unit_rel", "not_a_unit_col")))
  expect_error(validate_arguments("create_taxon_ancillary", inputs), 
               regexp = "Columns not in \'L0_flat\': not_a_unit_col")
  
  inputs <- as.list(  # A location_name column
    list(
      L0_flat = flat,
      location_id = "location_id",
      latitude = "latitude",
      longitude = "longitude", 
      elevation = "elevation",
      location_name = c("not_a_nesting_col")))
  expect_error(validate_arguments("create_location", inputs), 
               regexp = "Columns not in \'L0_flat\': not_a_nesting_col")

})

testthat::test_that("create_*(): NULL cols are fine when not required", {
  flat <- ants_L0_flat
  inputs <- as.list(
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("unit_hl", "unit_rel")))
  expect_null(validate_arguments("create_taxon_ancillary", inputs))
})

testthat::test_that("create_*(): unit format", {
  flat <- ants_L0_flat
  inputs <- as.list(
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("hl", "rel")))
  expect_error(validate_arguments("create_taxon_ancillary", inputs),
               regexp = "Unexpected \'unit\' formats: hl, rel")
})

testthat::test_that("create_*(): unit without matching variable_name", {
  flat <- ants_L0_flat
  cols <- colnames(flat)
  cols[1] <- "unit_nomatch"
  colnames(flat) <- cols
  inputs <- as.list(
    list(
      L0_flat = flat,
      taxon_id = "taxon_id",
      variable_name = c("hl", "rel", "colony.size"),
      unit = c("unit_nomatch", "unit_rel")))
  expect_error(validate_arguments("create_taxon_ancillary", inputs),
               regexp = "Input \'unit\' without .+ match: unit_nomatch")
})

testthat::test_that("create_observation(): only 1 variable_name, value, unit", {
  flat <- ants_L0_flat
  inputs <- as.list(
    list(
      L0_flat = flat,
      observation_id = "observation_id",
      event_id = "event_id",
      package_id = "package_id",
      location_id = "location_id",
      datetime = "datetime",
      taxon_id = "taxon_id",
      variable_name = c("input1", "input2"),
      value = c("input1", "input2"),
      unit = c("input1", "input2")))
  expect_error(validate_arguments("create_observation", inputs),
               regexp = "Only one input is allowed")
})

# flatten_data() --------------------------------------------------------------

testthat::test_that("flatten_data()", {
  # expected input
  expect_null(
    validate_arguments("flatten_data", 
                       as.list(list(tables = ants_L1$tables))))
  # bad names
  badnms <- names(ants_L1$tables)
  badnms[1] <- "a bad name"
  names(ants_L1$tables) <- badnms
  expect_error(
    validate_arguments("flatten_data", 
                       as.list(list(tables = ants_L1$tables))), 
    regexp = "Unrecognized tables")
  # invalid structure
  expect_error(
    validate_arguments("flatten_data", 
                       as.list(list(tables = ants_L1$tables$taxon))), 
    regexp = "Input 'tables' should be a list")
})

# plot_*() --------------------------------------------------------------------

testthat::test_that("plot_*()", {
  # alpha
  expect_null(validate_arguments("plot", as.list(list(alpha = 1))))         # is between 0 and 1
  expect_error(validate_arguments("plot", as.list(list(alpha = -1))))
  expect_error(validate_arguments("plot", as.list(list(alpha = 2))))
  # time_window_size
  expect_null(validate_arguments("plot", as.list(list(time_window_size = "day"))))
  expect_null(validate_arguments("plot", as.list(list(time_window_size = "month"))))
  expect_null(validate_arguments("plot", as.list(list(time_window_size = "year"))))
  expect_error(
    object = validate_arguments("plot", as.list(list(time_window_size = "invalid"))), 
    regexp = 'must be \"day\", \"month\",or \"year\"')
  # facet_scales
  expect_null(validate_arguments("plot", as.list(list(facet_scales = "free"))))
  expect_null(validate_arguments("plot", as.list(list(facet_scales = "fixed"))))
  expect_null(validate_arguments("plot", as.list(list(facet_scales = "free_x"))))
  expect_null(validate_arguments("plot", as.list(list(facet_scales = "free_y"))))
  expect_error(
    object = validate_arguments("plot", as.list(list(facet_scales = "month"))), 
    regexp = 'must be')
})



# read_data() -----------------------------------------------------------------

testthat::test_that("read_data()", {
  # id
  expect_error(
    validate_arguments("read_data", as.list(list(id = 1))), 
    regexp = "Input 'id' should be character.")
  testthat::test_that("valid id", {
    testthat::skip_on_cran()
    expect_error(                                                             # exists
      validate_arguments("read_data", as.list(list(id = "edi.x.x"))), 
      regexp = "Invalid identifier 'edi.x.x' cannot be read.")
    expect_warning(                                                           # warns if newer revision
      validate_arguments("read_data", as.list(list(id = "edi.124.3"))), 
      regexp = "A newer version of 'edi.124.3' is available.")
  })
  # path
  expect_null(validate_arguments("read_data", as.list(list(path = tempdir())))) # exists
  expect_error(
    validate_arguments("read_data", as.list(list(path = "/some/invalid/path"))),
    regexp = "Input \'path\' .+ doesn\'t exist.")
  # parse_datetime
  expect_null(                                                                 # is logical
    validate_arguments("read_data", as.list(list(parse_datetime = TRUE))))
  expect_error(
    validate_arguments("read_data", as.list(list(parse_datetime = "TRUE"))),
    regexp = "Input 'parse_datetime' should be logical.")
  # unique_keys
  expect_null(                                                                 # is logical
    validate_arguments("read_data", as.list(list(unique_keys = TRUE))))
  expect_error(
    validate_arguments("read_data", as.list(list(unique_keys = "TRUE"))),
    regexp = "Input 'unique_keys' should be logical.")
  # site
  testthat::test_that("Valid site", {
    testthat::skip_on_cran()
    expect_null(                                                                 # site exists for id
      validate_arguments("read_data", as.list(list(id = "neon.ecocomdp.20120.001.001",
                                                   site = c("ARIK")))))
    expect_warning(
      validate_arguments("read_data", as.list(list(id = "neon.ecocomdp.20120.001.001",
                                                   site = c("ARIK", "not an id")))),
      regexp = "Sites not available in neon.ecocomdp.20120.001.001: not an id")
  })
  # startdate
  expect_null(                                                                 # has YYYY-MM format and MM is 1-12
    validate_arguments("read_data", as.list(list(startdate = "2020-12"))))
  expect_error(
    validate_arguments("read_data", as.list(list(startdate = "2020-12-30"))),
    regexp = "Unsupported 'startdate'. Expected format is YYYY-MM.")
  expect_error(
    validate_arguments("read_data", as.list(list(startdate = "2020-13"))),
    regexp = "Unsupported 'startdate'. Expected format is YYYY-MM.")
  # enddate
  expect_null(                                                                 # has YYYY-MM format and MM is 1-12
    validate_arguments("read_data", as.list(list(enddate = "2020-12"))))
  expect_error(
    validate_arguments("read_data", as.list(list(enddate = "2020-12-30"))),
    regexp = "Unsupported 'enddate'. Expected format is YYYY-MM.")
  expect_error(
    validate_arguments("read_data", as.list(list(enddate = "2020-13"))),
    regexp = "Unsupported 'enddate'. Expected format is YYYY-MM.")
  # package
  expect_null(                                                                 # has expected type
    validate_arguments("read_data", as.list(list(package = "basic"))))
  expect_null(
    validate_arguments("read_data", as.list(list(package = "expanded"))))
  expect_error(
    validate_arguments("read_data", as.list(list(package = "invalid value"))),
    regexp = "Input 'package' should be 'basic' or 'expanded'.")
  # check.size
  expect_null(                                                                 # is logical
    validate_arguments("read_data", as.list(list(check.size = TRUE))))
  expect_error(
    validate_arguments("read_data", as.list(list(check.size = "TRUE"))),
    regexp = "Input 'check.size' should be logical.")
  # nCores
  expect_null(                                                                 # is logical
    validate_arguments("read_data", as.list(list(nCores = 1))))
  expect_error(
    validate_arguments("read_data", as.list(list(nCores = 2.5))),
    regexp = "Input 'nCores' should be integer.")
  # forceParallel
  expect_null(                                                                 # is logical
    validate_arguments("read_data", as.list(list(forceParallel = TRUE))))
  expect_error(
    validate_arguments("read_data", as.list(list(forceParallel = "TRUE"))),
    regexp = "Input 'forceParallel' should be logical.")
  # neon.data.save.dir
  expect_null(validate_arguments("read_data", as.list(list(neon.data.save.dir = tempdir())))) # exists
  expect_error(
    validate_arguments("read_data", as.list(list(neon.data.save.dir = "/some/invalid/path"))),
    regexp = "Input 'neon.data.save.dir' .+ doesn\'t exist.")
  # from
  expect_null(                                                                 # file or dir exists
    validate_arguments("read_data", as.list(list(from = tempdir()))))
  expect_error(
    validate_arguments("read_data", as.list(list(from = "/not/a/dir"))),
    regexp = "Input 'from' is a non-existant file or directory.")
})

# save_data() -----------------------------------------------------------------

testthat::test_that("save_data()", {
  # path
  expect_null(validate_arguments("save_data", as.list(list(path = tempdir())))) # exists
  expect_error(
    validate_arguments("read_data", as.list(list(path = "/some/invalid/path"))),
    regexp = "Input \'path\' .+ doesn\'t exist.")
  # type
  expect_null(                                                                 # has expected type
    validate_arguments("save_data", as.list(list(type = ".rds"))))
  expect_null(
    validate_arguments("save_data", as.list(list(type = ".csv"))))
  expect_error(
    validate_arguments("save_data", as.list(list(type = "invalid value"))),
    regexp = "Input 'type' should be '.rds' or '.csv'.")
  # dataset
  d_old <- ants_L1
  d_old$id <- NULL
  d_old <- list(d_old)
  names(d_old) <- "edi.193.5"
  arglist <- as.list(list(dataset = d_old))
  expect_error(
    object = validate_arguments("save_data", arglist),
    regexp = "format is deprecated")
})

# search_data() ---------------------------------------------------------------

testthat::test_that("search_data()", {
  
  # text
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(text = c(1, 2, 3)))))
  
  # taxa
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(taxa = c(1, 2, 3)))))
  
  # num_taxa
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(num_taxa = "Non-numeric value"))))
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(num_taxa = 1))))
  
  # num_years
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(num_years = "Non-numeric value"))))
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(num_years = 1))))
  
  # sd_years
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(sd_years = "Non-numeric value"))))
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(sd_years = 1))))
  
  # area
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(area = "Non-numeric value"))))
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(area = 1))))
  
  # boolean
  
  expect_error(
    validate_arguments(
      "search_data",
      as.list(
        list(boolean = "ANDrew"))))
  
})


# validate_data() ---------------------------------------------------------

testthat::test_that("validate_data()", {
  test_data <- ants_L1
  # path - Is valid
  expect_null(
    validate_arguments("validate_data", as.list(list(path = tempdir()))))
  expect_error(
    validate_arguments("validate_data", as.list(list(path = paste0(tempdir(), "/aoihebqlnvo333")))))
  # data.list - Is valid
  expect_null(
    validate_arguments("validate_data", as.list(list(dataset = test_data))))
})

# validate_dataset_structure() ------------------------------------------------

testthat::test_that("validate_dataset_structure()", {
  test_data <- ants_L1
  expect_null(validate_dataset_structure(test_data))
  d <- unlist(test_data)                       # obj is a list
  expect_error(validate_dataset_structure(d))
  d <- unname(test_data)                       # 1st level name is id
  expect_error(validate_dataset_structure(d))
  d <- test_data                               # 2nd level has tables
  names(d) <- c("id", "metadata", "invalid name", "validation_issues")
  expect_error(validate_dataset_structure(d))
  d <- test_data                               # table names are valid
  nms <- names(d$tables)
  nms[1] <- "invalid name"
  names(d$tables) <- nms
  expect_error(validate_dataset_structure(d))
  d <- test_data                               # tables are data.frames
  d$tables[[1]] <- as.list(d$tables[[1]])
  expect_error(validate_dataset_structure(d))
})
