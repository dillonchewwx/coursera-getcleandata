## Week 4 Quiz
# @dillonchewwx, 26012021

setwd("D:/Online Courses/JHU Data Science/Getting and Cleaning Data/")

# Q1: The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv and load the data into R. The code book, describing the variable names is here:  https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf. Apply strsplit() to split all the names of the data frame on the characters "wgtp". What is the value of the 123 element of the resulting list?

library(tidyverse)
q1dat<-read_csv("getdata_data_ss06hid.csv")
strsplit(colnames(q1dat), "wgtp")[123] # "" "15"


# Q2: Load the Gross Domestic Product data for the 190 ranked countries in this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv. Remove the commas from the GDP numbers in millions of dollars and average them. What is the average? Original data sources: http://data.worldbank.org/data-catalog/GDP-ranking-table

q2dat<-read_csv("getdata_data_FGDP.csv")
gsub(",", "", q2dat$X5[1:219]) %>% as.numeric() %>% mean(na.rm=TRUE) # 377652.4

# Q3: In the data set from Question 2 what is a regular expression that would allow you to count the number of countries whose name begins with "United"? Assume that the variable with the country names in it is named countryNames. How many countries begin with United? 

grep("^United", q2dat$X4) # 3 Countries

# Q4: Load the Gross Domestic Product data for the 190 ranked countries in this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv. Load the educational data from this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv. Match the data based on the country shortcode. Of the countries for which the end of the fiscal year is available, how many end in June?

q4_FGDP<-read_csv("getdata_data_FGDP.csv")
q4_FEDSTATS<-read_csv("getdata_data_FEDSTATS_Country.csv")
colnames(q4_FGDP)[1]<-"CountryCode"
q4_df<-merge(q4_FGDP, q4_FEDSTATS, by="CountryCode")
grep("Fiscal year end: June", q4_df$`Special Notes`) # 13

# Q5: You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE. Use the following code to download data on Amazon's stock price and get the times the data was sampled.

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
sum(year(sampleTimes)==2012) # 250 values collected in 2012
sum(year(sampleTimes)==2012 & wday(sampleTimes, label=TRUE)=="Mon") # 47
