# Tests are organized around validation check functions (e.g. all tests listed 
# under validate_column_names() are relevant to that check).

library(ecocomDP)

context("validate_data()")

# Parameterize ----------------------------------------------------------------

# Use the example dataset for testing
test_data <- ants_L1

# Load validation criteria for tables and columns
criteria <- read_criteria()

# validate_table_presence() ---------------------------------------------------

testthat::test_that("validate_table_presence()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Return message when all required tables are present.
    expect_null(validate_table_presence(d))
    # Return character string when required tables are missing.
    required_tables <- criteria$table[is.na(criteria$column) & criteria$required]
    for (i in required_tables) {
      d <- test_data$tables
      d[i] <- NULL
      r <- validate_table_presence(d)
      expect_true(
        stringr::str_detect(r, paste0("Required table. Missing required table: ", i)))
    }
  }
})

# validate_column_names() -----------------------------------------------------

testthat::test_that("validate_column_names()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Return message when column spelling is correct.
    expect_null(validate_column_names(d))
    # Return character string when column spelling is incorrect.
    for (table in names(d)) {
      d <- test_data$tables
      invalid_names <- names(d[[table]])
      invalid_names[1:2] <- c("invalid_colname_1", "invalid_colname_2")
      names(d[[table]]) <- invalid_names
      r <- validate_column_names(d)
      expect_true(
        stringr::str_detect(
          r, 
          paste0("Column names. The .+ table has these invalid column names: ",
                 "invalid_colname_1, invalid_colname_2")))
    }
  }
})

# validate_column_presence() --------------------------------------------------

testthat::test_that("validate_column_presence()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Return message when required columns are present.
    expect_null(validate_column_presence(d))
    # Return character string when required columns are missing.
    for (table in names(d)) {
      required_columns <- criteria$column[
        !is.na(criteria$column) & criteria$table == table & criteria$required]
      for (column in required_columns) {
        d <- test_data$tables
        d[[table]][[column]] <- NULL
        expect_true(
          stringr::str_detect(
            validate_column_presence(d), 
            paste0("Required columns. The ", table, " table is missing these ",
                   "required columns: ", column)))
      }
    }
  }
})

# validate_datetime() ---------------------------------------------------------

testthat::test_that("validate_datetime()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Return message when datetime formats are valid.
    expect_null(validate_datetime(d))
    # Return character string when datetime formats are invalid.
    for (table in names(d)) {
      d <- test_data$tables
      datetime_columns <- criteria$column[
        !is.na(criteria$column) & 
          criteria$table == table & 
          criteria$class == "Date"]
      if (length(datetime_columns) != 0) {
        for (column in datetime_columns) {
          if (!all(is.na(d[[table]][[column]]))) {
            d[[table]][[column]] <- as.character(d[[table]][[column]])
            d[[table]][[column]][1:2] <- c("01/02/2003", "01/02/2003")
            expect_true(
              stringr::str_detect(
                validate_datetime(d), 
                paste0("Datetime format. The ", table, " table has unsupported ",
                       "datetime formats in rows: 1 2")))
          }
        }
      }
    }
  }
})

# validate_column_classes() ---------------------------------------------------

testthat::test_that("validate_column_classes()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Return message when column classes are valid.
    expect_null(validate_column_classes(d))
    # Return character string when column classes are invalid.
    for (table in names(d)) {
      d <- test_data$tables
      table_columns <- colnames(d[[table]])
      for (column in table_columns) {
        d <- test_data$tables
        d[[table]][[column]] <- as.logical(d[[table]][[column]])
        if (column != "datetime") {
          expect_true(
            stringr::str_detect(
              validate_column_classes(d), 
              paste0("Column classes. The column ", column, " in the table ", 
                     table, " has a class of logical but a class of")))
        }
      }
    }
  }
})

# validate_primary_keys() -----------------------------------------------------

testthat::test_that("validate_primary_keys()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Unique primary keys result in message.
    expect_null(validate_primary_keys(d))
    # Non-unique primary keys result in character string.
    d$dataset_summary <- NULL
    for (table in names(d)) {
      d <- test_data$tables
      primary_key_columns <- criteria$column[
        !is.na(criteria$column) & 
          criteria$table == table & 
          criteria$primary_key]
      for (column in primary_key_columns) {
        d[[table]][[column]][2] <- d[[table]][[column]][1]
        expect_true(
          stringr::str_detect(
            validate_primary_keys(d), 
            paste0("Primary keys. The ", table, " table contains non-unique ",
                   "primary keys in the column ", column)))
      }
    }
  }
})

