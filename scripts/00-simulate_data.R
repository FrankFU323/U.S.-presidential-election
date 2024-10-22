#### Preamble ####
# Purpose: Simulates a dataset of US presidential election division, including the 
  #pollster, transparency score, state, start&end date, the party division and candidate name
  #with .
# Author: Tianrui Fu & Yiyue Deng
# Date: 21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)
library(dplyr)
set.seed(123)

#### Simulate data ####
pollsters <- c("TIPP", "ActiVote", "Bullfinch", "PPP", "Quantus Insights", 
               "RMG Research", "AtlasIntel", "Emerson", "OnMessage Inc.", 
               "YouGov", "Gateway Political Strategies", "InsiderAdvantage", 
               "Morning Consult", "Mitchell", "Patriot Polling", 
               "Redfield & Wilton Strategies", "Cygnal", "Beacon/Shaw", 
               "Quinnipiac", "SurveyUSA", "East Carolina University", 
               "Fairleigh Dickinson", "HarrisX/Harris Poll", "SoCal Strategies", 
               "Ipsos", "Trafalgar Group", "Elway", "HarrisX", "MRG (Marketing Resource Group)", 
               "Marist", "Siena/NYT", "UMass Amherst/YouGov", "American Pulse", 
               "University of Massachusetts Lowell/YouGov", "Marquette Law School", 
               "U. Houston", "Alaska Survey Research", "Fabrizio/McLaughlin", 
               "Yale Youth Poll", "co/efficient", "Torchlight Strategies", 
               "J.L. Partners", "Tarrance", "Hart/POS", "Change Research", 
               "Fabrizio/Impact", "Fabrizio/GBAO", "Targoz Market Research", 
               "Research Co.", "The Washington Post", "Hunt Research", 
               "Noble Predictive Insights", "Florida Atlantic University/Mainstreet Research", 
               "Arc Insights", "Pew", "Suffolk", "Big Village", "Glengariff Group Inc.", 
               "Mason-Dixon", "Christopher Newport U.", "Data for Progress", 
               "Impact Research", "St. Anselm", "YouGov/Center for Working Class Politics", 
               "UC Berkeley", "Susquehanna", "WPAi", "Leger", "HighGround", 
               "National Research", "Global Strategy Group/North Star Opinion Research", 
               "Winthrop U.", "High Point University", "UMBC", "McCourtney Institute/YouGov", 
               "Bowling Green State University/YouGov", "Lake Research", "Outward Intelligence", 
               "Echelon Insights", "ARW Strategies", "McLaughlin", "Victory Insights", 
               "CNN/SSRS", "Benenson Strategy Group/GS Strategy Group", 
               "Virginia Commonwealth U.", "USC Dornsife/CSU Long Beach/Cal Poly Pomona", 
               "Clarity", "University of Maryland/Washington Post", "Slingshot Strategies", 
               "Meredith College", "Embold Research", "Remington", "Muhlenberg", 
               "University of Delaware", "Texas Hispanic Policy Foundation", 
               "MassINC Polling Group", "Angus Reid", "U. New Hampshire", 
               "Capitol Weekly", "Siena", "Focaldata", "U. Georgia SPIA", 
               "Pan Atlantic Research", "Franklin and Marshall College", 
               "Keating Research", "Research & Polling", "Elon U.", 
               "Quantus Polls and News", "GQR", "Selzer", "Data Orbital", 
               "CWS Research", "Research America", "PPIC", "Washington Post/George Mason University", 
               "U. Rhode Island", "Hendrix College", "SurveyMonkey", "Kaiser Family Foundation", 
               "PRRI", "Big Data Poll", "Echelon Insights/GBAO", "SoonerPoll.com", 
               "Gonzales Research & Media Services", "Wick", "Global Strategy Group", 
               "Fabrizio/David Binder Research", "EPIC/MRA", "Z to A Research", 
               "Survey Center on American Life", "Cherry Communications", 
               "Kaplan Strategies", "SurveyUSA/High Point University", 
               "Fabrizio Ward", "BK Strategies", "Spry Strategies", "Roanoke College", 
               "University of Houston/Texas Southern University", "Strategies 360", 
               "YouGov Blue", "Navigator", "Peak Insights", "Iron Light", 
               "Fabrizio", "Trafalgar Group/InsiderAdvantage", "Civiqs", 
               "YouGov/SNF Agora", "Public Opinion Strategies", "U. North Florida", 
               "SoCal Research", "Hoffman Research", "North Star Opinion Research", 
               "Landmark Communications", "Praecones Analytica", "3W Insights", 
               "DHM Research", "Manhattan Institute", "Lord Ashcroft Polls", 
               "Bendixen & Amandi International", "PureSpectrum", 
               "Split Ticket/Data for Progress", "National Public Affairs", 
               "1983 Labs", "1892 Polling", "University of Texas at Tyler", 
               "P2 Insights", "Innovative Research Group", "SSRS", "The Tyson Group", 
               "KAConsulting LLC", "Prime Group", "Digital Research", 
               "Meeting Street Insights", "Faucheux Strategies", 
               "John Zogby Strategies", "Texas Lyceum", "Hart Research Associates", 
               "RABA Research", "UpOne Insights/BSG", "Split Ticket", 
               "New Bridge Strategy/Aspect Strategic", "St. Pete Polls", 
               "GS Strategy Group", "Axis Research", "Rasmussen", "The Citadel", 
               "Chism Strategies", "Dan Jones", "Target Insyght", "VCreek/AMG", 
               "Cygnal/Aspect Strategic", "Tulchin Research", "NORC", 
               "Abacus Data", "Let's Preserve the American Dream", 
               "Ohio Northern University Institute for Civics and Public Policy", 
               "Murphy Nasica & Associates", "Premise", "Zogby", 
               "Causeway Solutions", "Data Viewpoint", "Gravis Marketing (post 2020)", 
               "ABC/Washington Post", "Project Home Fire", "Cor Strategies", 
               "Schoen Cooperman", "Opinion Diagnostics", "VoteTXT", 
               "Metropolitan Research", "OH Predictive Insights / MBQF", 
               "Differentiators", "Blueprint Polling", "U. Massachusetts - Lowell", 
               "Benenson", "Florida Atlantic University", "Fleming & Associates", 
               "Probolsky Research", "PEM Management Corporation", 
               "Harris Poll", "NewsNation/Decision Desk HQ", 
               "The Political Matrix/The Listener Group", "Cor Services, Inc.")
