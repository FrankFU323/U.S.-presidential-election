#### Preamble ####
# Purpose: Tests the structure and validity of the simulated US president polls dataset.
# Author: Tianrui Fu & Yiyue Deng
# Date:  21 October 2024
# Contact: tianrui.fu@mail.utoronto.ca 
# License: MIT
# Pre-requisites: 
  # - The `tidyverse` package must be installed and loaded
  # - 00-simulate_data.R must have been run
# Any other information needed? Make sure we are in the `starter_folder` rproj


#### Workspace setup ####
library(tidyverse)

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

analysis_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Test if the data was successfully loaded
# Test 1: Check for any missing values (NA)
test_missing_values <- function(poll_data) {
  return(!any(is.na(poll_data)))
}
print(test_missing_values(poll_data))

# Test 2: Check if the transparency score is between 1 and 10
test_transparency_score <- function(poll_data) {
  return(all(poll_data$transparency_score >= 1 & poll_data$transparency_score <= 10))
}
print(test_transparency_score(poll_data))

# Test 3: Check if the pollster is from the pollster_list
test_pollster_list <- function(poll_data, pollsters) {
  return(all(poll_data$pollster %in% pollsters))
}
print(test_pollster_list(poll_data, pollsters))

# Test 4: Check if the candidate name is from candidate_list
test_candidate_list <- function(poll_data, candidates) {
  return(all(poll_data$candidate %in% candidates))
}
print(test_candidate_list(poll_data, candidates))

# Test 5: Check if the party is from party_list
test_party_list <- function(poll_data, parties) {
  return(all(poll_data$party %in% parties))
}
print(test_party_list(poll_data, parties))

# Test 6: Check if the start date is between 2024-01-01 and 2024-10-19
test_date_range <- function(poll_data) {
  return(all(poll_data$start_date >= as.Date("2024-01-01") & poll_data$start_date <= as.Date("2024-10-19")))
}
print(test_date_range(poll_data))

# Test 7: Check if the sum of probabilities for each pollster is less than 1
test_probabilities_sum <- function(poll_data) {
  prob_sums <- aggregate(probability ~ pollster, data = poll_data, sum)
  return(all(prob_sums$probability <= 1))
}
print(test_probabilities_sum(poll_data))

