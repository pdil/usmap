## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
library(usmap)
library(ggplot2)

plot_usmap(regions = "counties") + 
  labs(title = "US Counties",
       subtitle = "This is a blank map of the counties of the United States.") + 
  theme(panel.background = element_rect(color = "black", fill = "lightblue"))

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
library(usmap)
library(ggplot2)

plot_usmap(include = c("CA", "ID", "NV", "OR", "WA")) +
  labs(title = "Western US States",
       subtitle = "These are the states in the Pacific Timezone.")

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
library(usmap)
library(ggplot2)

plot_usmap(data = statepop, values = "pop_2022", color = "red") + 
  scale_fill_continuous(name = "Population (2022)", label = scales::comma) + 
  theme(legend.position = "right")

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
library(usmap)
library(ggplot2)

plot_usmap(data = statepop, values = "pop_2022", color = "red") + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Population (2022)", label = scales::comma
  ) + theme(legend.position = "right")

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
library(usmap)
library(ggplot2)

plot_usmap(
    data = statepop, values = "pop_2022", include = c("CA", "ID", "NV", "OR", "WA"), color = "red"
  ) + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Population (2022)", label = scales::comma
  ) + 
  labs(title = "Western US States", subtitle = "These are the states in the Pacific Timezone.") +
  theme(legend.position = "right")

## ----fig.show='hide', message=FALSE, warning=FALSE----------------------------
df <- data.frame(
  fips = c("02", "01", "05", "04"),
  values = c(14, 18, 19, 8)
)

plot_usmap(data = df)

## ----fig.show='hide', message=FALSE, warning=FALSE----------------------------
df <- data.frame(
  fips = c("02", "01", "05", "04"),
  population = c(14, 18, 19, 8)
)

plot_usmap(data = df, values = "population")

## ----fig.show='hide', message=FALSE, warning=FALSE----------------------------
df <- data.frame(
  state = c("AL", "Alaska", "AR", "AZ"),
  values = c(14, 18, 19, 8)
)

plot_usmap(data = df)

## ----fig.show='hide', message=FALSE, warning=FALSE----------------------------
df <- data.frame(
  fips = c("10001", "10003", "10005"),
  values = c(93, 98, 41)
)

plot_usmap(data = df)

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
usmap::plot_usmap(include = .south_region)

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
usmap::plot_usmap(include = .east_south_central)

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
usmap::plot_usmap(include = .south_region, exclude = .east_south_central)

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
usmap::plot_usmap("counties", 
                  include = c(.south_region, "IA"), 
                  exclude = c(.east_south_central, "12"))  # 12 = FL

## ----fig.align='center', fig.width=7, message=FALSE, warning=FALSE------------
usmap::plot_usmap("counties", fill = "yellow", alpha = 0.25,
                  # 06065 = Riverside County, CA
                  include = c(.south_region, "IA", "06065"),
                  # 12 = FL, 48141 = El Paso County, TX
                  exclude = c(.east_south_central, "12", "48141"))

## -----------------------------------------------------------------------------
.new_england
.mid_atlantic
.east_north_central
.west_north_central
.south_atlantic
.east_south_central
.west_south_central
.mountain
.pacific

## -----------------------------------------------------------------------------
.northeast_region      # c(.new_england, .mid_atlantic)
.north_central_region  # c(.east_north_central, .west_north_central)
.midwest_region        # .north_central_region (renamed in June 1984)
.south_region          # c(.south_atlantic, .east_south_central, .west_south_central)
.west_region           # c(.mountain, .pacific)

## -----------------------------------------------------------------------------
str(usmap::us_map())

## -----------------------------------------------------------------------------
str(usmap::us_map(regions = "counties"))

