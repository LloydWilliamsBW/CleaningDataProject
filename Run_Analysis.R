#' ---
#' title: "Cleaning Data Week 4 Assignment"
#' author: "LloydW"
#' date: "25/11/2019"
#' output: html_document
#' ---
#' 
## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

#' 
## ------------------------------------------------------------------------
library(tidyverse)

#' 
#' Read in the test and train data files.
#' 
## ------------------------------------------------------------------------
X_test <- read.table("H:/R/Training/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("H:/R/Training/UCI HAR Dataset/test/y_test.txt")
Body_acc_x_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")
Body_acc_y_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
Body_acc_z_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
Body_gyro_x_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
Body_gyro_y_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
Body_gyro_z_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")
Total_acc_x_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
Total_acc_y_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
Total_acc_z_test <- read.table("H:/R/Training/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
X_train <- read.table("H:/R/Training/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("H:/R/Training/UCI HAR Dataset/train/y_train.txt")
Body_acc_x_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
Body_acc_y_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")
Body_acc_z_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
Body_gyro_x_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
Body_gyro_y_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
Body_gyro_z_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")
Total_acc_x_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
Total_acc_y_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
Total_acc_z_train <- read.table("H:/R/Training/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

#' 
#' Read activity labels table
#' 
## ------------------------------------------------------------------------
ActivityLabels <- read.table("H:/R/Training/UCI HAR Dataset/activity_labels.txt")
ActivityLabels <- ActivityLabels %>% rename(Activity_Code = V1, Activity_Name = V2)
ActivityLabels

#' 
#' Read features table and give sensible column names
#' 
## ------------------------------------------------------------------------
Features <- read.table("H:/R/Training/UCI HAR Dataset/features.txt")
Features <- Features %>% rename(Feature_Code = V1, Feature_Names = V2) %>% mutate(Feature = make.names(Feature_Names)) %>% select(Feature_Code, Feature)
Features

#' 
#' Read subject data tables
#' 
## ------------------------------------------------------------------------
Subject_test <- read.table("H:/R/Training/UCI HAR Dataset/test/subject_test.txt")
Subject_train <- read.table("H:/R/Training/UCI HAR Dataset/train/subject_train.txt")

#' 
#' Rename columns in Subject_test and Y_test tables
#' 
## ------------------------------------------------------------------------
Subject_test <- Subject_test %>% rename(Subject = V1)
Y_test <- Y_test %>% rename(Activity = V1)

#' 
#' Rename V1, V2, ... in X_test with feature names
#' 
## ------------------------------------------------------------------------
colnames(X_test) <- Features$Feature
X_test

#' 
#' Bind subjects, activities and measurements
#' 
## ------------------------------------------------------------------------
Test_data <- cbind(Subject_test, Y_test, X_test) 
Test_data

#' 
#' Makes column names unique and keep only columns that are means or standard deviations
#' 
## ------------------------------------------------------------------------
colnames(Test_data) <- make.names(colnames(Test_data), unique = TRUE)
Test_data_final <- Test_data %>% select(Subject, Activity, matches("mean|std"), -contains("Freq"))
Test_data_final

#' 
#' Repeat same process for the train data
#' 
#' 
## ------------------------------------------------------------------------
Subject_train <- Subject_train %>% rename(Subject = V1)
Y_train <- Y_train %>% rename(Activity = V1)
colnames(X_train) <- Features$Feature
Train_data <- cbind(Subject_train_new, Y_train, X_train)
colnames(Train_data) <- make.names(colnames(Train_data), unique = TRUE)
Train_data_final <- Train_data %>% select(Subject, Activity, matches("mean|std"), -contains("Freq"))
Train_data_final

#' 
#' Combine test and train tables
#' 
## ------------------------------------------------------------------------
Data_final <- rbind(Test_data_final, Train_data_final)

#' 
#' Calculate means for each person and activity
#' 
## ------------------------------------------------------------------------
Summarised_by_mean <- Data_final %>% group_by(Subject, Activity) %>% summarise_all(funs(mean))
Summarised_by_mean

#' 
#' Export as text file
#' 
## ------------------------------------------------------------------------
Summarised_by_mean %>% write.table("Summarised_by_mean.txt", row.name=FALSE)

#' 
#' 
#' 
#' 
#' 
