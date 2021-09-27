# Write a function called rankall that takes two arguments: 
# an outcome name (outcome) and 
# a hospital ranking (num). 
# 
# The function reads the outcome-of-care-measures.csv file and returns a 2-column 
# data frame containing the hospital in each state that has the ranking specified 
# in num. 
# 
# For example the function call rankall("heart attack", "best") would return a 
# data frame containing the names of the hospitals that are the best in their 
# respective states for 30-day heart attack death rates. 
# 
# The function should return a value for every state (some may be NA).
# 
# The first column in the data frame is named hospital, which contains the hospital name, 
# and the second column is named state, which contains the 2-character abbreviation for 
# the state name. 
# 
# Hospitals that do not have data on a particular outcome should be excluded from 
# the set of hospitals when deciding the rankings.


# Handling ties. The rankall function should handle ties in the 30-day mortality 
# rates in the same way that the rankhospital function handles ties.

# Load packages
library(tidyverse)

valid_outcomes <- c("heart attack", "heart failure", "pneumonia")

rankall <- function(outcome, num = "best") { 
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that outcome are valid
  if(!(outcome %in% valid_outcomes)) {stop("invalid outcome")}
  
  ## Filter only valid data for outcome
  outcome_valid <- outcome_data %>% 
    select(2, 7, 11, 17, 23)
  outcome_valid[, 3] <- as.double(outcome_valid[, 3])
  outcome_valid[, 4] <- as.double(outcome_valid[, 4])
  outcome_valid[, 5] <- as.double(outcome_valid[, 5])
  
  ## Get only complete.cases
  #outcome_valid <- outcome_valid %>%
   # na.omit
  
  # rename variables to be more accessible
  colnames(outcome_valid) <- c("hospital.name", "state", "heart attack", 
                               "heart failure", "pneumonia")
  
  #filter by outcome
  outcome_valid <- outcome_valid[, c("hospital.name", "state", outcome)]
  
  # start variables for loop
  hospitals <- character(0)
  states <- character(0)
  outcomes <- double(0)
  
  for(state in unique(outcome_valid$state)){
    # Filter data by the state and only valid values
    state_data <- outcome_valid[outcome_valid$state == state & outcome_valid[outcome]    != "NA",]
    
    # Order the rows by the outcome column and then by hospital name
    state_data <- state_data[ order(state_data[,3],
                                    state_data$hospital.name), ]
    
    # Return data depending on the rank input
    if(num == "best") { hospital <- state_data[1,"hospital.name"] }
    else if(num == "worst") { hospital <- state_data[nrow(state_data),"hospital.name"] }
    else { hospital <- state_data[num,"hospital.name"] }
    
    hospitals <- c(hospitals,hospital)
    states <- c(states,state)
  }
  
  ranked_hospitals = data.frame(hospitals,states)
  ranked_hospitals <- ranked_hospitals[ order(ranked_hospitals$state) , ]
  names(ranked_hospitals) <- c("hospital.name","state")
  ranked_hospitals
}