context("utilities.R")

library(ecocomDP)

# detect_data_type ------------------------------------------------------------

testthat::test_that("Possible returns from detect_data_type()", {
  
  # dataset (valid)
  dataset_new <- ants_L1
  dataset_new$id <- ants_L1$id
  expect_equal(detect_data_type(dataset_new), "dataset")
  # dataset (unrecognized)
  dataset_new$tables <- NULL
  expect_error(detect_data_type(dataset_new), regexp = "not one")
  
  # list_of_datasets (valid)
  list_of_datasets <- list(ants_L1, ants_L1)
  expect_equal(detect_data_type(list_of_datasets), "list_of_datasets")
  # list_of_datasets (unrecognized)
  list_of_datasets[[1]]$tables <- NULL
  expect_error(detect_data_type(list_of_datasets), regexp = "not one")
  
  # table (valid)
  table <- ants_L1$tables$observation
  expect_equal(detect_data_type(table), "table")
  # table (unrecognized)
  table <- table$observation_id
  expect_error(detect_data_type(table), regexp = "not one")
  
  # list_of_tables (valid)
  list_of_tables <- ants_L1$tables
  expect_equal(detect_data_type(list_of_tables), "list_of_tables")
  # list_of_tables (unrecognized)
  names(list_of_tables) <- rep("bad_table_name", length(list_of_tables))
  expect_error(detect_data_type(list_of_tables), regexp = "not one")
  
  # dataset_old (valid)
  dataset_old <- ants_L1
  id <- ants_L1$id
  dataset_old$id <- NULL
  dataset_old <- list(dataset_old)
  names(dataset_old) <- id
  expect_equal(suppressWarnings(detect_data_type(dataset_old)), "dataset_old")
  # Not testing invalid forms because everything else at this point would 
  # be a recognized type or unrecognized
  
  # list_of_datasets_old (valid)
  dataset_old <- ants_L1
  id <- ants_L1$id
  dataset_old$id <- NULL
  dataset_old <- list(dataset_old)
  names(dataset_old) <- id
  list_of_datasets_old <- list(dataset_old, dataset_old)
  expect_equal(detect_data_type(list_of_datasets_old), "list_of_datasets_old")
  # Not testing invalid forms because everything else at this point would 
  # be a recognized type or unrecognized
  
})

# detect_delimiter() - Primary method -----------------------------------------

testthat::test_that("Primary method of detect_delimiter()", {
  # The primary method of this function relies on the verbose output of data.table::fread(). Therefore any changes to the output structure will compromise the return value and should be corrected ASAP. The urgency of a fix is lessened by a secondary approach that works well.
  f <- system.file("extdata", "/ecocomDP/attributes_observation.txt", package = "ecocomDP")
  msg <- utils::capture.output(data.table::fread(f, verbose = TRUE) %>% {NULL}) # This is the method in question
  seps <- stringr::str_extract_all(msg, "(?<=(sep=')).+(?='[:blank:])")
  sep <- unique(unlist(seps))
  expect_length(sep, 1)
})

# get_id ----------------------------------------------------------------------

testthat::test_that("Possible inputs to get_id()", {
  # dataset
  dataset <- ants_L1
  dataset$id <- ants_L1$id
  expect_true(nchar(get_id(dataset)) > 1)
  # dataset_old
  dataset_old <- ants_L1
  expect_true(nchar(get_id(dataset_old)) > 1)
  # Unsupported type
  expect_equal(get_id(ants_L1$tables), NA_character_)
})

# get_observation_table -------------------------------------------------------

testthat::test_that("Possible inputs to get_observation_table()", {
  
  # dataset (valid)
  x <- ants_L1
  res <- get_observation_table(x)
  expect_true("data.frame" %in% class(res))
  # dataset (missing observation table)
  x <- ants_L1
  x$tables$observation <- NULL
  expect_error(get_observation_table(x), "does not contain")
  
  # list_of_tables (valid)
  x <- ants_L1$tables
  res <- get_observation_table(x)
  expect_true("data.frame" %in% class(res))
  # list_of_tables (missing observation table)
  x <- ants_L1$tables
  x$observation <- NULL
  expect_error(get_observation_table(x), "does not contain")
  
  # table (valid)
  x <- ants_L1$tables$observation
  res <- get_observation_table(x)
  expect_true("data.frame" %in% class(res))
  
  # table (invalid; NULL)
  expect_error(get_observation_table(NULL), "not one of")
  
  # dataset_old (valid)
  x <- ants_L1
  res <- get_observation_table(x)
  expect_true("data.frame" %in% class(res))
  # dataset_old (missing observation table)
  x$tables$observation <- NULL
  expect_error(get_observation_table(x), regexp = "does not contain")
})

testthat::test_that("Expected columns; get_observation_table()", {
  # table (valid)
  x <- ants_L1$tables$observation[, 1:3]
  expect_error(get_observation_table(x))
})

# is_edi(), is_neon() ---------------------------------------------------------

testthat::test_that("Identify source from id string", {
  expect_true(is_edi("edi.100.1"))
  expect_false(is_edi("edi.100"))
  expect_true(is_edi("knb-lter-ntl.100.1"))
  expect_false(is_edi("knb-lter-ntl.100"))
  expect_true(is_neon("neon.ecocomdp.20166.001.001"))
  expect_false(is_neon("ecocomdp.20166.001.001"))
})

