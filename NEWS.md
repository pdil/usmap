# usmap 0.3.0.9999
* Ability to include state abbreviation labels in state maps, see [Issue #9](https://github.com/pdil/usmap/issues/9).
  * e.g. `plot_usmap(labels = TRUE)`
* Vectorize counties in `fips`, see [Issue #10](https://github.com/pdil/usmap/issues/10).
  * e.g. `fips("NJ", c("Bergen", "Hudson"))`
* Allow all columns in the data frame that's passed to `map_with_data()` or `plot_usmap()` to be preserved.
* Allow ability to include only certain states while viewing county map, see [Issue #11](https://github.com/pdil/usmap/issues/11).
  * e.g. `us_map("counties", include = "TX")` or `plot_usmap("counties", include = c("AZ", "NM"))`
* Add US Census Bureau regional divisions as constants for quick plotting of certain regions.
  * e.g. `plot_usmap(include = .northeast_region)`
  * The provided regions and divisions can be seen [on this map by the US Census Bureau](https://www2.census.gov/geo/pdfs/maps-data/maps/reference/us_regdiv.pdf).

### Bug Fixes
* Add Kusilvak Census Area (FIPS code 02158), replaces Wade Hampton Census Area (FIPS code 02270).

# usmap 0.3.0

### Improvements
* Update shape files to [2017 versions](https://www.census.gov/geo/maps-data/data/tiger-cart-boundary.html).
* Improvements to `fips` and `fips_info`:
  * Vectorization support (e.g. enter multiple states in `fips` to receive a vector of corresponding FIPS codes)
  * e.g. `fips(c("AK", "AL"))` or `fips(c("Alaska", "Alabama"))`
  * Mixed abbreviations and full names are also supported: `fips(c("AK", "Alabama"))`
  * Improved warning and error messages.
* Allow data to be specified by state abbreviation or full name in `plot_usmap` and `map_with_data` (instead of just by FIPS code).
  * The data frame passed to `plot_usmap` or `map_with_data` (via the `data =` parameter), can now be a two column data frame with columns "fips" and "values" or "state" and "values".

# usmap 0.2.1

### Improvements
* Standardize documentation language.
* Improve descriptiveness of error messages and warnings.
### Bug Fixes
* Allow data passed to `map_with_data` and `plot_usmap` to contain FIPS codes with missing leading zeros.
  * This usually occurs when the codes are read as `numeric` from a `.csv` file.

# usmap 0.2.0

* Add `map_with_data` function for adding user-defined data to map data.
* Add ability to plot map with data automatically (utilizes new `map_with_data` function).

# usmap 0.1.0

* First release

### Main features

* Retrieve US map data frame for merging with data and plotting
* Lookup FIPS codes for states and counties (reverse-lookup as well)
* Map plotting convenience method (uses `ggplot2`)
