#### Preamble ####
# Purpose: Cleans the president polls dataset
# Author: Tianrui Fu & Yiyue Deng & Jianing Li
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

just_trump_high_quality <- data |>
  select(
    -"sponsor_ids" , 
    -"sponsors" , 
    -"sponsor_candidate_id", 
    -"sponsor_candidate", 
    -"sponsor_candidate_party", 
    -"endorsed_candidate_id", 
    -"endorsed_candidate_name", 
    -"endorsed_candidate_party", 
    -"subpopulation", 
    -"tracking", 
    -"notes", 
    -"url_topline", 
    -"source", 
    -"internal", 
    -"partisan", 
    -"seat_name", 
    -"ranked_choice_round",
    -"url_article",
    -"url_crosstab"
  )

just_trump_high_quality <- just_trump_high_quality |>
  filter(
    candidate_name == "Donald Trump",
    numeric_grade >= 2.7 # Need to investigate this choice - come back and fix. 
    # Also need to look at whether the pollster has multiple polls or just one or two - filter out later
  ) |>
  mutate(
    state = if_else(is.na(state), "National", state), # Hacky fix for national polls - come back and check
    end_date = mdy(end_date)
  ) |>
  filter(end_date >= as.Date("2024-07-21")) |># When Trump declared
  drop_na(pct, sample_size) |>
  mutate(
    num_Trump = round((pct / 100) * sample_size, 0) # Need number not percent for some models
  )

#### Save data ####
write_parquet(x = just_trump_high_quality, sink = "data/02-analysis_data/analysis_data.parquet")