# parse_datetime_frmt_from_vals() ---------------------------------------------

testthat::test_that("parse_datetime_frmt_from_vals()", {
  expect_equal(
    parse_datetime_frmt_from_vals(vals = "2021-07-11 13:20:00"),
    "YYYY-MM-DD hh:mm:ss")
  expect_equal(
    parse_datetime_frmt_from_vals(vals = "2021-07-11 13:20"),
    "YYYY-MM-DD hh:mm")
  expect_equal(
    parse_datetime_frmt_from_vals(vals = "2021-07-11 13"),
    "YYYY-MM-DD hh")
  expect_equal(
    parse_datetime_frmt_from_vals(vals = "2021-07-11"),
    "YYYY-MM-DD")
  expect_equal(
    parse_datetime_frmt_from_vals(vals = "2021"),
    "YYYY")
  expect_null(
    parse_datetime_frmt_from_vals(vals = NA))
  expect_null(
    parse_datetime_frmt_from_vals(vals = NA_character_))
  suppressWarnings(
    expect_equal(
      parse_datetime_frmt_from_vals(vals = c("2021-07-11", "2021", NA_character_)),
      "YYYY-MM-DD"))
  expect_warning(
    parse_datetime_frmt_from_vals(vals = c("2021-07-11", "2021", NA_character_)),
    regexp = "The best match .+ may not describe all datetimes")
})

# parse_datetime_from_frmt() --------------------------------------------------

testthat::test_that("parse_datetime_from_frmt()", {
  mytbl <- "observation"
  expect_equal(
    parse_datetime_from_frmt(tbl = mytbl,
                             vals = "2021-07-11 13:20:00",
                             frmt = "YYYY-MM-DD hh:mm:ss"),
    lubridate::ymd_hms("2021-07-11 13:20:00"))
  expect_equal(
    parse_datetime_from_frmt(tbl = mytbl,
                             vals = "2021-07-11 13:20",
                             frmt = "YYYY-MM-DD hh:mm"),
    lubridate::ymd_hm("2021-07-11 13:20"))
  expect_equal(
    parse_datetime_from_frmt(tbl = mytbl,
                             vals = "2021-07-11 13",
                             frmt = "YYYY-MM-DD hh"),
    lubridate::ymd_h("2021-07-11 13"))
  expect_equal(
    parse_datetime_from_frmt(tbl = mytbl,
                             vals = "2021-07-11",
                             frmt = "YYYY-MM-DD"),
    lubridate::ymd("2021-07-11"))
  expect_equal(
    suppressWarnings(parse_datetime_from_frmt(tbl = mytbl,
                                              vals = "2021",
                                              frmt = "YYYY")),
    lubridate::ymd_h("2021-01-01 00"))
  expect_warning(
    parse_datetime_from_frmt(tbl = mytbl,
                             vals = "2021",
                             frmt = "YYYY"),
    regexp = "Input datetimes have format \'YYYY\' but are being returned as \'YYYY-MM-DD\'.")
  expect_warning(
    parse_datetime_from_frmt(tbl = mytbl,
                             vals = c("2021-07-11", "2021-07-11 13:20"),
                             frmt = "YYYY-MM-DD"),
    regexp = "1 observation datetime strings failed to parse")
})

# write_tables() --------------------------------------------------------------

testthat::test_that("write_tables()", {
  # Parameterize
  mypath <- paste0(tempdir(), "/data")
  unlink(mypath, recursive = TRUE)
  dir.create(mypath)
  flat <- ants_L0_flat
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
  # Write tables to file
  write_tables(
    path = mypath, 
    observation = observation, 
    observation_ancillary = observation_ancillary)
  # Test
  expect_true(file.exists(paste0(mypath, "/observation.csv")))
  expect_true(file.exists(paste0(mypath, "/observation_ancillary.csv")))
  # Clean up
  unlink(mypath, recursive = TRUE)
})


# get_eol -----------------------------------------------------------------

test_that("get_eol works", {
  
  # Create tempfiles
  
  tmp_newline <- tempfile(fileext = '.txt')
  tmp_carriage <- tempfile(fileext = '.txt')
  tmp_carriage_newline <- tempfile(fileext = '.txt')
  
  # Create text
  
  newline <- paste(rep("A line\n", 10), collapse = "")
  carriage <- paste(rep("A line\r", 10), collapse = "")
  carriage_newline <- paste(rep("A line\r\n", 10), collapse = "")
  
  # Put test text into temp files
  
  writeChar(newline, tmp_newline, eos = NULL, useBytes = TRUE)
  writeChar(carriage, tmp_carriage, eos = NULL, useBytes = TRUE)
  writeChar(carriage_newline, tmp_carriage_newline, eos = NULL, useBytes = TRUE)
  
  # Test expectations
  
  expect_equal(
    object = get_eol(tempdir(), file.name = basename(tmp_newline)),
    expected = "\\n"
  )
  expect_equal(
    object = get_eol(tempdir(), file.name = basename(tmp_carriage)),
    expected = "\\r"
  )
  expect_equal(
    object = get_eol(tempdir(), file.name = basename(tmp_carriage_newline)),
    expected = "\\r\\n"
  )
  
})
