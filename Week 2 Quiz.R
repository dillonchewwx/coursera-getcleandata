## Week 1 Quiz
# @dillonchewwx, 24012021

# Q1: Register an application with the Github API here https://github.com/settings/applications. Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). Use this data to find the time that the datasharing repo was created. What time was it created?

# Follow this API tutorial: https://www.dataquest.io/blog/r-api-tutorial/

library(httr)
library(jsonlite)

q1res<-GET("https://api.github.com/users/jtleek/repos")
q1data=fromJSON(rawToChar(q1res$content))
q1data$created_at[which(q1data$name=="datasharing")] # 2013-11-07T13:25:07Z

# Q2: The sqldf package allows for execution of SQL commands on R data frames. We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. Download the American Community Survey data and load it into an R object called acs. https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv. Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

setwd("D:/Online Courses/JHU Data Science/Getting and Cleaning Data/")

library(sqldf)
library(tidyverse)

acs<-read_csv("getdata_data_ss06pid.csv")
q2df<-sqldf("select pwgtp1 from acs where AGEP<50")

# Q3: Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)

q3<-sqldf("select distinct AGEP from acs")

# Q4: How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: http://biostat.jhsph.edu/~jleek/contact.html. (Hint: the nchar() function in R may be helpful)

con<-url("http://biostat.jhsph.edu/~jleek/contact.html")
q4html<-readLines(con)
close(con)
nchar(q4html[c(10,20,30,100)]) # 45 31 7 25

# Q5: Read this data set into R and report the sum of the numbers in the fourth of the nine columns. https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for. Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for (Hint this is a fixed width file format)

q5data<-read_fwf("getdata_wksst8110.for", fwf_cols(Week=15, Nino1SST=4, b1=1, Nino1SSTA=3, b2=5, Nino2SST=4, b3=1, Nino2SSTA=3), skip=4)
sum(q5data$Nino2SST) # 32426.7


