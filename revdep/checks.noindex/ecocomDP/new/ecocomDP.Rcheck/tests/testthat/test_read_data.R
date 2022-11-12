context("read_data()")

# Reads from source APIs ------------------------------------------------------

testthat::test_that("Reads from source APIs", {
  testthat::skip_on_cran()
  
  criteria <- read_criteria()
  # From EDI
  id <- "edi.193.5"
  d <- try(suppressWarnings(read_data(id = id)), silent = TRUE)
  if (class(d) != "try-error") { # Has expected structure
    expect_true(is.list(d)) # obj is a list
    expect_true(d$id == id) # has expected id value
    expect_true(all(names(d) %in% c("id", "metadata", "tables", "validation_issues"))) # has 4 names
    for (i in names(d)) { # objs are lists or char
      if (i != "id") {
        expect_true(is.list(d[[i]]))
      } else {
        expect_true(is.character(d[[i]]))
      }
    }
    expect_true(all(names(d$tables) %in% unique(criteria$table))) # table names are valid
    for (i in names(d$tables)) { # tables are data.frames
      expect_true(class(d$tables[[i]]) == "data.frame")
    }
  }
  # From NEON
  id <- "neon.ecocomdp.20107.001.001"
  d <- try(
    suppressWarnings(
      read_data(
        id = id, 
        site = c("MAYF", "CARI"), 
        startdate = "2016-01", 
        enddate = "2016-12", 
        check.size = FALSE)), 
    silent = TRUE)
  if (class(d) != "try-error") { # Has expected structure
    expect_true(is.list(d)) # obj is a list
    expect_true(d$id == id) # has expected id value
    expect_true(all(names(d) %in% c("id", "metadata", "tables", "validation_issues"))) # has 4 names
    for (i in names(d)) { # objs are lists or char
      if (i != "id") {
        expect_true(is.list(d[[i]]))
      } else {
        expect_true(is.character(d[[i]]))
      }
    }
    expect_true(all(names(d$tables) %in% unique(criteria$table))) # table names are valid
    for (i in names(d$tables)) { # tables are data.frames
      expect_true(class(d$tables[[i]]) == "data.frame")
    }
    expect_true( # datetimes are parsed (this is a check on NEON mapping functions)
      all(
        class(d$tables$observation$datetime) %in% c("POSIXct", "POSIXt")))
    expect_equal(
      class(d$tables$location_ancillary$datetime),
      "Date")
  }
})


# Reads from local .rds -------------------------------------------------------

testthat::test_that("Reads from 1 local .rds", {
  rdspath <- paste0(tempdir(), "/d.rds")
  unlink(rdspath, recursive = TRUE, force = TRUE) 
  criteria <- read_criteria()
  d <- ants_L1
  id <- d$id
  save_data(d, tempdir())
  d <- read_data(from = rdspath) # Has expected structure
  if (class(d) != "try-error") {                                                      # Has expected structure
    expect_true(is.list(d))                                                           # obj is a list
    expect_true(d$id == id)                                                           # has expected id value
    expect_true(all(names(d) %in% c("id", "metadata", "tables", "validation_issues")))# has 4 names
    for (i in names(d)) {                                                             # objs are lists or char
      if (i != "id") {
        expect_true(is.list(d[[i]]))
      } else {
        expect_true(is.character(d[[i]]))
      }
    }
    expect_true(all(names(d$tables) %in% unique(criteria$table)))                     # table names are valid
    for (i in names(d$tables)) {                                                      # tables are data.frames
      expect_true("data.frame" %in% class(d$tables[[i]]))
    }
  }
  unlink(paste0(tempdir(), "/d.rds"), recursive = TRUE, force = TRUE) 
})


testthat::test_that("Reads from > 1 local .rds", {
  rdspath <- paste0(tempdir(), "/d.rds")
  unlink(rdspath, recursive = TRUE, force = TRUE) 
  criteria <- read_criteria()
  # From .rds
  d <- ants_L1
  d <- list(d, d, d)
  ids <- c("edi.193.3", "edi.262.1", "edi.359.1")
  for (i in 1:length(d)) {
    d[[i]]$id <- ids[i]
  }
  save_data(d, tempdir())
  d <- read_data(from = rdspath) # Has expected structure
  if (class(d) != "try-error") { # Has expected structure
    for (i in 1:length(d)) {
      expect_true(is.list(d[[i]])) # obj is a list
      expect_true(d[[i]]$id == ids[i]) # has expected id value
      expect_true(all(names(d[[i]]) %in% c("id", "metadata", "tables", "validation_issues")))# has 4 names
      for (j in names(d[[i]])) { # objs are lists or char
        if (j != "id") {
          expect_true(is.list(d[[i]][[j]]))
        } else {
          expect_true(is.character(d[[i]][[j]]))
        }
      }
      expect_true(all(names(d[[i]]$tables) %in% unique(criteria$table))) # table names are valid
      for (j in names(d[[i]]$tables)) { # tables are data.frames
        expect_true("data.frame" %in% class(d[[i]]$tables[[j]]))
      }
    }
  }
  unlink(paste0(tempdir(), "/d.rds"), recursive = TRUE, force = TRUE) 
})

# Reads from local .csv directories -------------------------------------------

