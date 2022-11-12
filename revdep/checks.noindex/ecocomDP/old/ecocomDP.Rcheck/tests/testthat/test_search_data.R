context("search_data()")

library(ecocomDP)

# search index ----------------------------------------------------------------

testthat::test_that("Search index is saved for future calls in session", {
  testthat::skip_on_cran()
  unlink(paste0(tempdir(), "/ecocomDP_search_index.rda"))
  # Doesn't exist locally at time of first call
  is_local <- "ecocomDP_search_index.rda" %in% dir(tempdir())
  expect_false(is_local)
  # Is created during first call
  r <- search_data()
  is_local <- "ecocomDP_search_index.rda" %in% dir(tempdir())
  expect_true(is_local)
})

# result attributes -----------------------------------------------------------

testthat::test_that("Search results have a general format", {
  testthat::skip_on_cran()
  r <- search_data()
  # Is a table with expected columns and classes
  expect_true(is.data.frame(r))
  cols <- c("source", "id", "title", "description", "abstract", "years",
            "sampling_interval", "sites", "url", "source_id", "source_id_url")
  expect_true(all(colnames(r) %in% cols))
  # A NULL search returns the full list
  expect_true(nrow(r) > 70)
  # Sources are EDI or NEON
  expect_true(all(unique(r$source) %in% c("EDI", "NEON")))
})


testthat::test_that("Some info is expected by all sources", {
  testthat::skip_on_cran()
  r <- search_data()
  expect_true(all(!is.na(r$source)))
  expect_true(all(!is.na(r$id)))
  expect_true(all(!is.na(r$title)))
  expect_true(all(!is.na(r$abstract)))
  expect_true(all(!is.na(r$source_id)))
  expect_true(all(!is.na(r$source_id_url)))
})


testthat::test_that("Some info is source specific", {
  testthat::skip_on_cran()
  r <- search_data()
  r_edi<- r[is_edi(r$id), ]
  r_neon<- r[is_neon(r$id), ]
  # Descriptions only for NEON
  expect_true(all(is.na(r_edi$description)))
  expect_true(all(!is.na(r_neon$description)))
  # Years - EDI has single value, NEON has range
  expect_true(all(!is.na(as.integer(r_edi$years))))
  expect_true(all(stringr::str_detect(r_neon$years, "min = .+, max = .+")))
  # Sampling interval - EDI has single value, NEON has range
  # expect_true(all(!is.na(as.numeric(r_edi$sampling_interval))))
  expect_true(all(stringr::str_detect(r_neon$years, "min = .+, max = .+")))
  # Sites - EDI currently (20210416) doesn't have any, only NEON does
  expect_true(all(is.na(r_edi$sites)))
  expect_true(all(!is.na(r_neon$sites)))
  # url - For EDI, not NEON
  expect_true(all(stringr::str_detect(r_edi$url, "https:.+")))
  expect_true(all(is.na(r_neon$url)))
})

# search arguments ------------------------------------------------------------

