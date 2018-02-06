#0.0  Get the zip file and put it in the working directory
# NOTE: If you have the files, then you can skip this section and start with the script for question 1.

#0.1 Set the library and working directory for just this section.
# NOTE: My local drive path is not provided, rather the user shouldreplace the ",,,," in my path with their own path. 

library(httr)
setwd(",,,,")

#0.2 Get the zip file and put it in the working directory
response <- GET("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                write_disk("Week4.csv.zip"),
                progress()) ### NOTE: Neat little progress indicator


#0.3 Designate the zip files directory and the output directory and unzip the files
zipF<- ",,,,"
outDir<-",,,,"
unzip("Week4.csv.zip",exdir=outDir)

#====================================================================================================

# 1 Question 1: Merges the training and the test sets to create one data set.

# 1.1 Load libaries and dataset paths

# 1.1.2 All libraries required for the rest of the scripted are loaded here.

library(tibble)
library(RSQLite)
library(data.table)
library(sqldf)library(tibble)
library(RSQLite)
library(data.table)
library(sqldf)library(tidyr)

# 1.1.3 Paths are provide for consistency. My local drive path is not provided, rather the user should replace 
      # the "...." in this script with the directory where UCI HAR Dataset resides. 

#Final
Dataset_path <- c("..../UCI HAR Dataset")
Dataset_test_path <- c("..../UCI HAR Dataset/test")
Dataset_train_path <- c("..../UCI HAR Dataset/train")
Dataset_test_IntSig_path <- c("..../UCI HAR Dataset/test/Inertial Signals")
Dataset_train_IntSig_path <- c("..../UCI HAR Dataset/train/Inertial Signals")

#Work
Dataset_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset")
Dataset_test_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test")
Dataset_train_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train")
Dataset_test_IntSig_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test/Inertial Signals")
Dataset_train_IntSig_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train/Inertial Signals")

#Home
Dataset_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset")
Dataset_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset")
Dataset_test_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/test")
Dataset_train_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/train")
Dataset_test_IntSig_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/test/Inertial Signals")
Dataset_train_IntSig_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/train/Inertial Signals")

# 1.2 Pull the data from local drive and assign to datasets, assigning column names that shows the time sequence (1 through 128) of the observations
# that occur in 50Hz intervals.

# 1.2.1 Assign column names for all observations

Obs_Col_Names <-  c(paste0( rep("Obs", 128), 1:128))

# 1.1.3 Create datsets with columns names

# 1.1.3.1 Test observations

setwd(Dataset_test_IntSig_path)

# body_acc__test
body_acc_x_test_1 <- read.table("body_acc_x_test.txt", colClasses="numeric")
colnames(body_acc_x_test_1) <- Obs_Col_Names 
body_acc_y_test_1 <- read.table("body_acc_x_test.txt", colClasses="numeric")
colnames(body_acc_y_test_1) <- Obs_Col_Names
body_acc_z_test_1 <- read.table("body_acc_z_test.txt", colClasses="numeric")
colnames(body_acc_z_test_1) <- Obs_Col_Names

# body_gyro__test
body_gyro_x_test_1 <- read.table("body_gyro_x_test.txt", colClasses="numeric")
colnames(body_gyro_x_test_1) <- Obs_Col_Names 
body_gyro_y_test_1 <- read.table("body_gyro_x_test.txt", colClasses="numeric")
colnames(body_gyro_y_test_1) <- Obs_Col_Names
body_gyro_z_test_1 <- read.table("body_gyro_z_test.txt", colClasses="numeric")
colnames(body_gyro_z_test_1) <- Obs_Col_Names

# total_acc__test
total_acc_x_test_1 <- read.table("total_acc_x_test.txt", colClasses="numeric")
colnames(total_acc_x_test_1) <- Obs_Col_Names 
total_acc_y_test_1 <- read.table("total_acc_x_test.txt", colClasses="numeric")
colnames(total_acc_y_test_1) <- Obs_Col_Names
total_acc_z_test_1 <- read.table("total_acc_z_test.txt", colClasses="numeric")
colnames(total_acc_z_test_1) <- Obs_Col_Names

# 1.1.3.2 Train observations

setwd(Dataset_train_IntSig_path)

# body_acc__train
body_acc_x_train_1 <- read.table("body_acc_x_train.txt", colClasses="numeric")
colnames(body_acc_x_train_1) <- Obs_Col_Names 
body_acc_y_train_1 <- read.table("body_acc_x_train.txt", colClasses="numeric")
colnames(body_acc_y_train_1) <- Obs_Col_Names
body_acc_z_train_1 <- read.table("body_acc_z_train.txt", colClasses="numeric")
colnames(body_acc_z_train_1) <- Obs_Col_Names

# body_gyro__train
body_gyro_x_train_1 <- read.table("body_gyro_x_train.txt", colClasses="numeric")
colnames(body_gyro_x_train_1) <- Obs_Col_Names 
body_gyro_y_train_1 <- read.table("body_gyro_x_train.txt", colClasses="numeric")
colnames(body_gyro_y_train_1) <- Obs_Col_Names
body_gyro_z_train_1 <- read.table("body_gyro_z_train.txt", colClasses="numeric")
colnames(body_gyro_z_train_1) <- Obs_Col_Names

