# ==============================================================================
# create-map-df.R
#
# Plots US states map with Alaska and Hawaii
#
# Based off code found here:
#   http://www.r-bloggers.com/moving-the-earth-well-alaska-hawaii-with-r/
# ==============================================================================

library(maptools)
library(mapproj)
library(rgeos)
library(rgdal)
library(dplyr)

setwd("data-raw/maps/")
source("compute-centroids.R")

prefix = "cb_2017_us_"
region_types <- c("county", "state")
suffix <- "20m"

map_types <- paste0(prefix, region_types) %>% paste0(., "_", suffix)

create_mapdata <- function(type) {
  # import map shape file
  us <- readOGR(type)

  # aea: Albers Equal Area projection
  aea_crs <- CRS(paste("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0",
                       "+a=6370997 +b=6370997 +units=m +no_defs"))
  us_aea <- spTransform(us, aea_crs)
  us_aea@data$id <- rownames(us_aea@data)

  # FIPS code for Alaska = 02
  alaska <- us_aea[us_aea$STATEFP == "02", ]
  alaska <- elide(alaska, rotate = -50)
  alaska <- elide(alaska, scale = max(apply(bbox(alaska), 1, diff)) / 2.3)
  alaska <- elide(alaska, shift = c(-2100000, -2500000))
  proj4string(alaska) <- aea_crs

  # FIPS code for Hawaii = 15
  hawaii <- us_aea[us_aea$STATEFP == "15", ]
  hawaii <- elide(hawaii, rotate = -35)
  hawaii <- elide(hawaii, shift = c(5400000, -1400000))
  proj4string(hawaii) <- aea_crs

  # keep only US states (i.e. remove territories, minor outlying islands, etc.)
  # also remove Alaska (02) and Hawaii (15) so that we can add in shifted one
  us_aea <- us_aea[!us_aea$STATEFP %in% c(as.character(57:80), "02", "15"), ]
  us_aea <- rbind(us_aea, alaska, hawaii)

  # plot map
  map <- broom::tidy(us_aea, region = "GEOID")  # convert map to data frame

  # export csv file
  file_prefix <-
    gsub(prefix, "us_", type) %>%
    gsub(suffix, "", .) %>%
    gsub("state", "states", .) %>%
    gsub("county", "counties", .)

  write.csv(map, file = paste0(file_prefix, "raw.csv"),
            row.names = FALSE, na = "")

  # determine centroids
  centroids <- centroid(us_aea)

  # export centroids (used to plot labels)
  write.csv(centroids, file = paste0(file_prefix, "centroids_raw.csv"),
            row.names = FALSE)
}

for (type in map_types) create_mapdata(type)
