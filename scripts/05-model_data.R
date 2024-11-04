#### Preamble ####
# Purpose: Models the analysis data of president polls
# Author: Tianrui Fu & Yiyue Deng & Jianing Li
# Date: 21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca, yiyue.deng@mail.utoronto.ca & lijianing.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: The analysis data has been cleaned.
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
just_trump_high_quality <- read_parquet("data/02-analysis_data/analysis_data_trump.parquet")
just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_data_harris.parquet")


### Model data ####
# Model 1: pct as a function of end_date
model_all <- glm(pct ~ pollster + numeric_grade + pollscore + methodology + 
                   transparency_score + state + end_date, data = just_trump_high_quality)

summary(model_all)
# Model 2: pct as a function of end_date and pollster
model_chosen <- glm(pct ~ state + sample_size + pollscore + numeric_grade + end_date, data = just_trump_high_quality)
summary(model_chosen)

# Model 3: pct as a function of end_date and pollster
model_final <- glm(pct ~ numeric_grade + transparency_score + pollscore + pollster + end_date, data = just_trump_high_quality)
summary(model_final)

# model 4: bayes pct as a function of end_date and pollster for trump
just_trump_high_quality <- just_trump_high_quality |>
  mutate(
    end_date_num = as.numeric(end_date - min(end_date))
  )

model_bayes_trump <- stan_glm(
  pct ~ numeric_grade + transparency_score + pollscore + pollster + end_date, 
  data = just_trump_high_quality, 
  family = gaussian(), 
  prior = normal(0, 5), 
  prior_intercept = normal(50, 10), 
  seed = 1234,
  iter = 2000, 
  chains = 4,
  refresh = 0 
)
summary(model_bayes)
pp_check(model_bayes)

new_data <- data.frame(
  end_date = seq(
    min(just_trump_high_quality$end_date),
    max(just_trump_high_quality$end_date),
    length.out = 100
  ),
  numeric_grade = mean(just_trump_high_quality$numeric_grade),
  pollscore = mean(just_trump_high_quality$pollscore),
  transparency_score = mean(just_trump_high_quality$transparency_score),
  pollster = factor("AtlasIntel")
)

posterior_preds <- posterior_predict(model_bayes, newdata = new_data)

pred_summary <- new_data |>
  mutate(
    pred_mean = colMeans(posterior_preds),
    pred_lower = apply(posterior_preds, 2, quantile, probs = 0.025),
    pred_upper = apply(posterior_preds, 2, quantile, probs = 0.975)
  )

ggplot(just_trump_high_quality, aes(x = end_date, y = pct, color = pollster)) +
  geom_point() +
  geom_line(
    data = pred_summary,
    aes(x = end_date, y = pred_mean),
    color = "blue",
    inherit.aes = FALSE
  ) +
  geom_ribbon(
    data = pred_summary,
    aes(x = end_date, ymin = pred_lower, ymax = pred_upper),
    alpha = 0.2,
    inherit.aes = FALSE
  ) +
  labs(
    x = "End Date",
    y = "Percentage",
    title = "Poll Percentage over Time with Bayesian Fit for Trump"
  ) +
  theme_minimal()

# model 5: bayes pct as a function of end_date and pollster for harris
just_harris_high_quality <- just_harris_high_quality |>
  mutate(
    end_date_num = as.numeric(end_date - min(end_date))
  )

model_bayes_harris <- stan_glm(
  pct ~ numeric_grade + transparency_score + pollscore + pollster + end_date, 
  data = just_harris_high_quality, 
  family = gaussian(), 
  prior = normal(0, 5), 
  prior_intercept = normal(50, 10), 
  seed = 1234,
  iter = 2000, 
  chains = 4,
  refresh = 0 
)
summary(model_bayes)
pp_check(model_bayes)

new_data <- data.frame(
  end_date = seq(
    min(just_harris_high_quality$end_date),
    max(just_harris_high_quality$end_date),
    length.out = 100
  ),
  numeric_grade = mean(just_harris_high_quality$numeric_grade),
  pollscore = mean(just_harris_high_quality$pollscore),
  transparency_score = mean(just_harris_high_quality$transparency_score),
  pollster = factor("AtlasIntel")
)

posterior_preds <- posterior_predict(model_bayes, newdata = new_data)

pred_summary <- new_data |>
  mutate(
    pred_mean = colMeans(posterior_preds),
    pred_lower = apply(posterior_preds, 2, quantile, probs = 0.025),
    pred_upper = apply(posterior_preds, 2, quantile, probs = 0.975)
  )

ggplot(just_harris_high_quality, aes(x = end_date, y = pct, color = pollster)) +
  geom_point() +
  geom_line(
    data = pred_summary,
    aes(x = end_date, y = pred_mean),
    color = "blue",
    inherit.aes = FALSE
  ) +
  geom_ribbon(
    data = pred_summary,
    aes(x = end_date, ymin = pred_lower, ymax = pred_upper),
    alpha = 0.2,
    inherit.aes = FALSE
  ) +
  labs(
    x = "End Date",
    y = "Percentage",
    title = "Poll Percentage over Time with Bayesian Fit for Harris"
  ) +
  theme_minimal()

# Augment data with model predictions
library(modelr)

just_trump_high_quality <- just_trump_high_quality |>
  add_predictions(model_all, var = "fitted_all") |>
  add_predictions(model_chosen, var = "fitted_chosen") |>
  add_predictions(model_final, var = "final")

# Plot model predictions
# Model 1
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_all), color = "red", linetype = "dotted") +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ end_date")

# Model 2
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_line(aes(y = fitted_chosen), color = "red", linetype = "dotted") +
  facet_wrap(vars(pollster)) +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ end_date + pollster")

# Model 3
ggplot(just_trump_high_quality, aes(x = end_date)) +
  geom_point(aes(y = pct), color = "black") +
  geom_smooth(aes(y = final), color = "red", linetype = "dotted") +
  theme_classic() +
  labs(y = "Trump percent", x = "Date", title = "Linear Model: pct ~ end_date + numeric_grade")


#### Save model ####
saveRDS(
  model_all,
  file = "models/model_all.rds"
)

saveRDS(
  model_chosen,
  file = "models/model_chosen.rds"
)

saveRDS(
  model_final,
  file = "models/model_final.rds"
)

saveRDS(
  model_bayes_trump,
  file = "models/model_bayes_trump.rds"
)

saveRDS(
  model_bayes_harris,
  file = "models/model_bayes_harris.rds"
)

