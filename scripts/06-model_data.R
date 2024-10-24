#### Preamble ####
# Purpose: Models the analysis data of president polls
# Author: Tianrui Fu & Yiyue Deng
# Date: 21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The analysis data has been cleaned.
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
just_trump_high_quality <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
# Model 1: pct as a function of end_date
model_all <- lm(pct ~ pollster + numeric_grade + pollscore + methodology + 
                   transparency_score + state + end_date + sample_size, data = just_trump_high_quality)
summary(model_all)
# Model 2: pct as a function of end_date and pollster
model_chosen <- lm(pct ~ end_date + state + sample_size, data = just_trump_high_quality)
summary(model_chosen)

# Augment data with model predictions
library(modelr)

just_trump_high_quality <- just_trump_high_quality |>
  add_predictions(model_all, var = "fitted_all") |>
  add_predictions(model_chosen, var = "fitted_chosen")

# Plot model predictions
# Model 1
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_all), color = "red", linetype = "dotted") +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ end_date")

# Model 2
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_chosen), color = "red", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ end_date + pollster")

#### Save model ####
saveRDS(
  model_all,
  file = "models/model_all.rds"
)

saveRDS(
  model_chosen,
  file = "models/model_chosen.rds"
)
