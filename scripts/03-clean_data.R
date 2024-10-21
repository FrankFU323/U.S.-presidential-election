#### Preamble ####
# Purpose: Cleans the president polls dataset
# Author: Tianrui Fu & Yiyue Deng
# Date: 21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download the dataset from the website
# Any other information needed? None

#### Workspace setup ####
library(tidyverse)
library(arrow)
library(janitor)

#### Clean data ####
# Read in the data and clean variable names
data <- read_csv("/Users/frankstrove/Desktop/STA304/US Preseident forecast/data/01-raw_data/president_polls.csv") |>
  clean_names()

just_harris_high_quality <- data |>
  filter(
    candidate_name == "Kamala Harris",
    numeric_grade >= 2.7 # Need to investigate this choice - come back and fix. 
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state), # Hacky fix for national polls - come back and check
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2024-07-21")) |> # When Harris declared
  mutate(
    num_harris = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  )

#### Plot data ####
base_plot <- ggplot(just_harris_high_quality, aes(x = end_date, y = pct)) +
  theme_classic() +
  labs(y = "Harris percent", x = "Date")

base_plot +
  geom_point() +
  geom_smooth()

# Color by pollster
base_plot +
  geom_point(aes(color = pollster)) +
  geom_smooth() +
  theme(legend.position = "bottom")

# Facet by pollster
base_plot +
  geom_point() +
  geom_smooth() +
  facet_wrap(vars(pollster))

# Color by pollscore
base_plot +
  geom_point(aes(color = factor(pollscore))) +
  geom_smooth() +
  theme(legend.position = "bottom")

#### Save data ####
write_parquet(x = just_harris_high_quality, sink = "data/02-analysis_data/analysis_data.parquet")
