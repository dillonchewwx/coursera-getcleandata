## Course Project
# @dillonchewwx, 27012021

## You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(tidyverse)

datawd<-"D:/Online Courses/JHU Data Science/Getting and Cleaning Data/UCI HAR Dataset/"
test<-read_csv()