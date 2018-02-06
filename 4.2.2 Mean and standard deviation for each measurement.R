#2.Extracts only the measurements on the mean and standard deviation for each measurement.

# 2.1 Load libaries (this is repeated from #1)
library(tibble)
library(RSQLite)
library(data.table)
library(sqldf)

# 2.2 Pull the data and assign to datasets




setwd("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train")
x_train_1 <- read.table("x_train.txt")

setwd("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test")
x_test_1 <- read.table("x_test.txt")

setwd("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset")
features_1 <- read.table("features.txt")

# 2.3 Assign column names to the x_train and x_test data
  #NOTE: This assumes that the 561 columns in the x train table corresponds to the V2 column in features.

colnames(x_train_1) <-  features_1[,2]
colnames(x_test_1) <-  features_1[,2]

# 2.4 Use SQLDF to determine the columns with mean or standard deviation (std) in them.
  
features_2 <- data.frame(features_1)
features_3 <- sqldf("select * from features_2 WHERE V2 like '%std%' OR V2 like '%mean%'")

# 2.5 Extract only the columns from x_train and x_test with mean or standard deviation.
  #Designate a column of Experiment_Set which is either the "Train" or "Test" set.

x_train_feature <- x_train_1[,features_3$V1]
x_train_feature$Experiment_Set <- "Train"

x_test_feature <- x_test_1[,features_3$V1]
x_test_feature$Experiment_Set <- "Test"

# 2.6 Consolidate the Test and Train data sets, tidy the data so there is one observation in each row

x_test_Cons <- rbind(x_test_feature,x_train_feature)
x_test_Tidy <- arrange(gather(x_test_Cons,Measurement_Type,Statistic,-Experiment_Set),Measurement_Type,Experiment_Set)

# 2.7 Print the result
x_test_Tidy




