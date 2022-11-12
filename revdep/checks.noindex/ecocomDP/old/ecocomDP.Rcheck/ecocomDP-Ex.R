pkgname <- "ecocomDP"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('ecocomDP')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("annotation_dictionary")
### * annotation_dictionary

flush(stderr()); flush(stdout())

### Name: annotation_dictionary
### Title: Annotations of published data
### Aliases: annotation_dictionary

### ** Examples

## Not run: 
##D View(annotation_dictionary())
## End(Not run)
    



cleanEx()
nameEx("convert_to_dwca")
### * convert_to_dwca

flush(stderr()); flush(stdout())

### Name: convert_to_dwca
### Title: Convert a dataset to the Darwin Core Archive format
### Aliases: convert_to_dwca

### ** Examples

## Not run: 
##D # Create directory for DwC-A outputs
##D mypath <- paste0(tempdir(), "/data")
##D dir.create(mypath)
##D 
##D # Convert an EDI published ecocomDP dataset to a DwC-A
##D convert_to_dwca(
##D   path = mypath, 
##D   core_name = "event", 
##D   source_id = "edi.193.5", 
##D   derived_id = "edi.834.2", 
##D   user_id = "ecocomdp",
##D   user_domain = "EDI")
##D 
##D dir(mypath)
##D 
##D # Clean up
##D unlink(mypath, recursive = TRUE)
## End(Not run)




cleanEx()
nameEx("create_dataset_summary")
### * create_dataset_summary

flush(stderr()); flush(stdout())

### Name: create_dataset_summary
### Title: Create the dataset_summary table
### Aliases: create_dataset_summary

### ** Examples

flat <- ants_L0_flat

dataset_summary <- create_dataset_summary(
  L0_flat = flat, 
  package_id = "package_id", 
  original_package_id = "original_package_id", 
  length_of_survey_years = "length_of_survey_years",
  number_of_years_sampled = "number_of_years_sampled", 
  std_dev_interval_betw_years = "std_dev_interval_betw_years", 
  max_num_taxa = "max_num_taxa", 
  geo_extent_bounding_box_m2 = "geo_extent_bounding_box_m2")

dataset_summary




cleanEx()
nameEx("create_eml")
### * create_eml

flush(stderr()); flush(stdout())

### Name: create_eml
### Title: Create EML metadata
### Aliases: create_eml

### ** Examples

## Not run: 
##D # Create directory with ecocomDP tables for create_eml()
##D mypath <- paste0(tempdir(), "/data")
##D dir.create(mypath)
##D inpts <- c(ants_L1$tables, path = mypath)
##D do.call(write_tables, inpts)
##D file.copy(system.file("extdata", "create_ecocomDP.R", package = "ecocomDP"), mypath)
##D dir(mypath)
##D 
##D # Describe, with annotations, what the source L0 dataset "is about"
##D dataset_annotations <- c(
##D   `species abundance` = "http://purl.dataone.org/odo/ECSO_00001688",
##D   Population = "http://purl.dataone.org/odo/ECSO_00000311",
##D   `level of ecological disturbance` = "http://purl.dataone.org/odo/ECSO_00002588",
##D   `type of ecological disturbance` = "http://purl.dataone.org/odo/ECSO_00002589")
##D 
##D # Add self as contact information incase questions arise
##D additional_contact <- data.frame(
##D   givenName = 'Colin',
##D   surName = 'Smith',
##D   organizationName = 'Environmental Data Initiative',
##D   electronicMailAddress = 'csmith@mail.com',
##D   stringsAsFactors = FALSE)
##D 
##D # Create EML
##D eml <- create_eml(
##D   path = mypath,
##D   source_id = "knb-lter-hfr.118.33",
##D   derived_id = "edi.193.5",
##D   is_about = dataset_annotations,
##D   script = "create_ecocomDP.R",
##D   script_description = "A function for converting knb-lter-hrf.118 to ecocomDP",
##D   contact = additional_contact,
##D   user_id = 'ecocomdp',
##D   user_domain = 'EDI',
##D   basis_of_record = "HumanObservation")
##D 
##D dir(mypath)
##D View(eml)
##D 
##D # Clean up
##D unlink(mypath, recursive = TRUE)
## End(Not run)




