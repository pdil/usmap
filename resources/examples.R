
library(usmap)
library(ggplot2)

# Blank state map ####
blank_state_map <- plot_usmap()

# Blank county map ####
blank_county_map <- plot_usmap("counties")

# State population map ####
state_pop_map <-
  plot_usmap(data = statepop, values = "pop_2015") +
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# State population map with labels ####
state_pop_map_labeled <-
  plot_usmap(data = statepop, values = "pop_2015", labels = TRUE) +
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# County population map ####
county_pop_map <-
  plot_usmap(data = countypop, values = "pop_2015") +
  scale_fill_continuous(low = "blue", high = "yellow", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# County poverty map ####
county_pov_map <-
  plot_usmap(data = countypov, values = "pct_pov_2014") +
  scale_fill_continuous(low = "blue", high = "yellow", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))


# Combine plots ####
cowplot::plot_grid(
  blank_state_map,
  blank_county_map,
  state_pop_map,
  state_pop_map_labeled,
  county_pop_map,
  county_pov_map,
  ncol = 2
)

# 950 x 1100 px
# 16 x 22 in
ggsave("resources/example_plots.png", width = 16, height = 22, units = "in")
