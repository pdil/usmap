# usmap
[![Version](https://badge.fury.io/gh/pdil%2Fusmap.svg)](https://github.com/pdil/usmap/releases) [![Build Status](https://travis-ci.org/pdil/usmap.svg?branch=master)](https://travis-ci.org/pdil/usmap) [![codecov](https://codecov.io/gh/pdil/usmap/branch/master/graph/badge.svg)](https://codecov.io/gh/pdil/usmap)

## Note: This package is currently under construction and unreleased.
Contents are subject to change rapidly and any description contained herein may not be indicative of the final product.

=====

### Purpose
Typically in R it is difficult to create nice US [choropleths](http://en.wikipedia.org/wiki/Choropleth) that include Alaska and Hawaii. The functions presented here attempt to elegantly solve this problem by manually moving these states to a new location and providing a fortified data frame for mapping and visualization. This allows the user to easily add data to color the map. Eventually these templates may be deployed as an R package.

### Shape Files
The shape files that we use to plot the maps in R are located in the `data-raw` folder. For more information refer to the [US Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html). Maps at both the state and county levels are included for convenience (zip code maps may be included in the future).

### Features
* Obtain map with certain region breakdown
```{r}
state_map <- us_map(regions = "states")
county_map <- us_map(regions = "counties")
```
* Include only certain states
```{r}
new_england_states <- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont")
new_england_map <- us_map(regions = "states", include = new_england_states)
```
* Look up FIPS codes for states and counties
```{r}
fips(state = "New Jersey")
// "34"
```

### Examples
Here is an example of a blank U.S. map created using this code.
![Blank U.S. map](https://github.com/pdil/us-map/blob/master/blank-us-map.png)

#### Code
``` r
library(ggplot2)
library(ggthemes)

load("../data/us_state_20m.rda")

blank_map <- ggplot(data = map) + 
  geom_map(map = map, aes(x = long, y = lat, map_id = id, group = group), 
           colour = "black", fill = "white", size = 0.3) +
  coord_equal() + theme_map() + 
  labs(title = "U.S. State Map") +
  theme(plot.title = element_text(size = 22, face = "bold"))

ggsave("../blank-us-map.png", blank_map, width = 6, height = 4.9)
```
