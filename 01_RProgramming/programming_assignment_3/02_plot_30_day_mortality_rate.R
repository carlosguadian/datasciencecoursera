# Read outcome data
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

# Look the first rows
head(outcome)

# Maybe is better use str() in order to know the number of columns, rows, names of
# variables
ncol(outcome) #number of columns
nrow(outcome) #number of rows
names(outcome) #name of variables

# all in one
str(outcome)

# Histogram of 30 day deaths rates from heart attack
# Without assign new variable
outcome[, 11] <- as.double(outcome[, 11])
hist(outcome[, 11])

# With new variable
death_rates_30 <- as.numeric(outcome[, 11])
hist(death_rates_30)

# Because we originally read the data in as character (by specifying 
# colClasses = "character" we need to coerce the column to be numeric.