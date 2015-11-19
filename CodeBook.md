# Course3_proj
Coursera cleaning data project

this repo contails the data, the final output, and the script that analyzes the data and produces the summarized table.

##The Goal of the Project
The goal of this project is to create one R script called run_analysis.R that does the following: 
  1. Merges the training and the test sets to create one data set.
  2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  3. Uses descriptive activity names to name the activities in the data set
  4. Appropriately labels the data set with descriptive variable names. 
  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##The Data
The data can be found in getdata-projectfiles-UCI HAR Dataset.zip or in the "UCI HAR Dataset directory"
also it can be downloaded from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Required Libraries
dplyr - this library is requires to successfully run this script

##The Script
run_analysis.R - this script loads the dplyr library and runs all of the goals mentioned above and outputs the final summarized tidy set of data.  The way you use it is as follows 
  * set your working directory
  * get your data ready by unzipping the file
  * source run_analysis.R
  * when you call run_analysis(dataFolder) you will be required to pass it the path to the data folder it will need to read.
    + ex run_analysis("UCI HAR Dataset")
  * once run - the proper file will be output into the working directory.

##The Final Analyzed Dataset
The final dataset will be named "sumarized_tidy_dataset.txt"  You can see the example of the output in this repo.
