## Week 4

### Question 1
# The American Community Survey distributes downloadable data about United States 
# communities. Download the 2006 microdata survey about housing for the state of 
# Idaho using download.file() from here: 
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv

# and load the data into R. The code book, describing the variable names is here:
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(file.url, "./data/USCidaho.csv")
USCidaho <- read.csv("~/datasciencecoursera/data/USCidaho.csv")

# Apply strsplit() to split all the names of the data frame on the characters 
# "wgtp". What is the value of the 123 element of the resulting list?

splitNames <- strsplit(names(USCidaho), "wgtp")
splitNames[123]
# [1] ""   "15"


### Question 2
#Load the Gross Domestic Product data for the 190 ranked countries in this data 
#set: 
  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
#  
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(file.url, "./data/GDP.csv")
GDP <- read.csv("~/datasciencecoursera/data/GDP.csv")

#fix the dataset rows and columns
GDP <- GDP[-(1:4),-(6:10)]
GDP <- GDP[-(195:239),]

#Remove the commas from the GDP numbers in millions of dollars and average them.
# What is the average? 
  
#  Original data sources: 
  
#  http://data.worldbank.org/data-catalog/GDP-ranking-table 

GDP$X.3 <- gsub(",","",GDP$X.3)
mean(as.numeric(GDP$X.3), na.rm = TRUE)
# [1] 377652.4


## QUESTION 3
# In the data set from Question 2 what is a regular expression that would allow 
# you to count the number of countries whose name begins with "United"? Assume 
# that the variable with the country names in it is named GDP$X.2. How many 
# countries begin with United?


grep("*United",GDP$X.2, value = TRUE)
grep("United$",GDP$X.2, value = TRUE)
grep("^United",GDP$X.2, value = TRUE) # CORRECT ANSWER
grep("^United",GDP$X.2, value = TRUE)

## QUESTION 4
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(file.url, "./data/FEDSTATS.csv")
FEDSTATS <- read.csv("~/datasciencecoursera/data/FEDSTATS.csv")

# Match the data based on the country shortcode. Of the countries for which the 
# end of the fiscal year is available, how many end in June?
# Original data sources: 
# http://data.worldbank.org/data-catalog/GDP-ranking-table
# http://data.worldbank.org/data-catalog/ed-stats
library(dplyr)
GDP <- rename(GDP, CountryCode = CountryNames)
mergeSTATS <- merge(GDP, FEDSTATS, by = "CountryCode")
Special.Notes
length(grep("Fiscal year end: June", mergeSTATS$Special.Notes))
# [1] 13

## QUESTION 5
# You can use the quantmod (http://www.quantmod.com/) package to get historical 
# stock prices for publicly traded companies on the NASDAQ and NYSE. Use the 
# following code to download data on Amazon's stock price and get the times the 
# data was sampled.
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

# How many values were collected in 2012? How many values were collected on 
# Mondays in 2012?
library(lubridate)
in2012 <- grep("2012", sampleTimes, value = TRUE)
length(in2012)
# [1] 250
mondays <- format(as.Date(in2012), "%Y %m %a")
length(grep("Mon", mondays))
# [1] 47
