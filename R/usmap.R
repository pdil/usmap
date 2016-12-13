#' Retrieve US map data
#' 
#' @param region The region breakdown for the map, either `states` or `counties`.
#' @param include The regions to include in the output data frame. The regions
#'  must be of the same type as `region`.
#'  
#' @return A data frame of US map coordinates divided by the desired `region`.
#' @examples
#' print("Examples will go here.")
us_map <- function(region, include = c()) {
  if (region %in% c("states", "counties")) {
    load(system.file("extdata", paste0("us_", region, ".rda"), package = "usmap"))
    
    if (length(include) > 0) {
      map <- map[map$id %in% include, ]  
    }
    
    return(map)
  } else {
    stop("Region must be either `states` or `counties`.")
  }
}
