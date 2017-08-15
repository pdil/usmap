# usmap 0.2.1.9000
* 

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
