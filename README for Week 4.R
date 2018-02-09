INTRODUCTION: This document and the codebook is provided to help you understand how I used the t run_analysis.R  file the answer the assignment questions. In these files I will demonstrate that my submission meets the required criteria:
        1.	The submitted data set is tidy.
2.	The Github repo contains the required scripts.
3.	GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4.	The README that explains the analysis files is clear and understandable.
5.	The work submitted for this project is the work of the student who submitted it.
GENERAL INFORMATION ON run_analysis.R  
The run_analysis.R  file is sequenced numerically with the assignment to ”…create one R script called that does the following.”
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement.
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names.
5.	From the data set in question 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
EXPLANATION OF THE run_analysis.R  process.
This section outlines the run_analysis.R  file in the same numbered sequence to demonstrate how the questions were answered:
        
        0.0  Get the zip file and put it in the working directory. This firs section is providing for you the user to upload the files. If you have the files, then you can skip this section and start with the script for question 
0.1 Set the library and working directory for just this section. Rather than provide the user with my personal working directory, I provide the ability for the user to use global replace to put their path in. The user should replace the ",,,," in my path with their own path. 
0.2 Get the zip file and put it in the working directory
0.3 Designate the zip files directory and the output directory and unzip the files

1 Question 1: Merges the training and the test sets to create one data set.
1.1 Load libraries and dataset paths.   All libraries required for the rest of the scripted are loaded here. Rather than provide the user with my personal working directory, I provide the ability for the user to use global replace to put their path in. The user should replace the "...." in this script with the directory where UCI HAR Dataset resides. (This is a different path than the one used in step 0 to load the data)
1.3 Pull the data from local drive and assign to datasets. Each file has rows and columns that correspond to other files
1.3.1 Test dataset
The x_test file has 2947 rows and 561 columns where each row identifies a statistical calculation and each column is the description of that calculation.
The subject_test file has 2947 rows in one column where each row identifies the subject who performed the activity for each window sample.  The range is from 1 to 30. 
The y_test  file has rows in one column where each row identifies an activity.  Contains the numbers 2, 4, 9,10, 12, 13, 18, 20, and 24
1.3.2 Train files
The x_train file has 2947 rows and 561 columns where each row identifies a statistical calculation and each column is the description of that calculation.
The subject_train file has 2947 rows in one column where each row identifies the subject who performed the activity for each window sample.  Contains the numbers 1,  3,  5,  6,  7,  8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, and 30.
The y_train  file has rows in one column where each row identifies an activity. The range is from 1 to 6. 

1.3.3 Main files
The features file has two columns with 561 rows. The first column is numerical and the                                                                         second has the statistical calculation description

The activity_label file has two columns with six rows. The first column is numerical and the                                                                         second identifies an activity.

1.4 Create new vector names changes the file download vectors to a better description
1.5 Convert to Stat_Names characters and add index suffix to  Stat_Names for a new column called Index_Stat_Name. This step allows you to later convert the statistical descriptions to something that can be used to become headings foot he Train_Stats and Test_Stats files.
1.6 Make the header of Train_Stats as Index_Stat_Name and then put the Stats column names into rows while maintaining the index for later merges
1.7  Add the subject numbers to the Test and Training datasets by creating a sequential index vector (Stat_Names_Index_Train and Stat_Names_Index_Test) for merging subjects the Train datasets, then merge Stats with Subjects on the index and that dataset with the activities. Note that activities at this point are still numerical
1.8 Clean up columns by getting rid of the Stat_Names_Index and designating the datasets as "Train" or  “Test” to later differentiate them when the datasets are combined.
1.9 Merge Training and Test datasets and view. This is the final answer for question 1.
2.0 Extracts only the measurements on the mean and standard deviation for each measurement.    I determined from looking at the measurement rows to choose every word that could represent   the Mean and/or Standard Deviation. Mean was represented as spelled and I found "std" which  is the abbreviation for standard deviation. The view command allows the user to see the result  and the next command shows distinct mean and standard deviation measurements.
3.0 Uses descriptive activity names to name the activities in the data set.  I assume that since the assignment is numbered that it is sequential; therefore, the dataset referred to in Question 3 is the one in Question 2, i.e. "...only the measurements on the mean and standard deviation for each measurement." I also get rid of the Activity numbers, because it is no longer required. View command allows you to look at the result. Also
4.0 Appropriately labels the data set with descriptive variable names.  This is covered in the Codebook.
5.0 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. The code to create the file is  provided in run_analysis.R  file and the code to extract the file there as well as pasted below
CODE

LAST NOTE
While this is not publication per se, I thought it would be important to include:
        Use of this dataset in publications must be acknowledged by referencing the following publication [1] 
[1] Davide Angelita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on 
Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living 
(IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
