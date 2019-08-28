## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ---- fig.align='center', fig.width=7, message=FALSE, warning=FALSE------
library(usmap)
library(ggplot2)

plot_usmap(regions = "counties") + 
  labs(title = "US Counties", subtitle = "This is a blank map of the counties of the United States.") + 
  theme(panel.background = element_rect(color = "black", fill = "lightblue"))

## ---- fig.align='center', fig.width=7, message=FALSE, warning=FALSE------
library(usmap)
library(ggplot2)

plot_usmap(include = c("CA", "ID", "NV", "OR", "WA")) +
  labs(title = "Western US States", subtitle = "These are the states in the Pacific Timezone.")

## ---- fig.align='center', fig.width=7, message=FALSE, warning=FALSE------
library(usmap)
library(ggplot2)

plot_usmap(data = statepop, values = "pop_2015", color = "red") + 
  scale_fill_continuous(name = "Population (2015)", label = scales::comma) + 
  theme(legend.position = "right")

## ---- fig.align='center', fig.width=7, message=FALSE, warning=FALSE------
library(usmap)
library(ggplot2)

plot_usmap(data = statepop, values = "pop_2015", color = "red") + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Population (2015)", label = scales::comma
  ) + theme(legend.position = "right")

## ---- fig.align='center', fig.width=7, message=FALSE, warning=FALSE------
library(usmap)
library(ggplot2)

plot_usmap(
    data = statepop, values = "pop_2015", include = c("CA", "ID", "NV", "OR", "WA"), color = "red"
  ) + 
  scale_fill_continuous(
    low = "white", high = "red", name = "Population (2015)", label = scales::comma
  ) + 
  labs(title = "Western US States", subtitle = "These are the states in the Pacific Timezone.") +
  theme(legend.position = "right")

## ------------------------------------------------------------------------
str(usmap::us_map())

## ------------------------------------------------------------------------
str(usmap::us_map(regions = "counties"))

