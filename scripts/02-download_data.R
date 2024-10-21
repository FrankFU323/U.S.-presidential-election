#### Preamble ####
# Purpose: Downloads and saves the data from the website "https://projects.fivethirtyeight.com/polls/president-general/2024/national/"
# Author: Tianrui Fu & Yiyue Deng
# Date:  21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(tidyverse)
# 

#### Download data ####
# [...ADD CODE HERE TO DOWNLOAD...]



#### Save data ####
# 
# change the_raw_data to whatever name you assigned when you downloaded it.
write_csv(the_raw_data, "inputs/data/raw_data.csv") 

         
