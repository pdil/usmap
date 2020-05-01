
setwd("data-raw/maps/")

# State FIPS ####
source("states-fips.R")
write.csv(states_fips, file = "state_fips.csv", row.names = FALSE, na = "")

# Merge state FIPS with map ####
states_map_df <- readr::read_csv("us_states_raw.csv") # old w/o PR
library(readr)
pr_states_map_df <- readr::read_csv("us_states_raw_PR.csv",
                                    col_types =
                                    cols(
                                      long = col_double(),
                                      lat = col_double(),
                                      order = col_double(),
                                      hole = col_logical(),
                                      piece = col_double(),
                                      id = col_character(),
                                      group = col_character()
                                    )) # new w/ PR

states_map_df <- bind_rows(states_map_df, pr_states_map_df)

merged_states_df <- merge(states_map_df, states_fips,
                          by.x = "id", by.y = "fips", all.x = TRUE)

final_states_df <- merged_states_df[, c("long", "lat", "order", "hole", "piece",
                                        "group", "id", "abbr", "full")]

colnames(final_states_df) <- c("x", "y", "order", "hole", "piece",
                               "group", "fips", "abbr", "full")

write.csv(final_states_df, file = "us_states.csv", row.names = FALSE, na = "")

# Merge states with centroids ####
states_centroids_df <- readr::read_csv("us_state_centroids_raw.csv")
merged_state_centroids_df <- merge(states_centroids_df, states_fips,
                                   by = "fips", all.x = TRUE)

final_state_centroids_df <- merged_state_centroids_df[, c("x", "y", "fips", "abbr", "full")]
write.csv(final_state_centroids_df, file = "us_states_centroids.csv", row.names = FALSE, na = "")


# County FIPS ####
county_fips <- readr::read_csv("county_fips.txt", col_names = FALSE)
colnames(county_fips) <- c("abbr", "state_fips", "county_fips", "county", "class_code")

county_fips_merged <- merge(county_fips, states_fips, by = "abbr", all.x = TRUE)
county_fips_final <- data.frame(
  full = county_fips_merged$full,
  abbr = county_fips_merged$abbr,
  county = county_fips_merged$county,
  fips = paste0(county_fips_merged$state_fips, county_fips_merged$county_fips),
  stringsAsFactors = FALSE
)

write.csv(county_fips_final, file = "county_fips.csv", row.names = FALSE, na = "")

# Merge county FIPS with map ####
counties_map_df <- readr::read_csv("us_counties_raw.csv")
merged_counties_df <- merge(counties_map_df, county_fips_final,
                            by.x = "id", by.y = "fips", all.x = TRUE, sort = FALSE)

sorted_counties_df <- merged_counties_df[order(
  merged_counties_df$full,
  merged_counties_df$piece,
  merged_counties_df$order), ]

final_counties_df <- sorted_counties_df[, c("long", "lat", "order", "hole", "piece",
                                            "group", "id", "abbr", "full", "county")]

colnames(final_counties_df) <- c("x", "y", "order", "hole", "piece",
                                 "group", "fips", "abbr", "full", "county")

write.csv(final_counties_df, file = "us_counties.csv", row.names = FALSE, na = "")

# Merge counties with centroids ####
counties_centroids_df <- readr::read_csv("us_county_centroids_raw.csv")
merged_counties_centroids_df <- merge(counties_centroids_df, county_fips_final,
                                      by = "fips", all.x = TRUE)

final_counties_centroids_df <- merged_counties_centroids_df[, c("x", "y", "fips", "abbr", "full", "county")]
write.csv(final_counties_centroids_df, file = "us_counties_centroids.csv", row.names = FALSE, na = "")
