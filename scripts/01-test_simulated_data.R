#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US president polls dataset.
# Author: Tianrui Fu & Yiyue Deng & Jianing Li
# Date:  21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure we are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)


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

analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test 1: Check if the data frame was successfully read
test_1 <- exists("analysis_data") && is.data.frame(analysis_data)
print(test_1)

# Test 2: Check if the data frame has 500 rows
test_2 <- nrow(analysis_data) == 500
print(test_2) 

# Test 3: Check if the data frame contains the "pollster" column
test_3 <- "pollster" %in% colnames(analysis_data)
print(test_3) 

# Test 4: Check if all values in the "pct" column are between 0 and 100
test_4 <- all(analysis_data$pct >= 0 & analysis_data$pct <= 100)
print(test_4) 

# Test 5: Check if the "date" column is in date format
test_5 <- all(sapply(analysis_data$date, function(x) inherits(as.Date(x), "Date")))
print(test_5) 

# Test 6: Check if values in the "numeric_grade" column are between 2.7 and 3.0
test_6 <- all(analysis_data$numeric_grade >= 2.7 & analysis_data$numeric_grade <= 3.0)
print(test_6) 

# Test 7: Check if values in the "pollscore" column are between -1.5 and 0
test_7 <- all(analysis_data$pollscore >= -1.5 & analysis_data$pollscore <= 0)
print(test_7) 

# Test 8: Check if values in the "transparency_score" column are between 4.5 and 10.0
test_8 <- all(analysis_data$transparency_score >= 4.5 & analysis_data$transparency_score <= 10.0)
print(test_8) 

# Test 9: Check for any NA values in the data frame
test_9 <- !any(is.na(analysis_data))
print(test_9) 

# Test: Check if values in the "candidate_name" column are in the specified candidates
test_candidate_name <- all(analysis_data$candidate_name %in% candidates)
print(test_candidate_name)

# Test 11: Check if all pollster values are character strings (format check)
test_11 <- all(sapply(analysis_data$pollster, is.character))
print(test_11) 

# Test 12: Check if all candidate values are in the specified candidates
test_12 <- all(analysis_data$candidate_name %in% candidates)
print(test_12) 

