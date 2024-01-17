# 🗺 usmap
[![CRAN](http://www.r-pkg.org/badges/version/usmap?color=blue)](https://cran.r-project.org/package=usmap) [![Downloads](http://cranlogs.r-pkg.org/badges/grand-total/usmap)](https://cran.r-project.org/package=usmap) [![Build Status](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Factions-badge.atrox.dev%2Fpdil%2Fusmap%2Fbadge%3Fref%3Dmaster&style=popout&label=build)](https://actions-badge.atrox.dev/pdil/usmap/goto?ref=master) [![codecov](https://codecov.io/gh/pdil/usmap/branch/master/graph/badge.svg)](https://app.codecov.io/gh/pdil/usmap)

<p align="center"><img src="https://raw.githubusercontent.com/pdil/usmap/master/resources/example-plots.png" /></p>

View code used to generate these plots: [resources/examples.R](https://github.com/pdil/usmap/blob/master/resources/examples.R)

## Purpose
Typically in R it is difficult to create nice US [choropleths](https://en.wikipedia.org/wiki/Choropleth_map) that include Alaska and Hawaii. The functions presented here attempt to elegantly solve this problem by manually moving these states to a new location and providing a simple features ([`sf`](https://github.com/r-spatial/sf)) object for mapping and visualization. This allows the user to easily add visual data or features to the US map.

## Shape Files
The shape files that we use to plot the maps in R are located in the [`usmapdata`](https://github.com/pdil/usmapdata) package. These are generated from the [US Census Bureau cartographic boundary files](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.html). Maps at both the state and county levels are included for convenience.

#### Update History

| Date              | `usmap` version | Shape File Year | Link |
| ---               | :-:             | :-:             | :-:  |
| (unreleased)      | 0.7.0           | 2022            | [🔗](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2022.html) |
| February 27, 2022 | 0.6.0           | 2020            | [🔗](https://www.census.gov/geographies/mapping-files/time-series/geo/cartographic-boundary.2020.html) |
| June 3, 2018      | 0.3.0           | 2017            | [🔗](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.2017.html)   |
| January 29, 2017  | 0.1.0           | 2015            | [🔗](https://www.census.gov/geographies/mapping-files/time-series/geo/carto-boundary-file.2015.html)   |

## Installation
📦 To install from CRAN (recommended), run the following code in an R console:
```r
install.packages("usmap")
```

### Developer Build
⚠️ The developer build may be unstable and not function correctly, use with caution.

To install the package from this repository, run the following code in an R console:
```r
# install.package("devtools")
devtools::install_github("pdil/usmap")
```
This method will provide the most recent developer build of `usmap`.

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

For further help with this package, open an [issue](https://github.com/pdil/usmap/issues) or ask a question on Stack Overflow with the [usmap tag](https://stackoverflow.com/questions/tagged/usmap).

## Features
* Obtain map with certain region breakdown
```r
state_map <- us_map(regions = "states")
```
<details>
  <summary><code>state_map</code></summary>

  ```r
  #> Simple feature collection with 51 features and 3 fields
  #> Geometry type: MULTIPOLYGON
  #> Dimension:     XY
  #> Bounding box:  xmin: -2590847 ymin: -2608148 xmax: 2523581 ymax: 731407.9
  #> Projected CRS: NAD27 / US National Atlas Equal Area
  #> # A tibble: 51 × 4
  #>    fips  abbr  full                               geom
  #>    <chr> <chr> <chr>                <MULTIPOLYGON [m]>
  #>  1 02    AK    Alaska        (((-2396847 -2547721, -2…
  #>  2 01    AL    Alabama       (((1093777 -1378535, 109…
  #>  3 05    AR    Arkansas      (((483065.2 -927788.2, 5…
  #>  4 04    AZ    Arizona       (((-1388676 -1254584, -1…
  #>  5 06    CA    California    (((-1719946 -1090033, -1…
  #>  6 08    CO    Colorado      (((-789538.7 -678773.8, …
  #>  7 09    CT    Connecticut   (((2161733 -83737.52, 21…
  #>  8 11    DC    District of … (((1955479 -402055.2, 19…
  #>  9 10    DE    Delaware      (((2042506 -284367.3, 20…
  #> 10 12    FL    Florida       (((1855611 -2064809, 186…
  #> # ℹ 41 more rows
  ```
</details><br>

```r
county_map <- us_map(regions = "counties")
```
<details>
  <summary><code>county_map</code></summary>

  ```r
  #> Simple feature collection with 3144 features and 4 fields
  #> Geometry type: MULTIPOLYGON
  #> Dimension:     XY
  #> Bounding box:  xmin: -2590847 ymin: -2608148 xmax: 2523581 ymax: 731407.9
  #> Projected CRS: NAD27 / US National Atlas Equal Area
  #> # A tibble: 3,144 × 5
  #> fips  abbr  full   county                      geom
  #> <chr> <chr> <chr>  <chr>         <MULTIPOLYGON [m]>
  #> 1 02013 AK    Alaska Aleut… (((-1762715 -2477334, -1…
  #> 2 02016 AK    Alaska Aleut… (((-2396847 -2547721, -2…
  #> 3 02020 AK    Alaska Ancho… (((-1517576 -2089908, -1…
  #> 4 02050 AK    Alaska Bethe… (((-1905141 -2137046, -1…
  #> 5 02060 AK    Alaska Brist… (((-1685825 -2253496, -1…
  #> 6 02063 AK    Alaska Chuga… (((-1476669 -2101298, -1…
  #> 7 02066 AK    Alaska Coppe… (((-1457015 -2063407, -1…
  #> 8 02068 AK    Alaska Denal… (((-1585793 -1980740, -1…
  #> 9 02070 AK    Alaska Dilli… (((-1793024 -2236835, -1…
  #> 10 02090 AK    Alaska Fairb… (((-1512363 -1851013, -1…
  #> # ℹ 3,134 more rows
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
<p align="center"><img src="https://raw.githubusercontent.com/pdil/usmap/master/resources/example-usage.png" /></p>

## Additional Information

### Coordinate System
`usmap` uses the [US National Atlas Equal Area](https://epsg.io/9311) coordinate system:

<details>
    <summary><code>sf::st_crs(9311)</code></summary>

    ```r
    #> Coordinate Reference System:
    #>   User input: EPSG:9311
    #>   wkt:
    #> PROJCRS["NAD27 / US National Atlas Equal Area",
    #>     BASEGEOGCRS["NAD27",
    #>         DATUM["North American Datum 1927",
    #>             ELLIPSOID["Clarke 1866",6378206.4,294.978698213898,
    #>                 LENGTHUNIT["metre",1]]],
    #>         PRIMEM["Greenwich",0,
    #>             ANGLEUNIT["degree",0.0174532925199433]],
    #>         ID["EPSG",4267]],
    #>     CONVERSION["US National Atlas Equal Area",
    #>         METHOD["Lambert Azimuthal Equal Area (Spherical)",
    #>             ID["EPSG",1027]],
    #>         PARAMETER["Latitude of natural origin",45,
    #>             ANGLEUNIT["degree",0.0174532925199433],
    #>             ID["EPSG",8801]],
    #>         PARAMETER["Longitude of natural origin",-100,
    #>             ANGLEUNIT["degree",0.0174532925199433],
    #>             ID["EPSG",8802]],
    #>         PARAMETER["False easting",0,
    #>             LENGTHUNIT["metre",1],
    #>             ID["EPSG",8806]],
    #>         PARAMETER["False northing",0,
    #>             LENGTHUNIT["metre",1],
    #>             ID["EPSG",8807]]],
    #>     CS[Cartesian,2],
    #>         AXIS["easting (X)",east,
    #>             ORDER[1],
    #>             LENGTHUNIT["metre",1]],
    #>         AXIS["northing (Y)",north,
    #>             ORDER[2],
    #>             LENGTHUNIT["metre",1]],
    #>     USAGE[
    #>         SCOPE["Statistical analysis."],
    #>         AREA["United States (USA) - onshore and offshore."],
    #>         BBOX[15.56,167.65,74.71,-65.69]],
    #>     ID["EPSG",9311]]
    ```
</details>

This [coordinate reference system (CRS)](https://www.nceas.ucsb.edu/sites/default/files/2020-04/OverviewCoordinateReferenceSystems.pdf) can also be obtained with `usmap::usmap_crs()`.

## Acknowledgments
The code used to generate the map files was based on this blog post by [Bob Rudis](https://github.com/hrbrmstr):
[Moving The Earth (well, Alaska & Hawaii) With R](https://rud.is/b/2014/11/16/moving-the-earth-well-alaska-hawaii-with-r/)
