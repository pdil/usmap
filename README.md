# us-map

#### Purpose
Typically in R it is difficult to create nice US [choropleths](http://en.wikipedia.org/wiki/Choropleth) that include Alaska and Hawaii. The templates presented here attempt to elegantly solve this problem by utilizing `ggplot2`. This allows the user to easily add data to color the map. Eventually these templates may be deployed as an R package.

#### Shape Files
The shape files that we use to plot the maps in R are located in the `data` folder. For more information refer to https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html. Map scales of varying sizes (1:500,000 to 1:20,000,000) at both the state and county levels are included for convenience.

#### R Scripts
* `county-map.R` - US map with county borders.
* `state-map.R` - US map withs state borders.

#### Examples
*Coming soon...*
