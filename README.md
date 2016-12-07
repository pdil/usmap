# usmap
[![Version](https://badge.fury.io/gh/pdil%2Fusmap.svg)](https://github.com/pdil/usmap/releases) [![Build Status](https://travis-ci.org/pdil/usmap.svg?branch=master)](https://travis-ci.org/pdil/usmap) [![codecov](https://codecov.io/gh/pdil/usmap/branch/master/graph/badge.svg)](https://codecov.io/gh/pdil/usmap)

### Note: This package is currently under construction and unreleased.
Contents are subject to change rapidly and any description contained herein may not be indicative of the final product.

=====

#### Purpose
Typically in R it is difficult to create nice US [choropleths](http://en.wikipedia.org/wiki/Choropleth) that include Alaska and Hawaii. The functions presented here attempt to elegantly solve this problem by manually moving these states to a new location and providing a fortified data frame for mapping and visualization. This allows the user to easily add data to color the map. Eventually these templates may be deployed as an R package.

#### Shape Files
The shape files that we use to plot the maps in R are located in the `data-raw` folder. For more information refer to the [US Census Bureau](https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html). Map scales of varying sizes (1:500,000 to 1:20,000,000) at both the state and county levels are included for convenience.

#### R Scripts
* *Coming soon...*

#### Examples
Here is an example of a blank U.S. map created using this code.
![Blank U.S. map](https://github.com/pdil/us-map/blob/master/blank-us-map.png)
