setwd("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/Week 4 Files/UCI HAR Dataset/train/Inertial Signals")
body_acc_x_train_1 <- read.table("body_acc_x_train.txt", colClasses="numeric")
colnames(body_acc_x_train_1) <- paste0( rep("Obs", 128), 1:128)


setwd("C:/Users/Bob or Laura J/Desktop/r Programming/Coursera/Course 3 Data Cleaning/Week 4 Files/UCI HAR Dataset/train")
y_train_1 <- read.table("y_train.txt")
colnames(y_train_1) <- c("Subject")   

body_acc_x_train_T <- cbind(y_train_1,body_acc_x_train_1)

# Check the sum now. It should be -598.7968 and check with Excell
sum(mapply(sum,body_acc_x_train_T)) - sum(body_acc_x_train_T$Subject)

# Create  a single column of seperated by an underscore (_) that represents the file with the follwing four refernces:
        #a. Observation_Type where Body is "Raw" and Total is "Calculated"
        #b. Intertial_Signals with either "Acc" or "Gyro" for accelerattion or gyroscopic
        #c. Create column Axsis as either "x", "y", or "z" for cartesian coordinate refernces
        #d. Experiment_Set is either the "Train" or "Test" set

body_acc_x_train_T$ObservationType_IntertialSignals_Axis_ExperimentSet <- c("Raw_Acc_x_Train")

#  Get the columns right
body_acc_x_train_T_2 <- gather(body_acc_x_train_T,Delete_This,Observations , Obs1:Obs128, -ObservationType_IntertialSignals_Axis_ExperimentSet)
#NOTE: The above code could be improved but it works!!
str(body_acc_x_train_T_2)
sum(body_acc_x_train_T_2$Observations)  # this is correct!!!!

body_acc_x_train_T_3 <- body_acc_x_train_T_2 [,c("Subject", "ObservationType_IntertialSignals_Axis_ExperimentSet", "Observations")]
str(body_acc_x_train_T_3)
sum(body_acc_x_train_T_3$Observations)  # this is correct!!!!


##code to seprate the columns later on...
##separate(body_acc_x_train_T,ObservationType_IntertialSignals_Axis_ExperimentSet, c("ObservationType", "IntertialSignals","Axis", "ExperimentSet"))