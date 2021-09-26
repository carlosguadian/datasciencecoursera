# Write a function called best that take two arguments: the 2-character abbreviated 
# name of a state and an outcome name. 
# 
# The function reads the outcome-of-care-measures.csv file and returns a character 
# vector with the name of the hospital that has the best (i.e. lowest) 30-day 
# mortality for the specified outcome in that state. 
# 
# The hospital name is the name provided in the Hospital.Name variable. 
# 
# The outcomes can be one of “heart attack”, “heart failure”, or “pneumonia”. 
# 
# Hospitals that do not have data on a particular outcome should be excluded from 
# the set of hospitals when deciding the rankings.
# 
# HANDLING TIES 
# If there is a tie for the best hospital for a given outcome, then the hospital 
# names should be sorted in alphabetical order and the first hospital in that set 
# should be chosen (i.e. if hospitals “b”, “c”, and “f” are tied for best, then 
# hospital “b” should be returned).
# 
# The function should use the following template.
# 
# Load packages
library(tidyverse)
library(datasets) 

valid_outcomes <- c("heart attack", "heart failure", "pneumonia")

best <- function(state, outcome) {
  ## Read outcome data
  outcome_data <- read.csv("outcome-of-care-measures.csv")

  ## Check that state and outcome are valid
  if(!(state %in% state.abb)) {stop("invalid state")}
  if(!(outcome %in% valid_outcomes)) {stop("invalid outcome")}
  
  ## Filter only valid data for outcome
  outcome_valid <- outcome_data %>% 
    select(2, 7, 13, 19, 25)
  outcome_valid[, 3] <- as.double(outcome_valid[, 3])
  outcome_valid[, 4] <- as.double(outcome_valid[, 4])
  outcome_valid[, 5] <- as.double(outcome_valid[, 5])
  
  ## Get only complete.cases
  # outcome_valid <- outcome_valid %>%
  #  na.omit
  
  # rename variables to be more accessible
  colnames(outcome_valid) <- c("Hospital", "State", "heart attack", 
                               "heart failure", "pneumonia")
  
  ## Return hospital name in that state with lowest 30-day death rate
  hospital <- outcome_valid[outcome_valid$State == state & outcome_valid[outcome]  != "NA", ]
  hospital <- hospital[which.min(hospital[ ,outcome]), ]
  hospital_name <- hospital[ ,"Hospital"]
  hospital_name
  }