cleanEx()
nameEx("create_location")
### * create_location

flush(stderr()); flush(stdout())

### Name: create_location
### Title: Create the location table
### Aliases: create_location

### ** Examples

flat <- ants_L0_flat

location <- create_location(
  L0_flat = flat, 
  location_id = "location_id", 
  location_name = c("block", "plot"), 
  latitude = "latitude", 
  longitude = "longitude", 
  elevation = "elevation")

location




cleanEx()
nameEx("create_location_ancillary")
### * create_location_ancillary

flush(stderr()); flush(stdout())

### Name: create_location_ancillary
### Title: Create the location_ancillary table
### Aliases: create_location_ancillary

### ** Examples

flat <- ants_L0_flat

location_ancillary <- create_location_ancillary(
  L0_flat = flat,
  location_id = "location_id",
  variable_name = "treatment")

location_ancillary




cleanEx()
nameEx("create_observation")
### * create_observation

flush(stderr()); flush(stdout())

### Name: create_observation
### Title: Create the observation table
### Aliases: create_observation

### ** Examples

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

observation




cleanEx()
nameEx("create_observation_ancillary")
### * create_observation_ancillary

flush(stderr()); flush(stdout())

### Name: create_observation_ancillary
### Title: Create the observation_ancillary table
### Aliases: create_observation_ancillary

### ** Examples

flat <- ants_L0_flat

observation_ancillary <- create_observation_ancillary(
  L0_flat = flat,
  observation_id = "observation_id", 
  variable_name = c("trap.type", "trap.num", "moose.cage"))

observation_ancillary




cleanEx()
nameEx("create_taxon")
### * create_taxon

flush(stderr()); flush(stdout())

### Name: create_taxon
### Title: Create the taxon table
### Aliases: create_taxon

### ** Examples

flat <- ants_L0_flat

taxon <- create_taxon(
  L0_flat = flat, 
  taxon_id = "taxon_id", 
  taxon_rank = "taxon_rank", 
  taxon_name = "taxon_name", 
  authority_system = "authority_system", 
  authority_taxon_id = "authority_taxon_id")

taxon




cleanEx()
nameEx("create_taxon_ancillary")
### * create_taxon_ancillary

flush(stderr()); flush(stdout())

### Name: create_taxon_ancillary
### Title: Create the taxon_ancillary table
### Aliases: create_taxon_ancillary

### ** Examples

flat <- ants_L0_flat

taxon_ancillary <- create_taxon_ancillary(
  L0_flat = flat,
  taxon_id = "taxon_id",
  variable_name = c(
    "subfamily", "hl", "rel", "rll", "colony.size", 
    "feeding.preference", "nest.substrate", "primary.habitat", 
    "secondary.habitat", "seed.disperser", "slavemaker.sp", 
    "behavior", "biogeographic.affinity", "source"),
  unit = c("unit_hl", "unit_rel", "unit_rll"))

taxon_ancillary




cleanEx()
nameEx("create_variable_mapping")
### * create_variable_mapping

flush(stderr()); flush(stdout())

### Name: create_variable_mapping
### Title: Create the variable_mapping table
### Aliases: create_variable_mapping

### ** Examples

flat <- ants_L0_flat

# Create inputs to variable_mapping()

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

# Create variable_mapping table

variable_mapping <- create_variable_mapping(
  observation = observation,
  observation_ancillary = observation_ancillary,
  location_ancillary = location_ancillary, 
  taxon_ancillary = taxon_ancillary)

variable_mapping




cleanEx()
nameEx("flatten_data")
### * flatten_data

flush(stderr()); flush(stdout())

### Name: flatten_data
### Title: Flatten a dataset
### Aliases: flatten_data

### ** Examples

# Flatten a dataset object
flat <- flatten_data(ants_L1)
flat

# Flatten a list of tables
tables <- ants_L1$tables
flat <- flatten_data(tables)
flat




cleanEx()
nameEx("plot_sample_space_time")
### * plot_sample_space_time

