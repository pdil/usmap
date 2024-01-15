# usmap 0.6.4.9999

### Improvements
* Migrate to new `usmapdata 0.2.0` `sf`-based map data files.
  * Map data produced by `us_map()` is now returned as an `sf` object instead of a standard data frame.
  * Allows for further flexibility in manipulation, easier plotting, and reduced file sizes.
  * There should be no visible changes to existing `usmap` functionality.
  * If something doesn't look right, please [open an issue](https://github.com/pdil/usmap/issues).
* In accordance with the `sf` change mentioned above, the output of `usmap_transform()` has changed.
  * The output data frame now appends a single `geometry` column with the transformed points and can be plotted using `ggplot2::geom_sf()`.
  * Review the included examples and `advanced-mapping` vignette for more details.

# usmap 0.6.4
Released Monday, December 11, 2023.

### Improvements
* Replace local state and county FIPS files with `usmapdata::fips_data()`.
  * Single source of truth for this data is now housed in `usmapdata`.
  * Data will be updated in sync with shapefile updates.

### Bug Fixes
* FIPS file change resolves issue with Valdez-Cordova Census Area in Alaska, see [Issue #72](https://github.com/pdil/usmap/issues/72).

### Technical Changes
* Resolve all code-linting warnings.
* Increase test coverage to 100%.

# usmap 0.6.3
Released Saturday, October 21, 2023.

* Update package author email and website.

# usmap 0.6.2
Released Tuesday, June 13, 2023.

### Bug Fixes
* Replace retired packages `maptools` and `rgdal` with `sp` and `sf`, see [Issue #57](https://github.com/pdil/usmap/issues/57) and [Issue #70](https://github.com/pdil/usmap/issues/70).
  * Special thanks [@rsbivand](https://github.com/rsbivand).

# usmap 0.6.1
Released Saturday, November 12, 2022.

### Bug Fixes
* Fix failing `plot_usmap` tests, see [Issue #58](https://github.com/pdil/usmap/issues/58).
* Fix `aes_string` and `size` deprecation in ggplot2, see [Issue #59](https://github.com/pdil/usmap/issues/59).

# usmap 0.6.0
Released Sunday, February 27, 2022.

### New Features
* Add `input_names` and `output_names` parameters to `usmap_transform`, see [Issue #33](https://github.com/pdil/usmap/issues/33).
* Add `sortAndRemoveDuplicates` parameter to `fips_info`, see [Issue #47](https://github.com/pdil/usmap/issues/47).
  * The default (`FALSE`) value changes existing behavior, to retain existing behavior, change the parameter value to `TRUE`.

### Improvements
* Improve map resolution.
  * More polygons are shown, this has a marginal increase on the data set file sizes but it is negligible.
* Add shape file update history, see [Issue #30](https://github.com/pdil/usmap/issues/30).
* Extract map data frame to external [usmapdata](https://github.com/pdil/usmapdata) package to reduce `usmap` package size, see [Issue #39](https://github.com/pdil/usmap/issues/39).
  * All existing functions (including `us_map()`) should continue to work as usual.
* Add data format examples for `plot_usmap` to "Mapping" vignette, see [Issue #42](https://github.com/pdil/usmap/issues/42).

### Bug Fixes
* Fix CRS warnings, see [Issue #40](https://github.com/pdil/usmap/issues/40).
* Fix `plot_usmap()` issue when provided data has `"values"` column, see [Issue #48](https://github.com/pdil/usmap/issues/48) and [this Stack Overflow question](https://stackoverflow.com/questions/61111024/trouble-using-plot-usmap-function-in-usmap-package).

# usmap 0.5.2
Released Wednesday, October 7, 2020.

* Update links in documentation.

# usmap 0.5.1
Released Wednesday, October 7, 2020.

* New website for the package: https://usmap.dev
  * Lightweight landing page containing useful information, links, and examples of usmap usage.
* `state` can now be omitted when using `fips()`. In this case, all available FIPS codes are returned, sorted by state abbreviation, see [Issue #28](https://github.com/pdil/usmap/issues/28).
* `fips` can now be omitted when using `fips_info()`. In this case, all available states are returned, sorted by state abbreviation, see [Issue #28](https://github.com/pdil/usmap/issues/28).
* Fix duplicate coordinates from being removed during `usmap_transform` (if value columns differ), see [Issue #32](https://github.com/pdil/usmap/issues/32).
* Prevent [warnings introduced by `ggplot2` v3.3.0](https://github.com/tidyverse/ggplot2/pull/3346), see [Issue #35](https://github.com/pdil/usmap/issues/35).
* Set minimum R version to 3.5.0. Versions lower than this do not support the latest version of the `rgdal` package.

# usmap 0.5.0
Released Friday, September 13, 2019.

### New Features
* Ability to include county name labels on county maps, see [Issue #14](https://github.com/pdil/usmap/issues/14).
  * They currently work the same as state labels except they include the full county name (excluding the word "County").
* Ability to pass `ggplot2::geom_polygon()` parameters to `plot_usmap()`, see [Issue #15](https://github.com/pdil/usmap/issues/15).
  * This is a breaking change and removes the `lines` parameter. The previous defaults of `color="black"`, `fill="white"`, and `size=0.4` are maintained and will be used for any of those parameters that are omitted.
  * Refer to the `ggplot2::geom_polygon()` documentation for more information.
  * The following aesthetics are supported: `alpha`, `colour`/`color`, `fill`, `linetype`, `size`
  * This feature provides more direct control over the appearance of plots.
* Ability to exclude counties and states with new `exclude` parameter in `us_map`, `map_with_data`, and `plot_usmap`, see [Issue #19](https://github.com/pdil/usmap/issues/19).
* New function (`usmap_transform`) to transform longitude/latitude point data frames into coordinate reference system that matches the plotted map, see [Issue #21](https://github.com/pdil/usmap/issues/21).
  * Also includes `usmap_crs()` to easily access the coordinate reference system used by the package.

### Improvements
* In the data frames provided by `us_map()`, `long` and `lat` have been renamed to `x` and `y`, respectively, see [Issue #16](https://github.com/pdil/usmap/issues/16).
  * This should not affect the behavior of `plot_usmap()` but will be a breaking change for any code that relies on `us_map()`.
* Added contributing guidelines and templates, see [Issue #24](https://github.com/pdil/usmap/issues/24).
  * These can be see in the [.github folder](https://github.com/pdil/usmap/tree/master/.github).

# usmap 0.4.0
Released Sunday, September 16, 2018.

### New Features
* Ability to include state abbreviation labels in state maps, see [Issue #9](https://github.com/pdil/usmap/issues/9).
  * e.g. `plot_usmap(labels = TRUE)`
* Add US Census Bureau regional divisions as constants for quick plotting of certain regions.
  * e.g. `plot_usmap(include = .northeast_region)`
  * The provided regions and divisions can be seen [on this map by the US Census Bureau](https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf).
* Allow ability to include only certain states while viewing county map, see [Issue #11](https://github.com/pdil/usmap/issues/11).
  * e.g. `us_map("counties", include = "TX")` or `plot_usmap("counties", include = c("AZ", "NM"))`

### Improvements
* Vectorize counties in `fips`, see [Issue #10](https://github.com/pdil/usmap/issues/10).
  * e.g. `fips("NJ", c("Bergen", "Hudson"))`
* Allow all columns in the data frame that's passed to `map_with_data()` or `plot_usmap()` to be preserved.

### Bug Fixes
* Add Kusilvak Census Area (FIPS code 02158), replaces Wade Hampton Census Area (FIPS code 02270).

# usmap 0.3.0
Released Sunday, June 3, 2018.

### Improvements
* Update shape files to [2017 versions](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.2017.html).
* Improvements to `fips` and `fips_info`:
  * Vectorization support (e.g. enter multiple states in `fips` to receive a vector of corresponding FIPS codes)
  * e.g. `fips(c("AK", "AL"))` or `fips(c("Alaska", "Alabama"))`
  * Mixed abbreviations and full names are also supported: `fips(c("AK", "Alabama"))`
  * Improved warning and error messages.
* Allow data to be specified by state abbreviation or full name in `plot_usmap` and `map_with_data` (instead of just by FIPS code).
  * The data frame passed to `plot_usmap` or `map_with_data` (via the `data =` parameter), can now be a two column data frame with columns "fips" and "values" or "state" and "values".

# usmap 0.2.1
Released Tuesday, August 15, 2017.

### Improvements
* Standardize documentation language.
* Improve descriptiveness of error messages and warnings.
### Bug Fixes
* Allow data passed to `map_with_data` and `plot_usmap` to contain FIPS codes with missing leading zeros.
  * This usually occurs when the codes are read as `numeric` from a `.csv` file.

# usmap 0.2.0
Released Saturday, April 29, 2017.

* Add `map_with_data` function for adding user-defined data to map data.
* Add ability to plot map with data automatically (utilizes new `map_with_data` function).

# usmap 0.1.0
Released Sunday, January 29, 2017.

* First release

### Main features

* Retrieve US map data frame for merging with data and plotting
* Lookup FIPS codes for states and counties (reverse-lookup as well)
* Map plotting convenience method (uses `ggplot2`)
