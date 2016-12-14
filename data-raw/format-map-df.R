
source("states-fips.R")

states_map_df <- readr::read_csv("us_states_raw.csv")
merged_states_df <- merge(states_map_df, states_fips, by.x = "id", by.y = "fips", all.x = TRUE)
final_states_df <- merged_states_df[, c("long", "lat", "order", "hole", "piece", "group", "id", "abbr", "full")]
colnames(final_states_df) <- c("long", "lat", "order", "hole", "piece", "group", "fips", "abbr", "full")

write.csv(final_states_df, file = "us_states.csv", row.names = FALSE, na = "")
