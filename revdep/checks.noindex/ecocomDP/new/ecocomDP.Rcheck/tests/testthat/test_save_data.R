context("save_data()")

# 1 dataset -------------------------------------------------------------------

testthat::test_that("1 dataset saved to format w/expected structure", {
  criteria <- read_criteria()
  d <- ants_L1
  ids <- d$id
  # .rds
  pathrds <- paste0(tempdir(),"/d.rds")
  unlink(pathrds, recursive = TRUE, force = TRUE)
  save_data(d, tempdir(), type = ".rds") # .rds
  expect_true(file.exists(pathrds)) # was created
  unlink(pathrds, recursive = TRUE, force = TRUE)
  # .csv
  pathcsv <- paste0(tempdir(),"/d")
  unlink(pathcsv, recursive = TRUE, force = TRUE)
  dir.create(pathcsv)
  save_data(d, pathcsv, type = ".csv") # .csv
  expect_true(all(ids %in% dir(pathcsv))) # dir has subdirs
  r <- lapply(
    dir(pathcsv),
    function(dataset) {
      dname <- paste0(pathcsv, "/", dataset)
      fnames <- tools::file_path_sans_ext(list.files(dname)) # dir has tables
      expect_true(all(fnames %in% unique(criteria$table)))
      fext <- unique(tools::file_ext(list.files(dname))) # has file extension
      expect_equal(fext, "csv")
    })
  unlink(pathcsv, recursive = TRUE, force = TRUE)
})

# > 1 dataset -----------------------------------------------------------------

testthat::test_that("> 1 dataset saved to format w/expected structure", {
  criteria <- read_criteria()
  d <- ants_L1
  datasets <- list(d, d, d)
  ids <- c("edi.193.3", "edi.262.1", "edi.359.1")
  for (i in 1:length(datasets)) {
    datasets[[i]]$id <- ids[i]
  }
  # .rds
  pathrds <- paste0(tempdir(),"/datasets.rds")
  unlink(pathrds, recursive = TRUE, force = TRUE)
  save_data(datasets, tempdir(), type = ".rds") # .rds
  expect_true(file.exists(pathrds)) # was created
  unlink(pathrds, recursive = TRUE, force = TRUE)
  # .csv
  pathcsv <- paste0(tempdir(),"/datasets")
  unlink(pathcsv, recursive = TRUE, force = TRUE)
  dir.create(pathcsv)
  save_data(datasets, pathcsv, type = ".csv") # .csv
  expect_true(all(ids %in% dir(pathcsv))) # dir has subdirs
  r <- lapply(
    dir(pathcsv),
    function(dataset) {
      dname <- paste0(pathcsv, "/", dataset)
      fnames <- tools::file_path_sans_ext(list.files(dname)) # dir has tables
      expect_true(all(fnames %in% unique(criteria$table)))
      fext <- unique(tools::file_ext(list.files(dname))) # has file extension
      expect_equal(fext, "csv")
    })
  unlink(pathcsv, recursive = TRUE, force = TRUE)
})

# name argument ---------------------------------------------------------------

testthat::test_that("control names with name", {
  criteria <- read_criteria()
  d <- ants_L1
  id <- d$id
  pathrds <- paste0(tempdir(), "/mydata.rds")
  unlink(pathrds, recursive = TRUE, force = TRUE)
  save_data(d, tempdir(), type = ".rds", name = "mydata")
  expect_true(file.exists(pathrds))
  unlink(pathrds, recursive = TRUE, force = TRUE)
})

