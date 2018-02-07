
#Test files
setwd(Dataset_test_path)
x_test <- read.table("X_test.txt", colClasses="numeric") # 2947 rows and 561 columns
subject_test <- read.table("subject_test.txt", colClasses="numeric") # 2947 rows in one column where 
  # each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
y_test <- read.table("y_test.txt", colClasses="numeric") # 2947 rows in one column where each row identifies an activity.

#Train files
setwd(Dataset_train_path)
x_train <- read.table("X_train.txt", colClasses="numeric") # 7352 rows and 561 columns
subject_train <- read.table("subject_train.txt", colClasses="numeric") # 7352 rows in one column where
  # each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
y_train <- read.table("y_train.txt", colClasses="numeric") # 7352 rows in one column where each row identifies an activity
                                                           # numbered from 1 to 6
#Main files

setwd(Dataset_path)
features <- read.table("features.txt", check.names=FALSE) # 561 stats
activity_label <- read.table("activity_labels.txt") # Each row identifies an activity numbered from 1 to 6

# New vector names
Train_Stats <- x_train
Train_Subjects <- subject_train
Train_Activity <- y_train
Stat_Names <- features
Position <- activity_label 

tail(Stat_Names) # this is still giving 561 obs V2: Factor w/ 477 levels


#Assign column names
colnames(Train_Stats) <- c(1:561)
colnames(Train_Subjects) <- c("Train_Subjects")
colnames(Train_Stats) <- c("Train_Stats")

# Index the files to keep the order
Train_Stats$Index <- c(1:7352)
Train_Subjects$Index <- c(1:7352)
Train_Activity$Index <- c(1:7352)
Stat_Names$Index <- c(1:561)

# Consolidate works, but you wnat he index column first (named that way) and sorted

Merge_Train <- merge(Train_Stats,Train_Activity,by ="Index")
arrange(Merge_Train,Index)


