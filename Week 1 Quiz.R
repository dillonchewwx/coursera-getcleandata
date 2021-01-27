## Week 1 Quiz
# @dillonchewwx, 23012021

library(data.table)
library(readxl)
library(tidyverse)
library(xml2)

setwd("D:/Online Courses/JHU Data Science/Getting and Cleaning Data/")
q1data<-read_csv(file = "getdata_data_ss06hid.csv")

# Q1: How many properties are worth > $1,000,000?

which(as.numeric(q1data$VAL) >=24) %>% length() # 53

# Q2: Consider the variable FES in the code book. Which of the "tidy data" principles does this variable violate? 
# Tidy data has one variable per column

# Q3: Download the Excel spreadsheet on Natural Gas Aquisition Program here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx. Read rows 18-23 and columns 7-15 into R and assign the result to a variable called: dat. What is the value of: sum(dat$Zip*dat$Ext,na.rm=T)

dat<-read_excel("getdata_data_DATA.gov_NGAP.xlsx", range="G18:O23", col_names =TRUE) 
sum(dat$Zip*dat$Ext,na.rm=T) # 36534720

# Q4: Read the XML data on Baltimore restaurants from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml. How many restaurants have zipcode 21231? 
q4data<-read_xml("getdata_data_restaurants.xml")
q4zipcode<-xml_find_all(q4data, ".//zipcode")
q4zipcodedata<-xml_text(q4zipcode)
sum(q4zipcodedata=="21231") # 127

# Q5: The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv. Using the fread() command load the data into an R object: DT. The following are ways to calculate the average value of the variable: pwgtp15 broken down by sex. Using the data.table package, which will deliver the fastest user time? 

DT=fread(file="getdata_data_ss06pid.csv")
ptm<-proc.time()
DT[,mean(pwgtp15),by=SEX] # This is fastest.
proc.time()-ptm
