# ==============================================================================
# maps.R
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
library(RColorBrewer)
library(ggplot2)
library(ggthemes)

# import map shape file
setwd("/Users/paolo/Desktop/github/us-map/data/")
us <- readShapePoly("cb_2014_us_state_500k.shp", proj4string = CRS("+proj=longlat +datum=WGS84"))

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
hawaii <- elide(hawaii, shift = c(5400000, -1520000))
proj4string(hawaii) <- proj4string(us_aea)

# keep only US states (i.e. remove territories, minor outlying islands, etc.)
# also remove Alaska (02) and Hawaii (15) so that we can add in shifted one
us_aea <- us_aea[!us_aea$STATEFP %in% c(as.character(57:80), "02", "15"), ]
us_aea <- rbind(us_aea, alaska, hawaii)

# plot map
map <- fortify(us_aea, region = "GEOID")  # convert map to ggplot-friendly data frame

ggplot() + 
  geom_map(data = map, map = map, aes(x = long, y = lat, map_id = id, group = group), colour = "black", fill = "white", size = 0.3) +
  coord_equal() +
  theme_map() + 
  guides(fill = guide_legend(override.aes = list(colour = NULL))) +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(title = paste0("U.S. State Map")) +
  theme(plot.title = element_text(size = 22, face = "bold"))
