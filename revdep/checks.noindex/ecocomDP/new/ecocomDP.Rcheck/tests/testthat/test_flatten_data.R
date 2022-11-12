context("flatten_data()")

# Compare L0 flat and L1 flat - The column names and values of the L0 flat and L1 flattened tables should match, with an exception:
# 1.) Primary keys, row identifiers, of the ancillary tables are now present.

# Column presence -------------------------------------------------------------

testthat::test_that("Column presence", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    if (i == "df") { # test w/data.frame
      L0_flat <- as.data.frame(ants_L0_flat)
      for (tbl in names(ants_L1$tables)) {
        ants_L1$tables[[tbl]] <- as.data.frame(ants_L1$tables[[tbl]])
      }
    } else {      # test w/tibble
      L0_flat <- ants_L0_flat
    }
    crit <- read_criteria()
    L1_flat <- flatten_data(ants_L1$tables)
    # Adjust L0 flat to our expectations
    L0_flat$location_name <- NA_character_        # Add exception
    # TEST: All L0 flat columns (with above exceptions) should be in L1 flat
    cols_missing_from_L1 <- base::setdiff(colnames(L0_flat), colnames(L1_flat))
    expect_true(length(cols_missing_from_L1) == 0)
    # TEST: All L1 flat columns should be in L0 flat
    cols_missing_from_L0 <- base::setdiff(colnames(L1_flat), colnames(L0_flat))
    expect_true(length(cols_missing_from_L0) == 0)
  }
})

# Column classes --------------------------------------------------------------

testthat::test_that("Column classes", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    if (i == "df") { # test w/data.frame
      L0_flat <- as.data.frame(ants_L0_flat)
      for (tbl in names(ants_L1$tables)) {
        ants_L1$tables[[tbl]] <- as.data.frame(ants_L1$tables[[tbl]])
      }
    } else {      # test w/tibble
      L0_flat <- ants_L0_flat
    }
    crit <- read_criteria()
    L1_flat <- flatten_data(ants_L1$tables)
    # TEST: flatten_data() applies a set of "smart" class coercions to return numeric values stored in the L1 as character back to their original numeric class. The following code tests that column classifications in L1 should be "similar" to those in L0.
    L0_classes <- unlist(lapply(L0_flat, class))
    L1_classes <- unlist(lapply(L1_flat, class))
    # Harmonize classes (because there is some variation) before comparing
    L0_classes[stringr::str_detect(names(L0_classes), "id")] <- "character" # identifiers should be character
    L1_classes[stringr::str_detect(names(L1_classes), "id")] <- "character"
    L0_classes[stringr::str_detect(L0_classes, "integer")] <- "numeric"     # integer ~= numeric
    L1_classes[stringr::str_detect(L1_classes, "integer")] <- "numeric"
    # TEST: Compare col classes
    for (c in seq(L1_classes)) {
      col <- L1_classes[c]
      if (names(col) %in% names(L0_classes)) {
        use_i <- names(L0_classes) %in% names(col)
        if (any(use_i)) {
          expect_equal(L0_classes[use_i], col)
        }
      }
    }
  }
})

# Observations (rows) match ---------------------------------------------------

# TODO Implement this test?
# testthat::test_that("Observations (rows) match", {
#   # Parameterize
#   crit <- read_criteria()
#   L0_flat <- ants_L0_flat
#   L1_flat <- ecocomDP::flatten_data(ants_L1$tables)
#   # Adjust L0 flat to our expectations
#   L0_flat <- L0_flat %>% 
#     dplyr::select(-block) %>%           # A higher level location lost when flattened
#     dplyr::select(-author) %>%           # Columns of NA are dropped when flattened
#     dplyr::rename(location_name = plot) # Becomes "location_name" when flattened
#   # TEST: Observation "A" in L0 flat has the same values in observation "A" of L1 flat
#   # TODO observation_id are identical
#   # TODO match cols and sort, then compare (some subset?)
# })

# Non-required columns --------------------------------------------------------
# Non-required columns of ecocomDP aren't required by flatten_data()

testthat::test_that("Non-required columns", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    if (i == "df") { # test w/data.frame
      for (tbl in names(ants_L1$tables)) {
        ants_L1$tables[[tbl]] <- as.data.frame(ants_L1$tables[[tbl]])
      }
    }
    # Parameterize
    crit <- read_criteria() %>% 
      dplyr::filter(required == TRUE, !is.na(column)) %>%
      dplyr::select(table, column)
    tbls <- ants_L1$tables
    # Throw out all non-required columns
    for (tname in names(tbls)) {
      rqd <- crit$column[crit$table %in% tname]
      tbls[[tname]] <- tbls[[tname]] %>% dplyr::select(dplyr::any_of(rqd))
    }
    # TEST: Missing non-required columns isn't an issue
    L1_flat <- ecocomDP::flatten_data(tbls)
    cols_in <- unname(unlist(lapply(tbls, colnames)))
    cols_out <- colnames(L1_flat)
    dif <- base::setdiff(cols_in, cols_out)
    expect_equal(dif, # Difference is a set of cols that shouldn't be returned by anyway
                 c("location_ancillary_id", "taxon_ancillary_id", "observation_ancillary_id", 
                   "variable_mapping_id", "table_name"))
  }
})

# flatten_location() ----------------------------------------------------------
# location_name values are parsed into the original L0 column representation

testthat::test_that("flatten_location(): No nesting", {
  
  loc <- tidyr::as_tibble(  # A table demonstrating this use case
    data.frame(
      location_id = c("H1"),
      location_name = c("Highest__1"),
      latitude = 45,
      longitude = 123,
      elevation = 200,
      parent_location_id = NA_character_,
      stringsAsFactors = FALSE))
  
  for (i in c("df", "tbbl")) {
    # Parameterize
    if (i == "df") { # test w/data.frame
      loc <- as.data.frame(loc)
    }
    # Parameterize
    res <- flatten_location(loc)
    loc_flat <- res$location_flat
    # TEST: Original columns of data are returned
    expect_true(all(c("Highest") %in% colnames(loc_flat))) # column names
    expect_equal(loc_flat$Highest, "1")                    # values
  }
})

testthat::test_that("flatten_location(): 3 nested sites", {
  
  loc <- tidyr::as_tibble(  # A table demonstrating this use case
    data.frame(
      location_id = c("H1", "M2", "L3"),
      location_name = c("Highest__1", "Middle__2", "Lowest__3"),
      latitude = c(NA, NA, 45),
      longitude = c(NA, NA, 123),
      elevation = c(NA, NA, 200),
      parent_location_id = c(NA_character_, "H1", "M2"),
      stringsAsFactors = FALSE))
  
  for (i in c("df", "tbbl")) {
    # Parameterize
    if (i == "df") { # test w/data.frame
      loc <- as.data.frame(loc)
    }
    # Parameterize
    res <- flatten_location(loc)
    loc_flat <- res$location_flat
    # TEST: Original columns of data are returned
    expect_true(all(c("Highest", "Middle", "Lowest") %in% colnames(loc_flat))) # column names
    expect_equal(loc_flat$Highest, "1")                                        # values
    expect_equal(loc_flat$Middle, "2")
    expect_equal(loc_flat$Lowest, "3")
    # TEST: Original columns are returned in the order of nesting
    expect_equal(which(colnames(loc_flat) %in% "Highest"), 3)
    expect_equal(which(colnames(loc_flat) %in% "Middle"), 4)
    expect_equal(which(colnames(loc_flat) %in% "Lowest"), 5)
  }
  
})
