#### Preamble ####
# Purpose: Simulates a dataset of US presidential election division, including the 
  #pollster, transparency score, state, start&end date, the party division and candidate name
  #with .
# Author: Tianrui Fu & Yiyue Deng & Jianing Li
# Date: 21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(123)

#### Simulate polling data for Donald Trump and Kamala Harris ####
pollsters <- c("AtlasIntel", "Emerson", "YouGov", "Beacon/Shaw", "Quinnipiac", 
               "SurveyUSA", "Ipsos", "Marist", "Siena/NYT", 
               "University of Massachusetts Lowell/YouGov", "Marquette Law School", 
               "The Washington Post", "Suffolk", "Christopher Newport U.", 
               "YouGov/Center for Working Class Politics", 
               "McCourtney Institute/YouGov",  "Echelon Insights", "CNN/SSRS", 
               "Muhlenberg", "MassINC Polling Group", "Siena", "Selzer", 
               "Data Orbital", "Washington Post/George Mason University",
               "SurveyUSA/High Point University", "YouGov Blue", "U. North Florida")

# Candidate names
candidates <- c("Kamala Harris", "Donald Trump")

# Function to generate poll data for each pollster
poll_data <- tibble(
  pollster = sample(pollsters, size = 500, replace = TRUE),
  numeric_grade = round(runif(500, 2.7, 3.0), 1),
  pollscore = round(runif(500, -1.5, 0), 1),
  transparency_score = round(runif(500, 4.5, 10.0), 1),
  candidate_name = sample(candidates, size = 500, replace = TRUE, prob = c(0.6, 0.4)),
  pct = round(jitter(50 + rnorm(500, mean = 0, sd = 5), amount = 2), 2), 
  date = as.Date("2024-07-01") + sample(0:90, 500, replace = TRUE)
)

# View the first few rows of the simulated data
head(poll_data)


#### Save data ####
write_csv(poll_data, "data/00-simulated_data/simulated_data.csv")
