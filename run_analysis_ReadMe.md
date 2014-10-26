The run_analysis.R script performs the following tasks based on the data obtained at: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
1. Merges the training and the test sets to create one data set.
  
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
  
3. Uses descriptive activity names to name the activities in the data set
  
4. Appropriately labels the data set with descriptive variable names. 

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


THIS SCRIPT ASSUMES THAT THE WORKING DIRECTORY HAS BEEN SET TO 'UCI HAR Dataset'
  
======================================================
  
Read in the pertinent data files

1. Merge the training and the test sets to create one data set.

Combine test and train data
Name columns in merged dataset using feature names
Convert feature names from factor to character vectors
Replace column names in merged dataset with feature names
Combine subject datasets and label datasets
Combine subject and label datasets with merged dataset


4. rename newly added subject and label columns in full dataset

2. Extract the measurements on the mean and standard deviation for each measurement.

Identify columns to keep

NOTE: NOT INCLUDING THE COLUMNS WITH NAMES BEGINNING 'angle(...' BECAUSE THEY DO NOT SEEM TO BE ACTUAL MEANS BUT CALCULATIONS BASED UPON DATA CONTAINING A MEAN

Combine to one vector (include "subject" and "activitycode" columns for analysis)
Subset/extract useful columns

3. Use descriptive activity names to name the activities in the data set
Map values

Populate a new column with detailed activity names corresponding to activity codes
Remove activity codes column for cleaner data

5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Install "reshape2" package, use library
Convert table to data frame
Melt data frame
Take means of columns by subject and store as data frames
Split data by subject and save data frames as variables
Cast data frames with acivity means for each subject
Merge to one data frame
Move subject column to front for ease of use
Write tidy data to .txt file