flush(stderr()); flush(stdout())

### Name: plot_sample_space_time
### Title: Plot dates and times samples were collected or observations were
###   made
### Aliases: plot_sample_space_time

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_sample_space_time(dataset)
##D 
##D # Flatten the dataset, manipulate, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(lubridate::as_date(datetime) > "2003-07-01") %>%
##D   dplyr::filter(as.numeric(location_id) > 4) %>%
##D   plot_sample_space_time()
## End(Not run)

# Plot the example dataset
plot_sample_space_time(ants_L1)




cleanEx()
nameEx("plot_sites")
### * plot_sites

flush(stderr()); flush(stdout())

### Name: plot_sites
### Title: Plot sites on US map
### Aliases: plot_sites

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_sites(dataset)
##D 
##D # Flatten dataset then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   plot_sites()
## End(Not run)

# Plot the example dataset
plot_sites(ants_L1)




cleanEx()
nameEx("plot_taxa_abund")
### * plot_taxa_abund

flush(stderr()); flush(stdout())

### Name: plot_taxa_abund
### Title: Plot mean taxa abundances per 'observation_id'
### Aliases: plot_taxa_abund

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # plot ecocomDP formatted dataset
##D plot_taxa_abund(dataset)
##D 
##D # plot flattened ecocomDP dataset, log(x+1) transform abundances
##D plot_taxa_abund(
##D   data = flatten_data(dataset),
##D   trans = "log1p")
##D 
##D # facet by location color by taxon_rank, log 10 transform
##D plot_taxa_abund(
##D   data = dataset,
##D   facet_var = "location_id",
##D   color_var = "taxon_rank",
##D   trans = "log10")
##D 
##D # facet by location, minimum rel. abund = 0.05, log 10 transform
##D plot_taxa_abund(
##D   data = dataset,
##D   facet_var = "location_id",
##D   min_relative_abundance = 0.05,
##D   trans = "log1p")
##D 
##D # color by location, log 10 transform
##D plot_taxa_abund(
##D   data = dataset,
##D   color_var = "location_id",
##D   trans = "log10")
##D 
##D # tidy syntax, flatten then filter data by date
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(
##D     lubridate::as_date(datetime) > "2003-07-01") %>%
##D   plot_taxa_abund(
##D     trans = "log1p",
##D     min_relative_abundance = 0.01)
## End(Not run)

# Plot the example dataset
plot_taxa_abund(ants_L1)




cleanEx()
nameEx("plot_taxa_accum_sites")
### * plot_taxa_accum_sites

flush(stderr()); flush(stdout())

### Name: plot_taxa_accum_sites
### Title: Plot taxa accumulation by site accumulation
### Aliases: plot_taxa_accum_sites

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_taxa_accum_sites(dataset)
##D 
##D # Flatten the dataset, manipulate, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(lubridate::as_date(datetime) > "2003-07-01") %>%
##D   plot_taxa_accum_sites()
##D   
##D # Plot from the observation table directly
##D plot_taxa_accum_sites(dataset$tables$observation)
## End(Not run)

# Plot the example dataset
plot_taxa_accum_sites(ants_L1)




cleanEx()
nameEx("plot_taxa_accum_time")
### * plot_taxa_accum_time

flush(stderr()); flush(stdout())

### Name: plot_taxa_accum_time
### Title: Plot taxa accumulation through time
### Aliases: plot_taxa_accum_time

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_taxa_accum_time(dataset)
##D 
##D # Flatten the dataset, manipulate, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(lubridate::as_date(datetime) > "2003-07-01") %>%
##D   plot_taxa_accum_time()
##D   
##D # Plot from the observation table directly
##D plot_taxa_accum_time(dataset$tables$observation)
## End(Not run)

# Plot the example dataset
plot_taxa_accum_time(ants_L1)




cleanEx()
nameEx("plot_taxa_diversity")
### * plot_taxa_diversity

flush(stderr()); flush(stdout())

### Name: plot_taxa_diversity
### Title: Plot diversity (taxa richness) through time
### Aliases: plot_taxa_diversity

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_taxa_diversity(dataset)
##D 
##D # Plot the dataset with observations aggregated by year
##D plot_taxa_diversity(dataset, time_window_size = "year")
##D 
##D # Flatten the dataset, manipulate, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(
##D     lubridate::as_date(datetime) > "2007-01-01") %>%
##D   plot_taxa_diversity()
##D   
##D # Plot from the observation table directly
##D plot_taxa_diversity(dataset$tables$observation)
## End(Not run)

# Plot the example dataset
plot_taxa_diversity(ants_L1)




cleanEx()
nameEx("plot_taxa_occur_freq")
### * plot_taxa_occur_freq

flush(stderr()); flush(stdout())

### Name: plot_taxa_occur_freq
### Title: Plot taxon occurrence frequencies
### Aliases: plot_taxa_occur_freq

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_taxa_occur_freq(dataset)
##D 
##D # Facet by location and color by taxon_rank
##D plot_taxa_occur_freq(
##D   data = dataset, 
##D   facet_var = "location_id", 
##D   color_var = "taxon_rank")
##D 
##D # Color by location and only include taxa with >= 5 occurrences
##D plot_taxa_occur_freq(
##D   data = dataset,
##D   color_var = "location_id",
##D   min_occurrence = 5)
##D 
##D # Flatten, filter using a time cutoff, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(lubridate::as_date(datetime) > "2003-07-01") %>%
##D   plot_taxa_occur_freq()
## End(Not run)
# Plot the example dataset
plot_taxa_occur_freq(ants_L1)




cleanEx()
nameEx("plot_taxa_rank")
### * plot_taxa_rank

flush(stderr()); flush(stdout())

### Name: plot_taxa_rank
### Title: Plot taxa ranks
### Aliases: plot_taxa_rank

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data(
##D   id = "neon.ecocomdp.20120.001.001",
##D   site= c('COMO','LECO'), 
##D   startdate = "2017-06",
##D   enddate = "2019-09",
##D   check.size = FALSE)
##D 
##D # Plot the dataset
##D plot_taxa_rank(dataset)
##D 
##D # Plot with facet by location
##D plot_taxa_rank(dataset, facet_var = "location_id")
##D 
##D # Flatten the dataset, manipulate, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(lubridate::as_date(datetime) > "2003-07-01") %>%
##D   dplyr::filter(grepl("COMO",location_id)) %>%
##D   plot_taxa_rank()
## End(Not run)

# Plot the example dataset
plot_taxa_rank(ants_L1)




cleanEx()
nameEx("plot_taxa_shared_sites")
### * plot_taxa_shared_sites

flush(stderr()); flush(stdout())

### Name: plot_taxa_shared_sites
### Title: Plot number of unique taxa shared across sites
### Aliases: plot_taxa_shared_sites

### ** Examples

## Not run: 
##D # Read a dataset of interest
##D dataset <- read_data("edi.193.5")
##D 
##D # Plot the dataset
##D plot_taxa_shared_sites(dataset)
##D 
##D # Flatten the dataset, manipulate, then plot
##D dataset %>% 
##D   flatten_data() %>% 
##D   dplyr::filter(lubridate::as_date(datetime) > "2003-07-01") %>%
##D   dplyr::filter(as.numeric(location_id) > 4) %>%
##D   plot_taxa_shared_sites()
##D   
##D # Plot from the observation table directly
##D plot_taxa_shared_sites(dataset$tables$observation)
## End(Not run)

# Plot the example dataset
plot_taxa_shared_sites(ants_L1)




cleanEx()
nameEx("read_data")
### * read_data

flush(stderr()); flush(stdout())

### Name: read_data
### Title: Read published data
### Aliases: read_data

### ** Examples

## Not run: 
##D # Read from EDI
##D dataset <- read_data("edi.193.5")
##D str(dataset, max.level = 2)
##D 
##D # Read from NEON (full dataset)
##D dataset <- read_data("neon.ecocomdp.20120.001.001")
##D 
##D # Read from NEON with filters (partial dataset)
##D dataset <- read_data(
##D  id = "neon.ecocomdp.20120.001.001", 
##D  site = c("COMO", "LECO", "SUGG"),
##D  startdate = "2017-06", 
##D  enddate = "2019-09",
##D  check.size = FALSE)
##D 
##D # Read with datetimes as character
##D dataset <- read_data("edi.193.5", parse_datetime = FALSE)
##D is.character(dataset$tables$observation$datetime)
##D 
##D # Read from saved .rds
##D save_data(dataset, tempdir())
##D dataset <- read_data(from = paste0(tempdir(), "/dataset.rds"))
##D 
##D # Read from saved .csv
##D save_data(dataset, tempdir(), type = ".csv")# Save as .csv
##D dataset <- read_data(from = tempdir())
## End(Not run)




cleanEx()
nameEx("save_data")
### * save_data

flush(stderr()); flush(stdout())

### Name: save_data
### Title: Save a dataset
### Aliases: save_data

### ** Examples

# Create directory for the data
mypath <- paste0(tempdir(), "/data")
dir.create(mypath)

# Save as .rds
save_data(ants_L1, mypath)
dir(mypath)

# Save as .rds with the name "mydata"
save_data(ants_L1, mypath, name = "mydata")
dir(mypath)

# Save as .csv
save_data(ants_L1, mypath, type = ".csv")
dir(mypath)

## Not run: 
##D # Save multiple datasets
##D ids <- c("edi.193.5", "edi.303.2", "edi.290.2")
##D datasets <- lapply(ids, read_data)
##D save_data(datasets, mypath)
##D dir(mypath)
## End(Not run)

# Clean up
unlink(mypath, recursive = TRUE)




cleanEx()
nameEx("search_data")
### * search_data

flush(stderr()); flush(stdout())

### Name: search_data
### Title: Search published data
### Aliases: search_data

### ** Examples

## Not run: 
##D # Empty search returns all available datasets
##D search_data()
##D 
##D # "text" searches titles, descriptions, and abstracts
##D search_data(text = "Lake")
##D 
##D # "taxa" searches taxonomic ranks for a match
##D search_data(taxa = "Plantae")
##D 
##D # "num_years" searches the number of years sampled
##D search_data(num_years = c(10, 20))
##D 
##D # Use any combination of search fields to find the data you're looking for
##D search_data(
##D   text = c("Lake", "River"),
##D   taxa = c("Plantae", "Animalia"),
##D   num_taxa = c(0, 10),
##D   num_years = c(10, 100),
##D   sd_years = c(.01, 100),
##D   area = c(47.1, -86.7, 42.5, -92),
##D   boolean = "OR")
## End(Not run)




cleanEx()
nameEx("validate_data")
### * validate_data

flush(stderr()); flush(stdout())

### Name: validate_data
### Title: Validate tables against the model
### Aliases: validate_data

### ** Examples

## Not run: 
##D # Write a set of ecocomDP tables to file for validation
##D mydir <- paste0(tempdir(), "/dataset")
##D dir.create(mydir)
##D write_tables(
##D   path = mydir,
##D   observation = ants_L1$tables$observation, 
##D   observation_ancillary = ants_L1$tables$observation_ancillary,
##D   location = ants_L1$tables$location,
##D   location_ancillary = ants_L1$tables$location_ancillary,
##D   taxon = ants_L1$tables$taxon,
##D   taxon_ancillary = ants_L1$tables$taxon_ancillary,
##D   dataset_summary = ants_L1$tables$dataset_summary,
##D   variable_mapping = ants_L1$tables$variable_mapping)
##D 
##D # Validate
##D validate_data(path = mydir)
##D 
##D # Clean up
##D unlink(mydir, recursive = TRUE)
## End(Not run)




cleanEx()
nameEx("write_tables")
### * write_tables

flush(stderr()); flush(stdout())

### Name: write_tables
### Title: Write tables to file
### Aliases: write_tables

### ** Examples

# Create directory for the tables
mypath <- paste0(tempdir(), "/data")
dir.create(mypath)

# Create a couple inputs to write_tables()

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

dir(mypath)

# Clean up
unlink(mypath, recursive = TRUE)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
