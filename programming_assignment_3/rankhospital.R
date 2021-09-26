# Write a function called numhospital that takes three arguments: 
# the 2-character abbreviated name of a state (state), 
# an outcome (outcome), 
# and the numing of a hospital in that state for that outcome (num). 
# 
# The function reads the outcome-of-care-measures.csv file and returns a character vector 
# with the name of the hospital that has the numing specified by the num argument.
# 
# The num argument can take values “best”, “worst”, or an integer indicating the
# numing (smaller numbers are better). If the number given by num is larger
# than the number of hospitals in that state, then the function should return NA. 
#   
# Hospitals that do not have data on a particular outcome should be excluded 
# from the set of hospitals when deciding the numings.
# 


# Load packages
library(tidyverse)
library(datasets) 

valid_outcomes <- c("heart attack", "heart failure", "pneumonia")

rankhospital <- function(state, outcome, num = "best") { 
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv")
  
  ## Check that state and outcome are valid
  if(!(state %in% state.abb)) {stop("invalid state")}
  if(!(outcome %in% valid_outcomes)) {stop("invalid outcome")}
  
  ## Filter only valid data for outcome
  outcome_valid <- outcome_data %>% 
    select(2, 7, 11, 17, 23)
  outcome_valid[, 3] <- as.double(outcome_valid[, 3])
  outcome_valid[, 4] <- as.double(outcome_valid[, 4])
  outcome_valid[, 5] <- as.double(outcome_valid[, 5])
  
  ## Get only complete.cases
  # outcome_valid <- outcome_valid %>%
  #  na.omit
  
  # rename variables to be more accessible
  colnames(outcome_valid) <- c("Hospital", "State", "heart attack", 
                               "heart failure", "pneumonia")
  
  # subset data by state and outcome
 outcome_valid <- outcome_valid[outcome_valid$State == state & outcome_valid[outcome]   != "NA", ]
  
  ## Return hospital name in that state with the given num 
  ## 30-day death rate
  ## Order by outcome and hospital name
  outcome_valid <- outcome_valid[ order(outcome_valid[,outcome],outcome_valid$Hospital), ]
  # if else to give result by num
  if(num == "best") {hospital <- outcome_valid[1,"Hospital"]}
  else if(num == "worst") {hospital <- outcome_valid[nrow(outcome_valid),"Hospital"]}
  else {hospital <- outcome_valid[num,"Hospital"]}
  hospital
}
