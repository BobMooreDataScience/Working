# 1 Merges the training and the test sets to create one data set.

# 1.1 Load libaries and dataset paths

  # 1.1.2 All libraries are loaded here and referenced throughout the script.
  
  library(tibble)
  library(RSQLite)
  library(data.table)
  library(sqldf)library(tibble)
  library(RSQLite)
  library(data.table)
  library(sqldf)library(tidyr)

# 1.1.3 Paths are provide for consisitency. Assume that the user has alreadt unzipped the files and put them on the local drive
      # under the folder UCI HAR Dataset, so the user only needs to replace the "..." in my path with their own path. All paths 
      # are created here and referenced throughout the script.

  Dataset_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset")
  Dataset_test_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test")
  Dataset_train_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train")
  Dataset_test_IntSig_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/test/Inertial Signals")
  Dataset_train_IntSig_path <- c("C:/Users/411647/Desktop/r Programming/Coursera/Homework Week 4/UCI HAR Dataset/train/Inertial Signals")



# 1.2 Pull the data and assign to datasets, assigning column names that shows the time sequence (1 through 128) of the observations
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
      body_acc_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_x_test")
      body_acc_z_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_z_test")
      body_gyro_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_x_test")
      body_gyro_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_x_test")
      body_gyro_z_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_z_test")
      total_acc_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_x_test")
      total_acc_x_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_x_test")
      total_acc_z_test_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_z_test")
      body_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_x_train")
      body_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_x_train")
      body_acc_z_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_acc_z_train")
      body_gyro_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_x_train")
      body_gyro_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_x_train")
      body_gyro_z_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("body_gyro_z_train")
      total_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_x_train")
      total_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_x_train")
      total_acc_z_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet<-c("total_acc_z_train")
      
#1.5  Tidy the datasets 
      
      ###STOPP STOP STOP
      ###STOPP STOP STOP
      
      #and combine    

      body_acc_x_test_T_2<-gather(body_acc_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_acc_x_test_T_2<-gather(body_acc_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_acc_z_test_T_2<-gather(body_acc_z_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_gyro_x_test_T_2<-gather(body_gyro_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_gyro_x_test_T_2<-gather(body_gyro_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_gyro_z_test_T_2<-gather(body_gyro_z_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      total_acc_x_test_T_2<-gather(total_acc_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      total_acc_x_test_T_2<-gather(total_acc_x_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      total_acc_z_test_T_2<-gather(total_acc_z_test_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_acc_x_train_T_2<-gather(body_acc_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_acc_x_train_T_2<-gather(body_acc_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_acc_z_train_T_2<-gather(body_acc_z_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_gyro_x_train_T_2<-gather(body_gyro_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_gyro_x_train_T_2<-gather(body_gyro_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      body_gyro_z_train_T_2<-gather(body_gyro_z_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      total_acc_x_train_T_2<-gather(total_acc_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      total_acc_x_train_T_2<-gather(total_acc_x_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      total_acc_z_train_T_2<-gather(total_acc_z_train_T,Time_Sequence,Observations,Obs1:Obs128,-ObservationType_IntertialSignals_Axis_ExperimentSet)
      


##code to seprate the columns later on...
##separate(body_acc_x_train_T,ObservationType_IntertialSignals_Axis_ExperimentSet, c("ObservationType", "IntertialSignals","Axis", "ExperimentSet"))