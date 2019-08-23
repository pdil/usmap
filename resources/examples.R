
library(usmap)
library(ggplot2)

# Blank state map ####
blank_state_map <- plot_usmap()

# Blank county map ####
blank_county_map <- plot_usmap("counties")

# Population by state ####
state_pop_map <-
  plot_usmap(data = statepop, values = "pop_2015") +
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Population by state with labels ####
state_pop_map_labeled <-
  plot_usmap(data = statepop, values = "pop_2015", labels = TRUE) +
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Population by county ####
county_pop_map <-
  plot_usmap(data = countypop, values = "pop_2015") +
  scale_fill_continuous(low = "blue", high = "yellow", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Poverty percentage by county ####
county_pov_map <-
  plot_usmap(data = countypov, values = "pct_pov_2014") +
  scale_fill_continuous(low = "blue", high = "yellow", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Combine plots ####
cowplot::plot_grid(
  blank_state_map,
  state_pop_map,
  state_pop_map_labeled,
  blank_county_map,
  county_pop_map,
  county_pov_map,
  nrow = 2
)

# Save plots ####
ggsave("resources/example-plots.png", width = 18, height = 10, units = "in")
