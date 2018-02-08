#0.0  Get the zip file and put it in the working directory
# NOTE: If you have the files, then you can skip this section and start with the script for question 1.

#0.1 Set the library and working directory for just this section.
# NOTE: My local drive path is not provided, rather the user should replace the ",,,," in my path with their own path. 

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
#     All libraries required for the rest of the scripted are loaded here.

library(httr)
library(tibble)
library(RSQLite)
library(data.table)
library(sqldf)library(tibble)
library(RSQLite)
library(data.table)
library(sqldf)
library(tidyr)
library(dplyr)

# 1.2 Paths are provide for consistency. My local drive path is not provided, rather the user should replace 
# the "...." in this script with the directory where UCI HAR Dataset resides. 

# 1.2.1 Final
  Dataset_path <- c("..../UCI HAR Dataset")
  Dataset_test_path <- c("..../UCI HAR Dataset/test")
  Dataset_train_path <- c("..../UCI HAR Dataset/train")
  Dataset_test_IntSig_path <- c("..../UCI HAR Dataset/test/Inertial Signals")
  Dataset_train_IntSig_path <- c("..../UCI HAR Dataset/train/Inertial Signals")
  
# 1.2.2 Work
  Dataset_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset")
  Dataset_test_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test")
  Dataset_train_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train")
  Dataset_test_IntSig_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test/Inertial Signals")
  Dataset_train_IntSig_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train/Inertial Signals")
  
# 1.2.3 Home
  Dataset_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset")
  Dataset_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset")
  Dataset_test_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/test")
  Dataset_train_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/train")
  Dataset_test_IntSig_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/test/Inertial Signals")
  Dataset_train_IntSig_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/train/Inertial Signals")

# 1.3 Pull the data from local drive and assign to datasets

# 1.3.1 Test files
  setwd(Dataset_test_path)
  x_test <- read.table("X_test.txt", colClasses="numeric") # 2947 rows and 561 columns
  subject_test <- read.table("subject_test.txt", colClasses="numeric") # 2947 rows in one column where 
  # each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  y_test <- read.table("y_test.txt", colClasses="numeric") # 2947 rows in one column where each row identifies an activity.
  
# 1.3.2 Train files
  setwd(Dataset_train_path)
  x_train <- read.table("X_train.txt", colClasses="numeric") # 7352 rows and 561 columns
  subject_train <- read.table("subject_train.txt", colClasses="numeric") # 7352 rows in one column where
  # each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
  y_train <- read.table("y_train.txt", colClasses="numeric") # 7352 rows in one column where each row identifies an activity
                                                             # numbered from 1 to 6
  
# 1.3.3 Main files
  setwd(Dataset_path)
  features <- read.table("features.txt", check.names=FALSE) # 561 stats
  activity_label <- read.table("activity_labels.txt") # Each row identifies an activity numbered from 1 to 6

# 1.4 Create new vector names
  
# 1.4.1 Train
  Train_Stats <- x_train
  Train_Subjects <- subject_train
  Train_Activity <- y_train
  Stat_Names <- features
  Position <- activity_label 

# 1.4.2 Test
  Test_Stats <- x_test
  Test_Subjects <- subject_test
  Test_Activity <- y_test
  Stat_Names <- features
  Position <- activity_label 
  
# 1.5 Convert to Stat_Names characters and add index suffix to  Stat_Names for a new columen called Index_Stat_Name
  Stat_Names$V2 <- as.character.factor(Stat_Names$V2)
  Stat_Names_1 <- Stat_Names
  Stat_Names_2 <- mutate (Stat_Names_1, concated_column = paste(V1, V2, sep = '_'))
  colnames(Stat_Names_2) <- c("Index", "Stat_Name", "Index_Stat_Name")
 
# 1.6 Make the header of Train_Stats as Index_Stat_Name and then put the Stats column names into rows while maintaining the index

