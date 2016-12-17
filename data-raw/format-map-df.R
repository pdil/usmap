
source("states-fips.R")

states_map_df <- readr::read_csv("us_states_raw.csv")

merged_states_df <- merge(states_map_df, states_fips, by.x = "id", by.y = "fips", all.x = TRUE)
final_states_df <- merged_states_df[, c("long", "lat", "order", "hole", "piece", "group", "id", "abbr", "full")]
colnames(final_states_df) <- c("long", "lat", "order", "hole", "piece", "group", "fips", "abbr", "full")

write.csv(final_states_df, file = "us_states.csv", row.names = FALSE, na = "")
write.csv(states_fips, file = "state_fips.csv", row.names = FALSE, na = "")

# County FIPS ####

county_fips <- readr::read_csv("county_fips.txt", col_names = FALSE)
colnames(county_fips) <- c("abbr", "state_fips", "county_fips", "county", "class_code")

county_fips_merged <- merge(county_fips, states_fips, by = "abbr", all.x = TRUE)

county_fips_final <- data.frame(
  full = county_fips_merged$full, 
  abbr = county_fips_merged$abbr, 
  county = county_fips_merged$county, 
  fips = paste0(county_fips_merged$state_fips, county_fips_merged$county_fips)
)

write.csv(county_fips_final, file = "county_fips.csv", row.names = FALSE, na = "")
