# 1.1 Load libraries and dataset paths
# All libraries required for the rest of the scripted are loaded here.

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

# 1.2.3 Home
Dataset_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset")
Dataset_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset")
Dataset_test_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/test")
Dataset_train_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/train")
Dataset_test_IntSig_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/test/Inertial Signals")
Dataset_train_IntSig_path <- c("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/UCI HAR Dataset/train/Inertial Signals")

# 1.3.2 Train files
setwd(Dataset_train_path)
x_train <- read.table("X_train.txt", colClasses="numeric")              # 7352 rows and 561 columns where each row identifies a statistical calculation
# and each column is the description of that calculation

subject_train <- read.table("subject_train.txt", colClasses="numeric")  # 7352 rows in one column where each row identifies
# the subject who performed the activity for each window sample. 
# The range is from 1 to 30

y_train <- read.table("y_train.txt", colClasses="numeric")              # 7352 rows in one column where each row identifies
# an activity. The range is from 1 to 6. 

# 1.3.3 Main files
setwd(Dataset_path)
features <- read.table("features.txt", check.names=FALSE)               # Two columns with 561 rows. The first column is numerical and the 
# second has the statistical calculation description

activity_label <- read.table("activity_labels.txt")                     # Two columns with six rows. The first column is numerical and the 
# second identifies an activity.

# 1.4 Create new vector names

# 1.4.1 Train
Train_Stats <- x_train
Train_Subjects <- subject_train
Train_Activity <- y_train
Stat_Names <- features
Position <- activity_label 


# 1.5 Convert to Stat_Names characters and add index suffix to  Stat_Names for a new column called Index_Stat_Name
Stat_Names$V2 <- as.character.factor(Stat_Names$V2)
Stat_Names_1 <- Stat_Names
Stat_Names_2 <- mutate (Stat_Names_1, concated_column = paste(V1, V2, sep = '_'))
colnames(Stat_Names_2) <- c("Index", "Stat_Name", "Index_Stat_Name")


# New Stuff

Train_Stats_10 <- x_train
Train_Stats_20 <- Train_Stats_10

colnames(Train_Stats_20) <- Stat_Names_2$Index_Stat_Name 

Train_Stats_20$"562_Activity" <- Train_Activity

Train_Stats_20$"563_Train_Subjects" <- Train_Subjects

Test_1 <- gather(Train_Stats_20,,1:563) 
        