# 1.6.1 Train
  colnames(Train_Stats) <- Stat_Names_2$Index_Stat_Name
  Train_Stats_2 <- Train_Stats %>%
    gather( Stat_Names,Statistics,1:561) %>%
    separate(Stat_Names, sep = "_", c("Stat", "Names"))
  colnames(Train_Stats_2) <- c("Stat_Names_Index", "Stat_Names", "Statistics")

# 1.6.2 Test
  colnames(Test_Stats) <- Stat_Names_2$Index_Stat_Name
  Test_Stats_2 <- Test_Stats %>%
    gather( Stat_Names,Statistics,1:561) %>%
    separate(Stat_Names, sep = "_", c("Stat", "Names"))
  colnames(Test_Stats_2) <- c("Stat_Names_Index", "Stat_Names", "Statistics")
  
# 1.7 Create common names and merge the other columns

# 1.7.1 Train
  Stat_Names_Index <- c(1:7352) # sequential index for matching 
  Train_Subjects_1 <- Train_Subjects
  Train_Subjects_1$Stat_Names_Index <- Stat_Names_Index
  colnames(Train_Subjects_1) <- c("Subject_Nbrs", "Stat_Names_Index")
  Train_Stats_3 <- merge(Train_Stats_2,Train_Subjects_1,"Stat_Names_Index")
  colnames(Train_Subjects_1) <- c("Activity_Nbrs", "Stat_Names_Index")
  Positon_1 <- Position
  colnames(Positon_1) <- c("Activity_Nbrs", "Activity")
  Train_Activity_2 <-  merge(Train_Subjects_1 ,Positon_1,"Activity_Nbrs")
  Train_Stats_4 <- merge(Train_Stats_3,Train_Activity_2,"Stat_Names_Index")

# 1.7.2 Test  
  Stat_Names_Index <- c(1:2947) # sequential index for matching 
  Test_Subjects_1 <- Test_Subjects
  Test_Subjects_1$Stat_Names_Index <- Stat_Names_Index
  colnames(Test_Subjects_1) <- c("Subject_Nbrs", "Stat_Names_Index")
  Test_Stats_3 <- merge(Test_Stats_2,Test_Subjects_1,"Stat_Names_Index")
  colnames(Test_Subjects_1) <- c("Activity_Nbrs", "Stat_Names_Index")
  Positon_1 <- Position
  colnames(Positon_1) <- c("Activity_Nbrs", "Activity")
  Test_Activity_2 <-  merge(Test_Subjects_1 ,Positon_1,"Activity_Nbrs")
  Test_Stats_4 <- merge(Test_Stats_3,Test_Activity_2,"Stat_Names_Index") 
  
# 1.8 Clean up columns

# 1.8.1 Train
  Train_Stats_5 <- Train_Stats_4
  Train_Stats_5$Stat_Names_Index <- NULL # I dropped this becaue ther is not a join with the test set, rather an append
  Train_Stats_5$Activity_Nbrs <- NULL
  Train_Stats_5$Experiment_Set <- c("Train") #Experiment_Set is either the "Train" or "Test" set

# 1.8.1 Test
  Test_Stats_5 <- Test_Stats_4
  Test_Stats_5$Stat_Names_Index <- NULL # I dropped this becaue ther is not a join with the test set, rather an append
  Test_Stats_5$Activity_Nbrs <- NULL
  Test_Stats_5$Experiment_Set <- c("Test") #Experiment_Set is either the "Test" or "Test" set

# 1.9 Bring both data sets together
  
Stats_6 <- rbind(Train_Stats_5, Test_Stats_5 )  

# 2.0 Extracts only the measurements on the mean and standard deviation for each measurement.

Stats_Mn_Std_1 <- sqldf("select * from Stats_6 WHERE Stat_Names like '%std%' OR Stat_Names  like '%mean%'")

# 3.0 Uses descriptive activity names to name the activities in the data set
Stats_Mn_Std_1$Stat_Names

# Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
# [1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on 
# Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living 
# (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
# Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.


# What are the names?
unique(Stats_Mn_Std_1$Stat_Names)

# What are the stats?
Intital_Mean <- aggregate(Stats_Mn_Std_1$Statistics, list(Stats_Mn_Std_1$Stat_Names), mean )