# validate_composite_keys() ---------------------------------------------------

testthat::test_that("validate_composite_keys()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Unique composite keys result in message.
    expect_null(validate_composite_keys(d))
    # Non-unique composite keys result in character string.
    for (table in names(d)) {
      d <- test_data$tables
      composite_key_columns <- criteria$column[
        !is.na(criteria$column) & 
          criteria$table == table & 
          criteria$composite_key]
      if (length(composite_key_columns) != 0) {
        for (column in composite_key_columns) {
          if (length(d[[table]][[column]]) == 1) {
            d[[table]] <- rbind(d[[table]], d[[table]])
          } else {
            d[[table]][[column]][2] <- d[[table]][[column]][1]
          }
        }
        expect_true(
          stringr::str_detect(
            validate_composite_keys(d), 
            "Composite keys. The composite keys composed of the columns .+"))
      }
    }
  }
})

# validate_referential_integrity() --------------------------------------------

testthat::test_that("validate_referential_integrity()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Valid referential integrity results in message.
    expect_null(validate_referential_integrity(d))
    # Invalid referential integrity results in character string.
    for (table in names(d)) {
      d <- test_data$tables
      primary_key <- criteria$column[
        (criteria$table == table) & 
          !is.na(criteria$column) & 
          (criteria$primary_key == TRUE)]
      primary_key_data <- stats::na.omit(d[[table]][[primary_key]])
      foreign_key_table <- criteria$table[
        !is.na(criteria$column) & 
          (criteria$column == primary_key)]
      for (fk_table in foreign_key_table) {
        if (fk_table != table) {
          d <- test_data$tables
          d[[fk_table]][[primary_key]][1] <- "invalid_foreign_key"
          expect_true(
            stringr::str_detect(
              validate_referential_integrity(d), 
              paste0("Referential integrity. The ", fk_table, " table has ",
                     "these foreign keys .+: invalid_foreign_key")))
        } else if (table != "location") {
          if (fk_table == "location") {
            d[[fk_table]][["parent_location_id"]][2] <- "invalid_foreign_key"
            expect_true(
              stringr::str_detect(
                validate_referential_integrity(d), 
                paste0("Referential integrity. The ", fk_table, " table has ",
                       "these foreign keys .+: invalid_foreign_key")))
          }
        }
      }
    }
  }
})

# validate_latitude_longitude_format() ----------------------------------------

testthat::test_that("validate_latitude_longitude_format()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Valid latitude and longitude results in message.
    expect_null(validate_latitude_longitude_format(d))
    # Invalid latitude and longitude results in character string.
    for (i in c("latitude", "longitude")) {
      d <- test_data$tables
      d$location[[i]][1:2] <- "invalid_coordinate"
      expect_true(
        stringr::str_detect(
          validate_latitude_longitude_format(d),
          "The .+ column of the location table contains values that"))
    }
  }
})

# validate_latitude_longitude_range() -----------------------------------------

testthat::test_that("validate_latitude_longitude_range()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Valid latitude and longitude results in message.
    expect_null(validate_latitude_longitude_range(d))
    # Invalid latitude and longitude results in character string.
    for (i in c("latitude", "longitude")) {
      d <- test_data$tables
      if (i == "latitude") {
        d$location[[i]][3:4] <- c(100, -100)
        expect_true(
          stringr::str_detect(
            validate_latitude_longitude_range(d),
            paste0(
              "The latitude column of the location table contains values ",
              "outside the bounds -90 to 90 in rows: 3, 4")))
      } else if (i == "longitude") {
        d$location[[i]][3:4] <- c(190, -190)
        expect_true(
          stringr::str_detect(
            validate_latitude_longitude_range(d),
            paste0(
              "The longitude column of the location table contains values ",
              "outside the bounds -180 to 180 in rows: 3, 4")))
      }
    }
  }
})

# validate_elevation() -----------------------------------------

