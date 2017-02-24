#'

join_data <- function(data, regions = c("states", "state", "counties", "county")) {
  regions_ <- match.arg(regions)
  
  map_df <- usmap(regions = regions_)
  
  
}