# Candidate names
candidates <- c("Kamala Harris", "Donald Trump", "Jill Stein", "Chase Oliver", 
                "Cornel West", "Robert F. Kennedy", "Randall A. Terry", "Joseph Kishore",
                "Claudia De La Cruz", "Shiva Ayyadurai", "Joel Skousen", "JD Vance", 
                "Joe Biden", "Gavin Newsom", "Gretchen Whitmer", "Josh Shapiro", 
                "Pete Buttigieg", "Mark Kelly", "Roy A. Cooper", "Raphael Warnock", 
                "Michelle Obama", "J.B. Pritzker", "Bernie Sanders", "Hillary Rodham Clinton", 
                "Al Gore", "Elizabeth Ann Warren", "Andy Beshear", "Amy Klobuchar", 
                "Cory A. Booker", "Lars Mapstead", "Charles Ballay", "Taylor Swift", 
                "Kanye West", "Joe Manchin, III", "Nikki Haley", "Ron DeSantis", 
                "Dean Phillips", "Liz Cheney", "Mark Cuban", "Vivek G. Ramaswamy", 
                "Mike Pence", "Mitt Romney", "Tim Scott", "Glenn Youngkin", "Chris Christie", 
                "Larry Hogan", "Donald Trump Jr.", "Andy Cohen", "Chris Sununu", 
                "Marco Rubio", "Ted Cruz")

# Party names
parties <- c("DEM", "REP", "GRE", "LIB", "IND", "CON", "PSL", "UNK", "OTH")

# Function to generate poll data for each pollster
generate_poll_data <- function(pollster) {
  num_candidates <- sample(3:6, 1)  # Random number of candidates per pollster
  selected_candidates <- sample(candidates, num_candidates, replace = FALSE)
  selected_parties <- sample(parties, num_candidates, replace = TRUE)
  
  # Generate probabilities that sum to less than 1
  probs <- runif(num_candidates, min = 0.05, max = 0.3)
  probs <- probs / sum(probs)  # Normalize to sum exactly 1
  probs <- probs * runif(1, min = 0.8, max = 1)  # Scale it to be less than 1
  
  # Poll start date
  start_date <- sample(seq(as.Date("2024-01-01"), as.Date("2024-10-19"), by="day"), 1)
  
  # Transparency score
  transparency_score <- sample(1:10, 1)
  
  # Create data frame for the pollster
  data.frame(
    pollster = pollster,
    candidate = selected_candidates,
    party = selected_parties,
    probability = round(probs, 2),
    transparency_score = transparency_score,
    start_date = start_date
  )
}

# Apply function to all pollsters and combine the results
poll_data <- do.call(rbind, lapply(pollsters, generate_poll_data))

# View the first few rows of the simulated data
head(poll_data)


#### Save data ####
write_csv(poll_data, "data/00-simulated_data/simulated_data.csv")
