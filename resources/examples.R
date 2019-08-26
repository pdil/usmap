
library(usmap)
library(ggplot2)

citypop_t <- usmap_transform(citypop)

# Blank state map ####
blank_state_map <- plot_usmap()

# Population by state (Midwest) ####
mw_citypop_t <- citypop_t[citypop_t$abbr %in% .midwest_region, ]

midwest_pop_map <-
  plot_usmap(data = statepop, values = "pop_2015", include = .midwest_region) +
  geom_point(data = mw_citypop_t, aes(x = lon.1, y = lat.1, size = city_pop),
             color = "blue", alpha = 0.5) +
  scale_size_continuous(guide = FALSE, range = c(1, 12)) +
  scale_fill_continuous(low = "white", high = "green", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Population by state ####
state_pop_map <-
  plot_usmap(data = statepop, values = "pop_2015") +
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Blank county map (Alaska) ####
ak_blank_county_map <-
  plot_usmap("counties", include = "AK",
             color = "red", fill = "yellow", alpha = 0.25)

# Population by state with labels ####
state_pop_map_labeled <-
  plot_usmap(data = statepop, values = "pop_2015", labels = TRUE) +
  scale_fill_continuous(low = "white", high = "red", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Poverty by county (South) ####
south_pov_map <-
  plot_usmap("counties", data = countypov, values = "pct_pov_2014",
             include = .south_region, color = "white", size = 0) +
  scale_fill_continuous(low = "darkgreen", high = "yellow", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Blank county map ####
blank_county_map <- plot_usmap("counties")

# Most populous city by state (Mountain) ####
mt_citypop_t <- citypop_t[citypop_t$abbr %in% .mountain, ]

mt_citypop_map <-
  plot_usmap(include = .mountain,
             color = "red", fill = "yellow", alpha = 0.25,
             labels = TRUE, label_color = "red") +
  geom_point(data = mt_citypop_t, aes(x = lon.1, y = lat.1, size = city_pop),
             color = "purple", alpha = 0.5) +
  scale_size_continuous(guide = FALSE, range = c(1, 12)) +
  scale_fill_continuous(low = "blue", high = "darkblue", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Poverty percentage by county ####
county_pov_map <-
  plot_usmap(data = countypov, values = "pct_pov_2014", size = 0.2) +
  scale_fill_continuous(low = "blue", high = "yellow", guide = FALSE) +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Combine plots ####
cowplot::plot_grid(
  blank_state_map,
  midwest_pop_map,
  state_pop_map,
  ak_blank_county_map,
  state_pop_map_labeled,
  south_pov_map,
  blank_county_map,
  mt_citypop_map,
  county_pov_map,
  nrow = 3
)

# Save plots ####
ggsave("resources/example-plots.png", width = 18, height = 15, units = "in")