# total_acc__train
total_acc_x_train_1 <- read.table("total_acc_x_train.txt", colClasses="numeric")
colnames(total_acc_x_train_1) <- Obs_Col_Names 
total_acc_y_train_1 <- read.table("total_acc_x_train.txt", colClasses="numeric")
colnames(total_acc_y_train_1) <- Obs_Col_Names
total_acc_z_train_1 <- read.table("total_acc_z_train.txt", colClasses="numeric")
colnames(total_acc_z_train_1) <- Obs_Col_Names

# 1.1.3.3 Assign subject identifiers as Subject

# Test
setwd(Dataset_test_path)
y_test_1 <- read.table("y_test.txt")
colnames(y_test_1) <- c("Subject")   

# Train
setwd(Dataset_train_path)
y_train_1 <- read.table("y_train.txt")
colnames(y_train_1) <- c("Subject")   

# 1.3 Create dataset with observations and subject identifier for each set of observations

# body_acc__test
body_acc_x_test_T <- cbind(y_test_1,body_acc_x_test_1)
body_acc_y_test_T <- cbind(y_test_1,body_acc_y_test_1)
body_acc_z_test_T <- cbind(y_test_1,body_acc_z_test_1)

# body_gyro__test
body_gyro_x_test_T <- cbind(y_test_1,body_gyro_x_test_1)
body_gyro_y_test_T <- cbind(y_test_1,body_gyro_y_test_1)
body_gyro_z_test_T <- cbind(y_test_1,body_gyro_z_test_1)

# total_acc__test
total_acc_x_test_T <- cbind(y_test_1,total_acc_x_test_1)
total_acc_y_test_T <- cbind(y_test_1,total_acc_y_test_1)
total_acc_z_test_T <- cbind(y_test_1,total_acc_z_test_1)

# body_acc__train
body_acc_x_train_T <- cbind(y_train_1,body_acc_x_train_1)
body_acc_y_train_T <- cbind(y_train_1,body_acc_y_train_1)
body_acc_z_train_T <- cbind(y_train_1,body_acc_z_train_1)

# body_gyro__train
body_gyro_x_train_T <- cbind(y_train_1,body_gyro_x_train_1)
body_gyro_y_train_T <- cbind(y_train_1,body_gyro_y_train_1)
body_gyro_z_train_T <- cbind(y_train_1,body_gyro_z_train_1)

# total_acc__train
total_acc_x_train_T <- cbind(y_train_1,total_acc_x_train_1)
total_acc_y_train_T <- cbind(y_train_1,total_acc_y_train_1)
total_acc_z_train_T <- cbind(y_train_1,total_acc_z_train_1)      


# 1.4  Create  a single column of called ObservationType_IntertialSignals_Axis_ExperimentSet.
# The names are seperated by an underscore (_) that represents the data in the file name. 

# Observation_Type: either "Body" or "Total." 
# Intertial_Signals: "Acc" "Gyro."
# Axsis: "x", "y", or "z"
# Experiment_Set: "Train" or "Test"

body_acc_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_x_test")
body_acc_y_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_y_test")
body_acc_z_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_z_test")
body_gyro_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_x_test")
body_gyro_y_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_y_test")
body_gyro_z_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_z_test")
total_acc_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_x_test")
total_acc_y_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_y_test")
total_acc_z_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_z_test")
body_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_x_train")
body_acc_y_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_y_train")
body_acc_z_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_z_train")
body_gyro_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_x_train")
body_gyro_y_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_y_train")
body_gyro_z_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_z_train")
total_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_x_train")
total_acc_y_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_y_train")
total_acc_z_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_z_train")

#1.5  Initially tidying the datasets by using gather to put all obervations in one column

body_acc_x_test_T_2<-gather(body_acc_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_acc_y_test_T_2<-gather(body_acc_y_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_acc_z_test_T_2<-gather(body_acc_z_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_gyro_x_test_T_2<-gather(body_gyro_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_gyro_y_test_T_2<-gather(body_gyro_y_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_gyro_z_test_T_2<-gather(body_gyro_z_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
total_acc_x_test_T_2<-gather(total_acc_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
total_acc_y_test_T_2<-gather(total_acc_y_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
total_acc_z_test_T_2<-gather(total_acc_z_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_acc_x_train_T_2<-gather(body_acc_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_acc_y_train_T_2<-gather(body_acc_y_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_acc_z_train_T_2<-gather(body_acc_z_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_gyro_x_train_T_2<-gather(body_gyro_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_gyro_y_train_T_2<-gather(body_gyro_y_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
body_gyro_z_train_T_2<-gather(body_gyro_z_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
total_acc_x_train_T_2<-gather(total_acc_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
total_acc_y_train_T_2<-gather(total_acc_y_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
total_acc_z_train_T_2<-gather(total_acc_z_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)

# 1.6 Combine the test and train datasets into one file.

body_T <- rbind(body_acc_x_test_T_2, body_acc_y_test_T_2, body_acc_z_test_T_2, body_gyro_x_test_T_2, body_gyro_y_test_T_2, 
                body_gyro_z_test_T_2, total_acc_x_test_T_2, total_acc_y_test_T_2, total_acc_z_test_T_2,body_acc_x_train_T_2, 
                body_acc_y_train_T_2, body_acc_z_train_T_2, body_gyro_x_train_T_2, body_gyro_y_train_T_2, 
                body_gyro_z_train_T_2, total_acc_x_train_T_2, total_acc_y_train_T_2, total_acc_z_train_T_2)



str(body_T)
##code to seprate the columns later on...
##separate(body_acc_x_train_T,ObservationType_IntertialSignals_Axis_ExperimentSet, c("ObservationType", "IntertialSignals","Axis", "ExperimentSet"))