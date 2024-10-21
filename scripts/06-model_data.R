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
just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_data.parquet")

### Model data ####
# Model 1: pct as a function of end_date
model_date <- lm(pct ~ end_date, data = just_harris_high_quality)

# Model 2: pct as a function of end_date and pollster
model_date_pollster <- lm(pct ~ end_date + pollster, data = just_harris_high_quality)

# Augment data with model predictions
just_harris_high_quality <- just_harris_high_quality |>
  mutate(
    fitted_date = predict(model_date),
    fitted_date_pollster = predict(model_date_pollster)
  )

# Plot model predictions
# Model 1
ggplot(just_harris_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date), color = "red", linetype = "dotted") +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ end_date")

# Model 2
ggplot(just_harris_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_date_pollster), color = "red", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Harris percent", x = "Date", title = "Linear Model: pct ~ end_date + pollster")

#### Save model ####
saveRDS(
  model_date,
  file = "models/model_date.rds"
)

saveRDS(
  model_date_pollster,
  file = "models/model_date_pollster.rds"
)
