library(tidyverse)       # Tidyverse for Tidy Data
library(tmap)            # Thematic Mapping
library(tmaptools)
library(tigris)          # Get Census Geography Poloygons
library(sf)

us_geo <- tigris::states(class = "sf")


select_states <- us_geo %>%
  filter(STUSPS ==  "PR")

tm_shape(select_states) +
  tm_polygons( id = "Name")

sp_select_states <- as_Spatial(select_states)

library(broom)

map_data_fortified <- tidy(sp_select_states)  %>%
  mutate(id = as.numeric(id))

write.csv(map_data_fortified, "us_states_raw_with_PR.csv", row.names = FALSE)


us <- readShapePoly(paste0(type, "/", type, ".shp"),
                    proj4string = CRS("+proj=longlat +datum=WGS84"))
# us <- readOGR(paste0("data-raw/maps/", type, "/"))

us_geo <- as_Spatial(us_geo)
# likey need to convert projection/proj4string


# +proj=longlat +datum=NAD83 +no_defs +ellps=GRS80 +towgs84=0,0,0

# aea: Albers Equal Area projection
us_aea <- spTransform(us_geo, CRS("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs"))
head(us_aea)
# old head(us_aea)
# class       : SpatialPolygonsDataFrame
# features    : 6
# extent      : -4360619, 1969385, -1244047, 3911163  (xmin, xmax, ymin, ymax)
# coord. ref. : +proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0 +a=6370997 +b=6370997 +units=m +no_defs
# variables   : 9
# names       : STATEFP,  STATENS,    AFFGEOID, GEOID, STUSPS,     NAME, LSAD,        ALAND,       AWATER
# min values  :      02, 01702382, 0400000US02,    02,     AK,   Alaska,   00, 1.437841e+11,     18675956
# max values  :      17, 01785533, 0400000US17,    17,     IL, Illinois,   00, 4.034832e+11, 277723861311
us_aea@data$id <- rownames(us_aea@data)
