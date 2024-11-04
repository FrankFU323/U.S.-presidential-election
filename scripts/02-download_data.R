#### Preamble ####
# Purpose: Downloads and saves the data from the website "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Author: Tianrui Fu & Yiyue Deng & Jianing Li
# Date:  21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca, yiyue.deng@mail.utoronto.ca & lijianing.li@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(tidyverse)

#### Download data ####
president_polls <- read_csv(file = "https://projects.fivethirtyeight.com/polls/data/president_polls.csv")

#### Save data ####
write_csv(president_polls, "data/01-raw_data/president_polls.csv") 

         
