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
  us <- readShapePoly(paste0(type, "/", type, ".shp"),
                      proj4string = CRS("+proj=longlat +datum=WGS84"))
  # us <- readOGR(paste0("data-raw/maps/", type, "/"))

  # aea: Albers Equal Area projection
  us_aea <- spTransform(us, CRS("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs"))
  us_aea@data$id <- rownames(us_aea@data)

  # FIPS code for Alaska = 02
  alaska <- us_aea[us_aea$STATEFP == "02", ]
  alaska <- elide(alaska, rotate = -50)
  alaska <- elide(alaska, scale = max(apply(bbox(alaska), 1, diff)) / 2.3)
  alaska <- elide(alaska, shift = c(-2100000, -2500000))
  proj4string(alaska) <- proj4string(us_aea)

  # FIPS code for Hawaii = 15
  hawaii <- us_aea[us_aea$STATEFP == "15", ]
  hawaii <- elide(hawaii, rotate = -35)
  hawaii <- elide(hawaii, shift = c(5400000, -1400000))
  proj4string(hawaii) <- proj4string(us_aea)

  # keep only US states (i.e. remove territories, minor outlying islands, etc.)
  # also remove Alaska (02) and Hawaii (15) so that we can add in shifted one
  us_aea <- us_aea[!us_aea$STATEFP %in% c(as.character(57:80), "02", "15"), ]
  us_aea <- rbind(us_aea, alaska, hawaii)

  # reduce shapefile resolution by removing small polygons
  # for more info: http://www.r-bloggers.com/simplifying-polygon-shapefiles-in-r/
  area <- lapply(us_aea@polygons, function(x) sapply(x@Polygons, function(y) y@area))
  mainPolys <- lapply(area, function(x) which(x >= 500000000))

  for (i in 1:length(mainPolys)) {
    if (length(mainPolys[[i]]) >= 1 && mainPolys[[i]][1] >= 1) {
      us_aea@polygons[[i]]@Polygons <- us_aea@polygons[[i]]@Polygons[mainPolys[[i]]]
      us_aea@polygons[[i]]@plotOrder <- 1:length(us_aea@polygons[[i]]@Polygons)
    }
  }

  # plot map
  map <- ggplot2::fortify(us_aea, region = "GEOID")  # convert map to ggplot-friendly data frame

  # export csv file
  write.csv(map, file = paste0(type, ".csv"), row.names = FALSE, na = "")

  # determine centroids
  centroids <- centroid(us_aea)

  # export centroids (used to plot labels)
  write.csv(centroids, file = paste0(type, "_centroids_raw.csv"), row.names = FALSE)
}

for (type in map_types) create_mapdata(type)
