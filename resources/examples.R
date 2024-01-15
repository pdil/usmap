
library(usmap)
library(ggplot2)

citypop_t <- usmap_transform(citypop)

# Blank state map ####
blank_state_map <- plot_usmap()

# Population by state (Midwest) ####
mw_citypop_t <- citypop_t[citypop_t$abbr %in% .midwest_region, ]

midwest_pop_map <-
  plot_usmap(data = statepop, values = "pop_2015", include = .midwest_region) +
  geom_sf(data = mw_citypop_t, aes(size = city_pop), color = "blue", alpha = 0.5) +
  scale_size_continuous(guide = "none", range = c(1, 12)) +
  scale_fill_continuous(low = "white", high = "green", guide = "none") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Population by state ####
state_pop_map <-
  plot_usmap(data = statepop, values = "pop_2015") +
  scale_fill_continuous(low = "white", high = "red", guide = "none") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Blank county map (Alaska) ####
ak_blank_county_map <-
  plot_usmap("counties", include = "AK", color = "red", fill = "#fffdcf")

# Population by state with labels ####
state_pop_map_labeled <-
  plot_usmap(data = statepop, values = "pop_2015", labels = TRUE) +
  scale_fill_continuous(low = "white", high = "red", guide = "none") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Poverty by county (South) ####
south_pov_map <-
  plot_usmap("counties", data = countypov, values = "pct_pov_2014",
             include = .south_region, color = "white", size = 0) +
  scale_fill_continuous(low = "darkgreen", high = "yellow", guide = "none") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Blank blue map ####
blue_us_map <- plot_usmap(color = "white", fill = "blue",
                          alpha = 0.75, size = 0)

# Most populous city by state (Mountain) ####
mt_citypop_t <- citypop_t[citypop_t$abbr %in% .mountain, ]

mt_citypop_map <-
  plot_usmap(include = .mountain,
             color = "red", fill = "#fffdcf",
             labels = TRUE, label_color = "red") +
  geom_sf(data = mt_citypop_t, aes(size = city_pop), color = "purple", alpha = 0.5) +
  scale_size_continuous(guide = "none", range = c(1, 12)) +
  scale_fill_continuous(low = "blue", high = "darkblue", guide = "none") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Poverty percentage by county ####
county_pov_map <-
  plot_usmap(data = countypov, values = "pct_pov_2014", size = 0.2) +
  scale_fill_continuous(low = "blue", high = "yellow", guide = "none") +
  scale_x_continuous(expand = c(0, 0)) + scale_y_continuous(expand = c(0, 0))

# Combine plots ####
cowplot::plot_grid(
  blank_state_map,
  midwest_pop_map,
  state_pop_map,
  ak_blank_county_map,
  state_pop_map_labeled,
  south_pov_map,
  blue_us_map,
  mt_citypop_map,
  county_pov_map,
  nrow = 3
)

# Save plots ####
ggsave("resources/example-plots.png", width = 18, height = 15, units = "in",
       bg = "transparent")

# README usage examples ####
mountain_states <- plot_usmap("states", include = .mountain, labels = TRUE)

fl_pct_pov <- plot_usmap("counties", data = countypov,
                         values = "pct_pov_2014", include = "FL") +
  scale_fill_continuous(low = "green", high = "red", guide = "none")

ne_pop <- plot_usmap("counties", data = countypop,
                     values = "pop_2015", include = .new_england) +
  scale_fill_continuous(low = "blue", high = "yellow", guide = "none")


# Combine usage plots ####
cowplot::plot_grid(
  mountain_states, fl_pct_pov, ne_pop, nrow = 1
)

ggsave("resources/example-usage.png", width = 18, height = 5, units = "in",
       bg = "transparent")

# Combine plots for Github social media preview image ####
cowplot::plot_grid(
  blank_state_map,
  midwest_pop_map,
  county_pov_map,
  ak_blank_county_map,
  state_pop_map_labeled,
  south_pov_map,
  nrow = 2
)

ggsave("resources/github-preview.png", width = 20, height = 10, units = "in",
       bg = "transparent")
# NOTE: scale image to 1280x640 before adding to Github profile
