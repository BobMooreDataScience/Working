#0.0  Get the zip file and put it in the working directory
    # NOTE: If you have the files, then you can skip this section and start with the script for question 1.

#0.1 Set the library and working directory for just this section.
 # NOTE: My local drive path is not provided, rather the user shouldreplace the ",,," in my path with their own path. 

library(httr)
setwd(",,,")

#0.2 Get the zip file and put it in the working directory
response <- GET("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                write_disk("Week4.csv.zip"),
                progress()) ### NOTE: Neat little progress indicator


#0.3 Designate the zip files directory and the output directory and unzip the files
zipF<- ",,,"
outDir<-",,,"
unzip("Week4.csv.zip",exdir=outDir)
