## Week 3 Quiz
# @dillonchewwx, 26012021

setwd("D:/Online Courses/JHU Data Science/Getting and Cleaning Data/")

# Q1: The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv and load the data into R. The code book, describing the variable names is here: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 

# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE: which(agricultureLogical) 

# What are the first 3 values that result?

q1dat<-read_csv("getdata_data_ss06hid.csv")
which(q1dat$ACR==3 & q1dat$AGS==6) # 125, 238, 262

# Q2: Using the jpeg package read in the following picture of your instructor into R. https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg. Use the parameter native=TRUE. What are the 30th and 80th quantiles of the resulting data? (some Linux systems may produce an answer 638 different for the 30th quantile)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", destfile="getdata_jeff.jpg")
library(jpeg)
q2dat<-readJPEG("getdata_jeff.jpg", native=TRUE)
quantile(q2dat, probs=c(0.30, 0.80)) %>% print # -16776396  -3735553, option on coursera is -15259150 -10575416. 

# Q3: Load the Gross Domestic Product data for the 190 ranked countries in this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv. Load the educational data from this data set: https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv 

# Match the data based on the country shortcode. How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). What is the 13th country in the resulting data frame?

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", destfile="getdata_data_FGDP.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", destfile="getdata_data_FEDSTATS_Country.csv")

q3_FGDP<-read_csv("getdata_data_FGDP.csv")
q3_FEDSTATS<-read_csv("getdata_data_FEDSTATS_Country.csv")
colnames(q3_FGDP)[1]<-"CountryCode"
q3_df<-merge(q3_FGDP, q3_FEDSTATS, by="CountryCode") %>%
  mutate(`Gross domestic product 2012`=as.numeric(`Gross domestic product 2012`)) %>% 
  arrange(desc(`Gross domestic product 2012`)) # 189 matches, 13th country is St. Kitts and Nevis

# Question 4: What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?  

q4dat<-q3_df %>% 
  filter(!is.na(`Gross domestic product 2012`)) %>% 
  select(`Gross domestic product 2012`, `Income Group`) %>% 
  group_by(`Income Group`)

q4_df<- q4dat %>%
  summarise(mean(`Gross domestic product 2012`)) %>%
  print ## 33.0 and 91.9

# Question 5: Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group. How many countries are Lower middle income but among the 38 nations with highest GDP?

q5dat<-q4dat %>%
  filter(`Gross domestic product 2012`<=38) %>%
  summarise(n()) # 5
            