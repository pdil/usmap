# usmap
[![CRAN](http://www.r-pkg.org/badges/version/usmap?color=blue)](https://cran.r-project.org/package=usmap) [![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/usmap)](https://cran.r-project.org/package=usmap) [![Build Status](https://travis-ci.org/pdil/usmap.svg?branch=master)](https://travis-ci.org/pdil/usmap) [![codecov](https://codecov.io/gh/pdil/usmap/branch/master/graph/badge.svg)](https://codecov.io/gh/pdil/usmap)

<img src="https://raw.githubusercontent.com/pdil/usmap/master/state-pop-example.png" width="45%" /><img src="https://raw.githubusercontent.com/pdil/usmap/master/county-pop-example.png" width="45%" />
###### See code to generate these images [below](https://github.com/pdil/usmap/blob/master/README.md#code-for-maps-shown-above)

## Purpose
Typically in R it is difficult to create nice US [choropleths](https://en.wikipedia.org/wiki/Choropleth_map) that include Alaska and Hawaii. The functions presented here attempt to elegantly solve this problem by manually moving these states to a new location and providing a fortified data frame for mapping and visualization. This allows the user to easily add data to color the map.

## Shape Files
The shape files that we use to plot the maps in R are located in the `data-raw` folder. For more information refer to the [US Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html). Maps at both the state and county levels are included for convenience (zip code maps may be included in the future).

## Installation
To install from CRAN _(recommended)_, run the following code in an R console:
```r
install.packages("usmap")
```
To install the package from this repository, run the following code in an R console:
```r
# install.package("devtools")
devtools::install_github("pdil/usmap")
```
Installing using `devtools::install_github` will provide the most recent developer build of `usmap`.

To begin using `usmap`, simply import the package using the `library` command:
```r
library(usmap)
```

To read the package vignettes, which explain helpful uses of the package, use `vignette`:
```r
vignette(package = "usmap")
vignette("introduction", package = "usmap")
vignette("mapping", package = "usmap")
```

You can also read the vignettes online at the following links:
* [Introduction](https://cran.r-project.org/web/packages/usmap/vignettes/introduction.html)
* [Mapping the US](https://cran.r-project.org/web/packages/usmap/vignettes/mapping.html)

## Features
* Obtain map with certain region breakdown
```r
state_map <- us_map(regions = "states")
county_map <- us_map(regions = "counties")
```
* Include only certain states
```r
new_england_states <- c("Connecticut", "Maine", "Massachusetts", "New Hampshire", "Rhode Island", "Vermont")
new_england_map <- us_map(regions = "states", include = new_england_states)
```
* Look up FIPS codes for states and counties
```r
fips("New Jersey")
#> "34"

fips("NJ", county = "Mercer")
#> "34021"
```
* Retrieve states or counties with FIPS codes
```r
fips_info(c("34", "35"))
#>         full abbr fips
#> 1 New Jersey   NJ   34 
#> 2 New Mexico   NM   35

fips_info(c("34021", "35021"))
#>         full abbr         county  fips
#> 1 New Jersey   NJ  Mercer County 34021
#> 2 New Mexico   NM Harding County 35021
```
* Color map with data
```r
plot_usmap(data = statepop, values = "pop_2015", lines = "red") + 
  scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
  theme(legend.position = "right")
```

## Code for maps shown above
```r
library(usmap)
library(ggplot2)

# States map
plot_usmap(data = statepop, values = "pop_2015") + 
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Counties map
plot_usmap(data = countypop, values = "pop_2015") + 
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))
```

## Acknowledgements
The code used to generate the map files was based on this blog post by [Bob Rudis](https://github.com/hrbrmstr):    
[Moving The Earth (well, Alaska & Hawaii) With R](https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/)