testthat::test_that("Reads from 1 local .csv directories", {
  criteria <- read_criteria()
  # From .csv
  d <- ants_L1 # create example datasets
  d <- list(d, d, d)
  ids <- c("edi.193.3", "edi.262.1", "edi.359.1")
  for (i in 1:length(ids)) {
    d[[i]]$id <- ids[i]
  }
  id <- "d"
  unlink(paste0(tempdir(),"/", ids), recursive = TRUE, force = TRUE) 
  save_data(d, tempdir(), type = ".csv")
  d <- read_data(from = tempdir())            # Has expected structure
  expect_true(is.list(d))                                                             # obj is a list
  for (i in seq_along(d)) {
    expect_true(ids[i] %in% d[[i]]$id)                                                     # has expected id
    expect_true(all(names(d[[i]]) %in% c("id", "metadata", "tables", "validation_issues")))# has 4 values
    for (j in names(d[[i]])) {                                                             # objs are lists
      if (j != "metadata" & j != "id") {                                              # metadata is lost when written to .csv
        expect_true(is.list(d[[i]][[j]]))
      }
    }
    expect_true(all(names(d[[i]]$tables) %in% unique(criteria$table)))                # table names are valid
    for (j in names(d[[i]]$tables)) {                                                 # tables are data.frames
      expect_true(class(d[[i]]$tables[[j]]) == "data.frame")
    }
  }
  unlink(paste0(tempdir(),"/", ids), recursive = TRUE, force = TRUE) 
})

testthat::test_that("Reads from > 1 local .csv directories", {
  criteria <- read_criteria()
  # From .csv
  d <- ants_L1 # create example datasets
  ids <- d$id
  id <- "d"
  unlink(paste0(tempdir(),"/", ids), recursive = TRUE, force = TRUE) 
  save_data(d, tempdir(), type = ".csv")
  d <- read_data(from = tempdir())            # Has expected structure
  expect_true(is.list(d))                                                             # obj is a list
  expect_true(ids %in% d$id)                                                     # has expected id
  expect_true(all(names(d) %in% c("id", "metadata", "tables", "validation_issues")))# has 4 values
  for (j in names(d)) {                                                             # objs are lists
    if (j != "metadata" & j != "id") {                                              # metadata is lost when written to .csv
      expect_true(is.list(d[[j]]))
    }
  }
  expect_true(all(names(d$tables) %in% unique(criteria$table)))                # table names are valid
  for (j in names(d$tables)) {                                                 # tables are data.frames
    expect_true("data.frame" %in% class(d$tables[[j]]))
  }
  unlink(paste0(tempdir(),"/", ids), recursive = TRUE, force = TRUE) 
})

# Reads tables with valid names in path ---------------------------------------

testthat::test_that("Reads tables with valid names in path", {
  # Parameterize
  mytopdir <- tempdir()
  mypath <- paste0(mytopdir, "/datasets")
  unlink(mypath, recursive = TRUE, force = TRUE)
  dir.create(mypath)
  crit <- read_criteria()
  d <- ants_L1
  # Set up test files
  save_data(d, mypath, type = ".csv")
  readpath <- paste0(mypath, "/", d$id)
  # Test
  d_fromfile <- read_data(from = readpath)
  expect_true(all(names(d_fromfile$tables) %in% unique(crit$table)))
  expect_equal(length(d_fromfile$tables), length(dir(readpath)))
  unlink(mypath, recursive = TRUE, force = TRUE)
})

# Ignores tables with invalid names in path -----------------------------------

testthat::test_that("Ignores tables with invalid names in path", {
  # Parameterize
  mytopdir <- tempdir()
  mypath <- paste0(mytopdir, "/datasets")
  unlink(mypath, recursive = TRUE, force = TRUE)
  dir.create(mypath)
  crit <- read_criteria()
  d <- ants_L1
  # Set up test files
  tblnms <- names(d$tables)
  tblnms[c(1,2)] <- c("1", "2") 
  names(d$tables) <- tblnms
  save_data(d, mypath, type = ".csv")
  readpath <- paste0(mypath, "/", d$id)
  # Test
  expect_warning(read_data(from = readpath), regexp = "Validation issues")
  d_fromfile <- suppressWarnings(read_data(from = readpath))
  expect_true(!any(c("1", "2") %in% names(d_fromfile$tables)))
  expect_true(all(names(d_fromfile$tables) %in% unique(crit$table)))
  expect_false(length(d_fromfile$tables) == length(dir(readpath)))
  unlink(mypath, recursive = TRUE, force = TRUE)
})

# Has datetime parsing option -------------------------------------------------

testthat::test_that("Has datetime parsing option", {
  criteria <- read_criteria()
  d <- ants_L1
  id <- d$id
  save_data(d, tempdir())
  d <- suppressWarnings(
    read_data(from = paste0(tempdir(), "/d.rds"), parse_datetime = TRUE))      # not character
  for (tbl in names(d$tables)) {
    for (colname in colnames(d$tables[[tbl]]))
      if (stringr::str_detect(colname, "datetime")) {
        expect_true(class(d$tables[[tbl]][[colname]]) != "character")
      }
  }
  d <- suppressWarnings(
    read_data(from = paste0(tempdir(), "/d.rds"), parse_datetime = FALSE))     # character
  for (tbl in names(d$tables)) {
    for (colname in colnames(d$tables[[tbl]]))
      if (stringr::str_detect(colname, "datetime")) {
        expect_true(class(d$tables[[tbl]][[colname]]) == "character")
      }
  }
  unlink(paste0(tempdir(), "/d.rds"), recursive = TRUE, force = TRUE)
})