testthat::test_that("validate_elevation()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Valid elevation results in message.
    expect_null(validate_elevation(d))
    # Invalid elevation results in character string.
    d$location$elevation[3:4] <- c(8849, -10985)
    expect_true(
      stringr::str_detect(
        validate_elevation(d),
        paste0(
          "The elevation column of the location table contains ",
          "values that may not be in the unit of meters. ",
          "Questionable values exist in rows: 3, 4")))
  }
})

# validate_variable_mapping() -------------------------------------------------

testthat::test_that("validate_variable_mapping()", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    # Valid variable_mapping results in message.
    expect_null(validate_variable_mapping(d))
    # variable_name in variable_mapping but missing from the referenced table
    # results in character string
    for (tbl in unique(d$variable_mapping$table_name)) {
      d <- test_data$tables
      i <- d$variable_mapping$table_name %in% tbl
      tblvars <- d$variable_mapping$variable_name[i]
      d$variable_mapping$variable_name[i] <- paste0("var_", seq(length(tblvars)))
      expect_true(
        stringr::str_detect(
          validate_variable_mapping(d),
          paste0(
            "Variable mapping. The variable_mapping table has these ",
            "variable_name values without a match in the ", tbl, " table: .+")))
    }
  }
})


# validate_mapped_id() --------------------------------------------------------

testthat::test_that("validate_mapped_id()", {
  
  testthat::skip_on_cran()
  
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- ants_L1
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data$tables
    d$variable_mapping <- d$variable_mapping[1, ]
    # Valid mapped_id results in message.
    expect_null(validate_mapped_id(d))
    # Invalid mapped_id results in character string
    d$variable_mapping$mapped_id <- "shttp://rs.tdwg.org/dwc/terms/measurementType"
    resp <- validate_mapped_id(d)
    res <- stringr::str_detect(resp, "mapped_id values that don't resolve:.+")
    expect_true(res)
  }
})

# validate_data() ---------------------------------------------------------

testthat::test_that("validate_data", {
  for (i in c("df", "tbbl")) {
    # Parameterize
    test_data <- trim_data_for_test(ants_L1)
    if (i == "df") { # test w/data.frame
      for (tbl in names(test_data$tables)) {
        test_data$tables[[tbl]] <- as.data.frame(test_data$tables[[tbl]])
      }
    }
    d <- test_data
    
    # If multiple validation issues, then report all issues with a warning or 
    # error.
    
    # Create issue for validate_table_presence()
    d$tables$dataset_summary <- NULL
    # Create issue for validate_column_presence()
    d$tables$taxon$taxon_name <- NULL
    # Create issue for validate_datetime()
    d$tables$location_ancillary$datetime <- as.character(d$tables$location_ancillary$datetime)
    d$tables$location_ancillary$datetime[1] <- "08/22/2020"
    # Create issue for validate_column_classes()
    d$tables$location$latitude <- as.character(d$tables$location$latitude)
    # Create issue for validate_primary_keys()
    d$tables$taxon$taxon_id[2] <- d$tables$taxon$taxon_id[1]
    # Create issue for validate_composite_keys()
    d$tables$location_ancillary$location_id[3] <- d$tables$location_ancillary$location_id[2]
    d$tables$location_ancillary$datetime[3] <- d$tables$location_ancillary$datetime[2]
    d$tables$location_ancillary$variable_name[3] <- d$tables$location_ancillary$variable_name[2]
    # Create issue for validate_referential_integrity()
    d$tables$observation$observation_id[1] <- "invalid_foreign_key"
    d$tables$observation$package_id[1] <- "invalid_foreign_key"
    d$tables$observation$location_id[1] <- "invalid_foreign_key"
    d$tables$observation$taxon_id[1] <- "invalid_foreign_key"
    # Create issue for validate_latitude_longitude_format()
    d$tables$location$latitude[3] <- "invalid_coordinate_format"
    d$tables$location$longitude[3] <- "invalid_coordinate_format"
    # Create issue for validate_latitude_longitude_format()
    d$tables$location$latitude[4] <- -100
    d$tables$location$longitude[4] <- -190
    # Create issue for validate_elevation()
    d$tables$location$elevation[4] <- 8849
    d$tables$location$elevation[5] <- -10985
    
    issues <- suppressWarnings(validate_data(dataset = d))
    expect_equal(length(issues), 17)
    expect_true(is.list(issues))
    expect_true(is.character(issues[[1]]))
  }
})
