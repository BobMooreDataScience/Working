# 0.0  Get the zip file and put it in the working directory
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

# 1.2 Paths are provided for consistency. My local drive path is not provided, rather the user should replace 
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
x_test <- read.table("X_test.txt", colClasses="numeric")                # 2947 rows and 561 columns where each row identifies a statistical calculation
                                                                        # and each column is the description of that calculation

subject_test <- read.table("subject_test.txt", colClasses="numeric")    # 2947 rows in one column where each row identifies
                                                                        # the subject who performed the activity for each window sample. 
                                                                        # Contains the numbers 2, 4, 9,10, 12, 13, 18, 20, and 24. 

y_test <- read.table("y_test.txt", colClasses="numeric")                # 2947 rows in one column where each row identifies
                                                                        # an activity. Contains the numbers 1,  3,  5,  6,  7,  8, 11,
                                                                        # 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, and 30. 

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

# 1.4.2 Test
Test_Stats <- x_test
Test_Subjects <- subject_test
Test_Activity <- y_test
Stat_Names <- features
Position <- activity_label 

# 1.5 Convert to Stat_Names characters and add index suffix to  Stat_Names for a new column called Index_Stat_Name
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

# 1.7  Add the subject numbers to the Test and Training datasets

#_________________________________ERROR__________________________________________________________
# 1.7.1 Train
Stat_Names_Index_Train <- c(1:7352) # Sequential index vector for matching the Train dataset
Train_Subjects_1 <- Train_Subjects
Train_Subjects_1$Stat_Names_Index <- Stat_Names_Index_Train # Column with the index for the subjects
colnames(Train_Subjects_1) <- c("Subject_Nbrs", "Stat_Names_Index") # Column with the index
Train_Stats_3 <- merge(Train_Stats_2,Train_Subjects_1,"Stat_Names_Index") # Merge Stats with Subjects on the index

Train_Activity_1 <- Train_Activity 
Train_Activity_1$Stat_Names_Index <- Stat_Names_Index_Train 
colnames(Train_Activity_1) <- c("Activity_Nbrs", "Stat_Names_Index") # Column with the index for the activities
Train_Stats_4 <- merge(Train_Stats_3,Train_Activity_1,"Stat_Names_Index") # Merge Stats and Subjects with activities on the index

# 1.7.2 Test
Stat_Names_Index_Test <- c(1:2947) # Sequential index vector for matching the Test dataset
Test_Subjects_1 <- Test_Subjects
Test_Subjects_1$Stat_Names_Index <- Stat_Names_Index_Test # Column with the index for the subjects
colnames(Test_Subjects_1) <- c("Subject_Nbrs", "Stat_Names_Index") # Column with the index
Test_Stats_3 <- merge(Test_Stats_2,Test_Subjects_1,"Stat_Names_Index") # Merge Stats with Subjects on the index

Test_Activity_1 <- Test_Activity 
Test_Activity_1$Stat_Names_Index <- Stat_Names_Index_Test 
colnames(Test_Activity_1) <- c("Activity_Nbrs", "Stat_Names_Index") # Column with the index for the actvities
Test_Stats_4 <- merge(Test_Stats_3,Test_Activity_1,"Stat_Names_Index") # Merge Stats and Subjects with acitivities on the index

# 1.8 Clean up columns

# 1.8.1 Train
Train_Stats_5 <- Train_Stats_4
Train_Stats_5$Stat_Names_Index <- NULL          # No longer required.
Train_Stats_5$Experiment_Set <- c("Train")      # Designate the dataset as "Train" to later differentiate  it from "Test."

# 1.8.1 Test
Test_Stats_5 <- Test_Stats_4
Test_Stats_5$Stat_Names_Index <- NULL           # No longer required.
Test_Stats_5$Experiment_Set <- c("Test")        # Designate the dataset as "Test" to later differentiate  it from "Train."

# 1.9 Merge Training and Test datasets and view. Last item with the answer to question 1.

Combined_Stats_1 <- rbind(Train_Stats_5, Test_Stats_5 )  
View(Combined_Stats_1)

#====================================================================================================

# 2.0 Extracts only the measurements on the mean and standard deviation for each measurement.

    # I determined from looking at the measurement rows to choose every word that could represent 
    # the Mean and/or Standard Deviation. Mean was represented as spelled and I found "std" which
    # is the abbreviation  for standard deviation. The view command allows the user to see the result 
    # and the next command shows distinct mean and standard deviation measurements.

Mean_Std_Stats_1 <- sqldf("select * from Combined_Stats_1 WHERE Stat_Names like '%std%' OR Stat_Names  like '%mean%'")
View(Mean_Std_Stats_1)
unique(Mean_Std_Stats_1$Stat_Names)

#====================================================================================================

# 3.0 Uses descriptive activity names to name the activities in the data set

        # I assume that since the assignment is numbered that it is sequential; therefore, the dataset referred to 
        # in Question 3 is the one in Question 2, i.e. "...only the measurements on the mean and standard deviation 
        # for each measurement." View command allows you to look at the result.

Positon_1 <- Position
colnames(Positon_1) <- c("Activity_Nbrs", "Activity")                   # Name the columns for merging with Mean_Std_Stats_1
Mean_Std_Stats_2 <-  merge(Positon_1,Mean_Std_Stats_1, "Activity_Nbrs") 
Mean_Std_Stats_3 <- Mean_Std_Stats_2
Mean_Std_Stats_3$Activity_Nbrs <- NULL                                  # No longer required.
View(Mean_Std_Stats_3)

#====================================================================================================

# 4.0 Appropriately labels the data set with descriptive variable names.  The data set was labeled in the questions above  
# and is summarized below. Detail is covered in the Codebook.

#====================================================================================================

# 5.0 From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject. The actual text file is labeled "Activity Mean by Subject.txt."
# The code to create and extract the file is provided here:

#This works, but it show subject only are 4 epopl. not 30!!!
aggdata <-aggregate(Mean_Std_Stats_2$Statistics, list(Subject = Mean_Std_Stats_2$Subject_Nbrs), mean)

unique( Mean_Std_Stats_3$Subject_Nbrs)

