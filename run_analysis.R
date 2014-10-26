
======================================================
  
## Create one R script called run_analysis.R that does the following:
  
## 1. Merges the training and the test sets to create one data set.
  
## 2. Extracts only the measurements on the mean and
##    standard deviation for each measurement. 
  
## 3. Uses descriptive activity names to name the activities in the data set
  
## 4. Appropriately labels the data set with descriptive variable names. 

## 5. From the data set in step 4, creates a second, independent
##    tidy data set with the average of each variable for
##    each activity and each subject.

======================================================
  
## THIS SCRIPT ASSUMES THAT THE WORKING DIRECTORY HAS BEEN SET TO 'UCI HAR Dataset'
  
======================================================
  
## Read in the pertinent data files
xtest <- read.table("test/X_test.txt")
ytest <- read.table("test/Y_test.txt")
stest <- read.table("test/subject_test.txt")
xtrain <- read.table("train/X_train.txt")
ytrain <- read.table("train/Y_train.txt")
strain <- read.table("train/subject_train.txt")
a_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt")



## 1. Merge the training and the test sets to create one data set.

## combine test and train data
setdata <- rbind(xtrain,xtest)

## name columns in merged dataset using feature names
fnameschar <- as.character(features$V2)	# convert feature names from factor
# to character vectors
colnames(setdata) <- fnameschar		# replace column names in merged dataset
# with feature names

## combine subject datasets and label datasets
subjdata <- rbind(strain,stest)
ylabels <- rbind(ytrain,ytest)

## combine subject and label datasets with merged dataset ('setdata' above)
fulldata <- cbind(setdata,subjdata,ylabels)

## 4. rename newly added subject and label columns in full dataset
colnames(fulldata)[562] <- "subject"
colnames(fulldata)[563] <- "activitycode"



## 2. Extract the measurements on the mean and standard deviation for each measurement.

## identify columns to keep
meancols <- grep("mean", names(fulldata), value=TRUE)
stdcols <- grep("std", names(fulldata), value=TRUE)

## NOTE: NOT INCLUDING THE COLUMNS WITH NAMES BEGINNING 'angle(...'
## BECAUSE THEY DO NOT SEEM TO BE ACTUAL MEANS
## BUT CALCULATIONS BASED UPON DATA CONTAINING A MEAN


## combine to one vector (include "subject" and "activitycode" columns for analysis)
keepcols <- c(meancols,stdcols,"subject","activitycode")

## subset/extract useful columns
extract <- fulldata[keepcols]



## 3. Use descriptive activity names to name the activities in the data set

## function to map values
activity_names <- function(x){
  if(x == 1)
    return("WALKING")
  if(x == 2)
    return("WALKING_UPSTAIRS")
  if(x == 3)
    return("WALKING_DOWNSTAIRS")
  if(x == 4)
    return("SITTING")
  if(x == 5)
    return("STANDING")
  if(x == 6)
    return("LAYING")
  else
    return(NA)
}

## populate a new column with detailed activity names corresponding to
## activity codes
extract$activity <- sapply(extract$activitycode, activity_names)
## remove activity codes column for cleaner data
extract$activitycode <- NULL



## 5. Create a second, independent tidy data set with the
## average of each variable for each activity and each subject.

## install "reshape2" package, use library
install.packages("reshape2")
library(reshape2)

## convert table to data frame
extract2 <- as.data.frame(extract)
## melt data frame
measvars <- as.list(names(extract2))
measvars <- measvars[-c(80,81)]
extractMelt <- melt(extract2,id=c("subject","activity"),measure.vars=measvars)

## take means of columns by subject and store as data frames
## split data by subject and save data frames as variables
invisible(lapply(split(extractMelt,extractMelt$subject), function(x) {
  assign(paste0("subject", x$subject[1]), x, pos=.GlobalEnv) }))

## cast data frames with acivity means for each subject
tidydata1 <- dcast(subject1, activity ~ variable, mean)
tidydata1$subject <- "Subject 1"
tidydata2 <- dcast(subject2, activity ~ variable, mean)
tidydata2$subject <- "Subject 2"
tidydata3 <- dcast(subject3, activity ~ variable, mean)
tidydata3$subject <- "Subject 3"
tidydata4 <- dcast(subject4, activity ~ variable, mean)
tidydata4$subject <- "Subject 4"
tidydata5 <- dcast(subject5, activity ~ variable, mean)
tidydata5$subject <- "Subject 5"
tidydata6 <- dcast(subject6, activity ~ variable, mean)
tidydata6$subject <- "Subject 6"
tidydata7 <- dcast(subject7, activity ~ variable, mean)
tidydata7$subject <- "Subject 7"
tidydata8 <- dcast(subject8, activity ~ variable, mean)
tidydata8$subject <- "Subject 8"
tidydata9 <- dcast(subject9, activity ~ variable, mean)
tidydata9$subject <- "Subject 9"
tidydata10 <- dcast(subject10, activity ~ variable, mean)
tidydata10$subject <- "Subject 10"
tidydata11 <- dcast(subject11, activity ~ variable, mean)
tidydata11$subject <- "Subject 11"
tidydata12 <- dcast(subject12, activity ~ variable, mean)
tidydata12$subject <- "Subject 12"
tidydata13 <- dcast(subject13, activity ~ variable, mean)
tidydata13$subject <- "Subject 13"
tidydata14 <- dcast(subject14, activity ~ variable, mean)
tidydata14$subject <- "Subject 14"
tidydata15 <- dcast(subject15, activity ~ variable, mean)
tidydata15$subject <- "Subject 15"
tidydata16 <- dcast(subject16, activity ~ variable, mean)
tidydata16$subject <- "Subject 16"
tidydata17 <- dcast(subject17, activity ~ variable, mean)
tidydata17$subject <- "Subject 17"
tidydata18 <- dcast(subject18, activity ~ variable, mean)
tidydata18$subject <- "Subject 18"
tidydata19 <- dcast(subject19, activity ~ variable, mean)
tidydata19$subject <- "Subject 19"
tidydata20 <- dcast(subject20, activity ~ variable, mean)
tidydata20$subject <- "Subject 20"
tidydata21 <- dcast(subject21, activity ~ variable, mean)
tidydata21$subject <- "Subject 21"
tidydata22 <- dcast(subject22, activity ~ variable, mean)
tidydata22$subject <- "Subject 22"
tidydata23 <- dcast(subject23, activity ~ variable, mean)
tidydata23$subject <- "Subject 23"
tidydata24 <- dcast(subject24, activity ~ variable, mean)
tidydata24$subject <- "Subject 24"
## merge to one data frame
tidydata <- rbind(tidydata1,tidydata2,tidydata3,tidydata4,tidydata5,tidydata6,tidydata7,tidydata8,tidydata9,tidydata10,tidydata11,tidydata12,tidydata13,tidydata14,tidydata15,tidydata16,tidydata17,tidydata18,tidydata19,tidydata20,tidydata21,tidydata22,tidydata23,tidydata24)
## move subject column to front for ease of use
tidydata[,c(ncol(tidydata),1:(ncol(tidydata)-1))]
## write tidy data to .txt file
write.table(tidydata, "tidydata.txt", row.names=FALSE)