testthat::test_that("Arguments control search patterns", {
  testthat::skip_on_cran()
  load(paste0(tempdir(), "/ecocomDP_search_index.rda"))
  summary_data <- ecocomDP_search_index
  # text arg searches across titles, abstracts, descriptions
  r <- search_data(text = "Small mammal box trapping")
  expect_equal(nrow(r), 1)
  r <- search_data(text = "South Carolina")
  expect_true(nrow(r) >= 4)
  r <- search_data(text = "For a description of how NEON L1 data were mapped ")
  expect_true(nrow(r) >= 12)
  # taxa arg searches across taxa ranks
  taxa_search <- "Chordata"
  r_method_1 <- search_data(taxa = taxa_search)  # Search method 1
  r_method_2 <- lapply(                          # Search method 2
    names(summary_data),
    function(id) {
      x <- summary_data[[id]]
      taxa <- unname(
        unlist(
          lapply(
            x$taxa,
            function(k) {
              k$taxa
            })))
      taxa <- paste(taxa, collapse = ",")
      stringr::str_detect(taxa, taxa_search)
    })
  res <- stringr::str_remove_all(names(summary_data), "_herps") # Do methods 1 & 2 agree?
  r_method_2 <- unlist(r_method_2)                              # Requires somes wrangling since summary_data and r_method_1 objects differ 
  r_method_2[is.na(r_method_2)] <- FALSE
  r_method_1 <- c(r_method_1$id[is_edi(r_method_1$id)],
                  r_method_1$source_id[is_neon(r_method_1$id)])
  expect_true(all(res[r_method_2] %in% r_method_1))
  # Num taxa is a bounding search
  search_num_taxa <- c(0, 10)
  r_method_1 <- search_data(num_taxa = search_num_taxa)
  r_method_2 <- lapply(
    names(summary_data),
    function(id) {
      x <- summary_data[[id]]
      num_taxa <- unname(
        unlist(
          lapply(
            x$taxa,
            function(k) {
              k$unique_taxa
            })))
      any((num_taxa >= search_num_taxa[1]) & (num_taxa <= search_num_taxa[2]))
    })
  res <- stringr::str_remove_all(names(summary_data), "_herps")
  r_method_2 <- unlist(r_method_2)
  r_method_2[is.na(r_method_2)] <- FALSE
  r_method_1 <- c(r_method_1$id[is_edi(r_method_1$id)],
                  r_method_1$source_id[is_neon(r_method_1$id)])
  expect_true(all(res[r_method_2] %in% r_method_1))
  # num_years
  search_years <- c(10, 20)
  r_method_1 <- search_data(num_years = search_years)
  r_method_2 <- lapply(
    names(summary_data),
    function(id) {
      x <- summary_data[[id]]
      years <- unname(
        unlist(
          lapply(
            x$number_of_years_sampled,
            function(k) {
              k
            })))
      any((years >= search_years[1]) & (years <= search_years[2]))
    })
  res <- stringr::str_remove_all(names(summary_data), "_herps")
  r_method_2 <- unlist(r_method_2)
  r_method_2[is.na(r_method_2)] <- FALSE
  r_method_1 <- c(r_method_1$id[is_edi(r_method_1$id)],
                  r_method_1$source_id[is_neon(r_method_1$id)])
  expect_true(all(res[r_method_2] %in% r_method_1))
  # sd_years
  search_sd_between_surveys <- c(.25, 1)
  r_method_1 <- search_data(sd_years = search_sd_between_surveys)
  r_method_2 <- lapply(
    names(summary_data),
    function(id) {
      x <- summary_data[[id]]
      sd_between_surveys <- unname(
        unlist(
          lapply(
            x$std_dev_interval_betw_years,
            function(k) {
              k
            })))
      any((sd_between_surveys >= search_sd_between_surveys[1]) &
            (sd_between_surveys <= search_sd_between_surveys[2]))
    })
  res <- stringr::str_remove_all(names(summary_data), "_herps")
  r_method_2 <- unlist(r_method_2)
  r_method_2[is.na(r_method_2)] <- FALSE
  r_method_1 <- c(r_method_1$id[is_edi(r_method_1$id)],
                  r_method_1$source_id[is_neon(r_method_1$id)])
  expect_true(all(res[r_method_2] %in% r_method_1))
  
  # area
  # TODO: Implement test
  
  # boolean "OR" - All unique id of separate term searches should be
  # combined when using the OR operator
  r1 <- search_data(text = "Lake")
  r2 <- search_data(text = "River")
  r_or <- search_data(text = c("Lake", "River"), boolean = "OR")
  expect_true(all(unique(c(r1$id, r2$id)) %in% unique(r_or$id)))
  r1 <- search_data(taxa = "Plantae")
  r2 <- search_data(taxa = "Animalia")
  r_or <- search_data(taxa = c("Plantae", "Animalia"), boolean = "OR")
  expect_true(all(unique(c(r1$id, r2$id)) %in% unique(r_or$id)))
  # boolean "AND" - All unique id of separate term searches should not
  # be expected when using the AND operator
  r1 <- search_data(text = "Lake")
  r2 <- search_data(text = "River")
  r_and <- search_data(text = c("Lake", "River"), boolean = "AND")
  expect_true(all(intersect(r1$id, r2$id) %in% r_and$id))
  r1 <- search_data(taxa = "Plantae")
  r2 <- search_data(taxa = "Animalia")
  r_and <- search_data(taxa = c("Plantae", "Animalia"), boolean = "AND")
  expect_true(all(intersect(r1$id, r2$id) %in% r_and$id))
})

