#' Retrieve US map data
#' 
#' @param regions The region breakdown for the map, either `states` or `counties`.
#' @param include The regions to include in the output data frame. The regions
#'  must be of the same type as `regions`.
#'  
#' @return A data frame of US map coordinates divided by the desired `regions`.
#' @examples
#' print("Examples will go here.")
us_map <- function(regions, include = c()) {
  if (regions %in% c("states", "counties")) {
    df <- read.csv(system.file("extdata", paste0("us_", regions, ".csv"), package = "usmap"))
    
    if (length(include) > 0) {
      df <- df[df$full %in% include | df$abbr %in% include | sprintf("%02d", df$fips) %in% include, ]  
    }
    
    return(df)
  } else {
    stop("Regions must be either `states` or `counties`.")
  }
}
