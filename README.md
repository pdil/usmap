# 🗺 usmap
[![CRAN](http://www.r-pkg.org/badges/version/usmap?color=blue)](https://cran.r-project.org/package=usmap) [![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/usmap)](https://cran.r-project.org/package=usmap) [![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fpdil%2Fusmap%2Fbadge%3Fref%3Dmasters&style=popout&label=build)](https://actions-badge.atrox.dev/pdil/usmap/goto?ref=master) [![codecov](https://codecov.io/gh/pdil/usmap/branch/master/graph/badge.svg)](https://codecov.io/gh/pdil/usmap)

<p align="center"><img src="https://raw.githubusercontent.com/pdil/usmap/master/resources/example-plots.png" /></p>

View code used to generate these plots: [resources/examples.R](https://github.com/pdil/usmap/blob/master/resources/examples.R)

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

⚠️ The developer build may be unstable and not function correctly, use with caution.

To begin using `usmap`, import the package using the `library` command:
```r
library(usmap)
```

## Documentation

To read the package vignettes, which explain helpful uses of the package, use `vignette`:
```r
vignette(package = "usmap")
vignette("introduction", package = "usmap")
vignette("mapping", package = "usmap")
vignette("advanced-mapping", package = "usmap")
```

You can also read the vignettes online at the following links:
* [Introduction](https://cran.r-project.org/package=usmap/vignettes/introduction.html)
* [Mapping the US](https://cran.r-project.org/package=usmap/vignettes/mapping.html)
* [Advanced Mapping](https://cran.r-project.org/package=usmap/vignettes/advanced-mapping.html)

For further help with this package, open an [issue](https://github.com/pdil/usmap/issues) or ask a question on Stackoverflow with the [usmap tag](https://stackoverflow.com/questions/tagged/usmap).

## Features
* Obtain map with certain region breakdown
```r
state_map <- us_map(regions = "states")
```
<details>
  <summary><code>str(state_map)</code></summary>

  ```r
  #> 'data.frame':    12999 obs. of  9 variables:
  #> $ long : num  1091779 1091268 1091140 1090940 1090913 ...
  #> $ lat  : num  -1380695 -1376372 -1362998 -1343517 -1341006 ...
  #> $ order: int  1 2 3 4 5 6 7 8 9 10 ...
  #> $ hole : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
  #> $ piece: int  1 1 1 1 1 1 1 1 1 1 ...
  #> $ group: chr  "01.1" "01.1" "01.1" "01.1" ...
  #> $ fips : chr  "01" "01" "01" "01" ...
  #> $ abbr : chr  "AL" "AL" "AL" "AL" ...
  #> $ full : chr  "Alabama" "Alabama" "Alabama" "Alabama" ...
  ```
</details><br>

```r
county_map <- us_map(regions = "counties")
```
<details>
  <summary><code>str(county_map)</code></summary>

  ```r
  #> 'data.frame':    54187 obs. of  10 variables:
  #> $ long  : num  1225889 1244873 1244129 1272010 1276797 ...
  #> $ lat   : num  -1275020 -1272331 -1267515 -1262889 -1295514 ...
  #> $ order : int  1 2 3 4 5 6 7 8 9 10 ...
  #> $ hole  : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
  #> $ piece : int  1 1 1 1 1 1 1 1 1 1 ...
  #> $ group : chr  "01001.1" "01001.1" "01001.1" "01001.1" ...
  #> $ fips  : chr  "01001" "01001" "01001" "01001" ...
  #> $ abbr  : chr  "AL" "AL" "AL" "AL" ...
  #> $ full  : chr  "Alabama" "Alabama" "Alabama" "Alabama" ...
  #> $ county: chr  "Autauga County" "Autauga County" "Autauga County" "Autauga County" ...
  ```
</details><br>

* Look up FIPS codes for states and counties
```r
fips("New Jersey")
#> "34"

fips(c("AZ", "CA", "New Hampshire"))
#> "04" "06" "33"

fips("NJ", county = "Mercer")
#> "34021"

fips("NJ", county = c("Bergen", "Hudson", "Mercer"))
#> "34003" "34017" "34021"
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

* Add FIPS codes to data frame
```r
data <- data.frame(
  state = c("NJ", "NJ", "NJ", "PA"),
  county = c("Bergen", "Hudson", "Mercer", "Allegheny")
)

library(dplyr)
data %>% rowwise %>% mutate(fips = fips(state, county))

#>   state     county  fips
#> 1    NJ     Bergen 34003
#> 2    NJ     Hudson 34017
#> 3    NJ     Mercer 34021
#> 4    PA  Allegheny 42003
```

* Plot US maps
```r
plot_usmap("states")
plot_usmap("counties")
```
* Display only certain states, counties, or regions
```r
plot_usmap("states", include = .mountain, labels = TRUE)

plot_usmap("counties", data = countypov, values = "pct_pov_2014", include = "FL") +
    ggplot2::scale_fill_continuous(low = "green", high = "red", guide = FALSE)

plot_usmap("counties", data = countypop, values = "pop_2015", include = .new_england) + 
    ggplot2::scale_fill_continuous(low = "blue", high = "yellow", guide = FALSE)
```
<p align="center"><img src="https://raw.githubusercontent.com/pdil/usmap/master/resources/example-mountain-states.png" width="33%" /><img src="https://raw.githubusercontent.com/pdil/usmap/master/resources/example-florida-counties.png" width="33%" /><img src="https://raw.githubusercontent.com/pdil/usmap/master/resources/example-new-england-counties.png" width="33%" /></p>

## Additional Information

### Projection
`usmap` uses an [Albers equal-area conic projection](https://en.wikipedia.org/wiki/Albers_projection), with arguments as follows:
```r
usmap::usmap_crs()
#> CRS arguments:
#>     +proj=laea +lat_0=45 +lon_0=-100 +x_0=0
#>     +y_0=0 +a=6370997 +b=6370997 +units=m
#>     +no_defs 
```

To obtain the projection used by `usmap`, use `usmap_crs()`.

Alternatively, the CRS ([coordinate reference system](https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/OverviewCoordinateReferenceSystems.pdf)) can be created manually with the following command:
```r
sp::CRS("+proj=laea +lat_0=45 +lon_0=-100 +x_0=0 +y_0=0
         +a=6370997 +b=6370997 +units=m +no_defs")
```

## Acknowledgments
The code used to generate the map files was based on this blog post by [Bob Rudis](https://github.com/hrbrmstr):    
[Moving The Earth (well, Alaska & Hawaii) With R](https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/)
