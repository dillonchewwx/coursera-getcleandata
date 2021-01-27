## Course Project
# @dillonchewwx, 27012021

## The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

## You should create one R script called run_analysis.R that does the following. 
# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(tidyverse)

datawd<-"D:/Online Courses/JHU Data Science/Getting and Cleaning Data/UCI HAR Dataset/"

# Merge the training and the test sets to create one data set.
subject_test<-read_table(paste0(datawd, "test/subject_test.txt"), col_names=FALSE)
subject_train<-read_table(paste0(datawd, "train/subject_train.txt"), col_names=FALSE)
X_test<-read_table(paste0(datawd, "test/X_test.txt"), col_names=FALSE)
X_train<-read_table(paste0(datawd, "train/X_train.txt"), col_names=FALSE)
y_test<-read_table(paste0(datawd, "test/y_test.txt"), col_names=FALSE)
y_train<-read_table(paste0(datawd, "train/y_train.txt"), col_names=FALSE)

train_df<-bind_cols(subject_train, y_train, X_train)
test_df<-bind_cols(subject_test, y_test, X_test)
part1_df<-bind_rows(train_df, test_df)

# Extracts only the measurements on the mean and standard deviation for each measurement.
features<-read_table(paste0(datawd, "features.txt"), col_names=FALSE)
selected_features<-grep("mean\\(\\)|std\\(\\)", features$X1)
part2_df<-part1_df %>% 
  select(1:2, selected_features+2)

# Uses descriptive activity names to name the activities in the data set
activity<-read_table(paste0(datawd, "activity_labels.txt"), col_names=FALSE)
part3_df<-part2_df %>%
  rename(Subject_ID=X1...1, Activity=X1...2) %>%
  mutate(Activity=factor(Activity, activity$X1, activity$X2))

# Appropriately labels the data set with descriptive variable names. 
cleaned_features<-features %>%
  mutate(X1=word(X1, 2, sep=' ')) %>% 
  slice(selected_features)
part4_df<-part3_df %>%
  rename_with(~cleaned_features$X1, .cols=3:ncol(.))

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
part5_df<-part4_df %>%
  group_by(Subject_ID, Activity) %>%
  summarise(across(where(is.numeric), mean))

write.table(part5_df, file="tidydata.txt", row.names=FALSE)
