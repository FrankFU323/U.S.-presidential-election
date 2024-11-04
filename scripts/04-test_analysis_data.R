#### Preamble ####
# Purpose: To check the data after cleaned
# Author: Tianrui Fu & Yiyue Deng & Jianing Li
# Date: 21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The raw data is cleaned.
# Any other information needed? None.

#### Workspace setup ####
library(tidyverse)
library(arrow)

just_trump_high_quality <- read_parquet("data/02-analysis_data/analysis_data_trump.parquet")
just_harris_high_quality <- read_parquet("data/02-analysis_data/analysis_data_harris.parquet")


#### Test data ####

# Check if just_trump_high_quality is a data frame
test_1 <- is.data.frame(just_trump_high_quality)
print(test_1)

# Check if just_trump_high_quality contains the required columns
test_2 <- all(c("candidate_name", "numeric_grade", "end_date", "pct", 
                "sample_size", "pollscore", "transparency_score") %in% colnames(just_trump_high_quality))
print(test_2)

# Check if candidate_name in just_trump_high_quality is "Donald Trump"
test_3 <- all(just_trump_high_quality$candidate_name == "Donald Trump")
print(test_3)

# Check if numeric_grade in just_trump_high_quality is greater than or equal to 2.7
test_4 <- all(just_trump_high_quality$numeric_grade >= 2.7)
print(test_4)

# Check if pollscore in just_trump_high_quality is between -1.5 and -0.5
test_5 <- all(just_trump_high_quality$pollscore >= -1.5 & just_trump_high_quality$pollscore <= -0.5)
print(test_5)

# Check if transparency_score in just_trump_high_quality is less than or equal to 10
test_6 <- all(just_trump_high_quality$transparency_score <= 10)
print(test_6)

# Check if end_date in just_trump_high_quality is on or after 2024-07-21
test_7 <- all(just_trump_high_quality$end_date >= as.Date("2024-07-21"))
print(test_7)

# Check for NA values in each relevant column of just_trump_high_quality
test_pct <- !any(is.na(just_trump_high_quality$pct))
print(test_pct)  

test_transparency_score <- !any(is.na(just_trump_high_quality$transparency_score))
print(test_transparency_score)  

test_pollster <- !any(is.na(just_trump_high_quality$pollster))
print(test_pollster)  

test_pollscore <- !any(is.na(just_trump_high_quality$pollscore))
print(test_pollscore)  

test_numeric_grade <- !any(is.na(just_trump_high_quality$numeric_grade))
print(test_numeric_grade)  

test_end_date <- !any(is.na(just_trump_high_quality$end_date))
print(test_end_date)  

# Check if end_date in just_trump_high_quality has the correct date format
test_8 <- all(!is.na(as.Date(just_trump_high_quality$end_date, format="%Y-%m-%d")))
print(test_8)

# Check if just_harris_high_quality is a data frame
test_9 <- is.data.frame(just_harris_high_quality)
print(test_9)

# Check if just_harris_high_quality contains the required columns
test_10 <- all(c("candidate_name", "numeric_grade", "end_date", "pct", 
                 "sample_size", "pollscore", "transparency_score") %in% colnames(just_harris_high_quality))
print(test_10)

# Check if candidate_name in just_harris_high_quality is "Kamala Harris"
test_11 <- all(just_harris_high_quality$candidate_name == "Kamala Harris")
print(test_11)

# Check if numeric_grade in just_harris_high_quality is greater than or equal to 2.7
test_12 <- all(just_harris_high_quality$numeric_grade >= 2.7)
print(test_12)

# Check if pollscore in just_harris_high_quality is between -1.5 and -0.5
test_13 <- all(just_harris_high_quality$pollscore >= -1.5 & just_harris_high_quality$pollscore <= -0.5)
print(test_13)

# Check if transparency_score in just_harris_high_quality is less than or equal to 10
test_14 <- all(just_harris_high_quality$transparency_score <= 10)
print(test_14)

# Check if end_date in just_harris_high_quality is on or after 2024-07-21
test_15 <- all(just_harris_high_quality$end_date >= as.Date("2024-07-21"))
print(test_15)

# Check for NA values in each relevant column of just_harris_high_quality
test_pct_harris <- !any(is.na(just_harris_high_quality$pct))
print(test_pct_harris)  

test_transparency_score_harris <- !any(is.na(just_harris_high_quality$transparency_score))
print(test_transparency_score_harris)  

test_pollster_harris <- !any(is.na(just_harris_high_quality$pollster))
print(test_pollster_harris)  

test_pollscore_harris <- !any(is.na(just_harris_high_quality$pollscore))
print(test_pollscore_harris)  

test_numeric_grade_harris <- !any(is.na(just_harris_high_quality$numeric_grade))
print(test_numeric_grade_harris)  

test_end_date_harris <- !any(is.na(just_harris_high_quality$end_date))
print(test_end_date_harris)  

# Check if end_date in just_harris_high_quality has the correct date format
test_16 <- all(!is.na(as.Date(just_harris_high_quality$end_date, format="%Y-%m-%d")))
print(test_16)
