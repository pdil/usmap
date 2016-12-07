# ==============================================================================
# create_map_plot.R
#
# Creates example map plot to display in README.md
# ==============================================================================

# library(RColorBrewer)
library(ggplot2)
library(ggthemes)

load("../data/us_state_500k.rda")

blank_map <- ggplot(data = map) + 
  geom_map(map = map, aes(x = long, y = lat, map_id = id, group = group), colour = "black", fill = "white", size = 0.3) +
  coord_equal() +
  theme_map() + 
  guides(fill = guide_legend(override.aes = list(colour = NULL))) +
  scale_x_continuous(breaks = NULL) + 
  scale_y_continuous(breaks = NULL) +
  labs(title = paste0("U.S. State Map")) +
  theme(plot.title = element_text(size = 22, face = "bold"))

ggsave("../blank-us-map.png", blank_map, width = 6, height = 4.9)