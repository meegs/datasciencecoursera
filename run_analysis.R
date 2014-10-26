## Create an R script that performs the following tasks:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for
## each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second,
## independent tidy data set with the average of each variable for
## each activity and each subject.

## set working directory
setwd("UCI HAR Dataset/")

## read data
# create indices of columns for mean and std deviation data
features <- read.table("features.txt")["x"]
activity_labels <- read.table("activity_labels.txt")["x"]
indices <- grep("mean|stddev",features$x)

# read training data, create descriptive labels for variables
setwd("train")
X_train <- read.table("X_train.txt")
names(X_train) <- features$x

y_train <- read.table("y_train.txt")
names(y_train) <- names(y_train)<-"labels"

subject_train <- read.table("subject_train.txt")
names(subject_train) <- "subjects"

# read test data
setwd("../test/")
X_test <- read.table("X_test.txt")
names(X_test) <- features$x

y_test <- read.table("y_test.txt")
names(y_test) <- "labels"

subject_test <- read.table("subject_test.txt")
names(subject_test) <- "subjects"

## Extract only the measurements on the mean and standard deviation for
## each measurement.
setwd("../../")
column_names <- colnames(X_test)[indices]
mstd_test <- cbind(subject_test,y_test,subset(X_test,select=column_names))
mstd_train <- cbind(subject_train,y_train,subset(X_train,select=column_names))

## Merge the training and the test sets to create one data set.
fulldata <- rbind(mstd_test, mstd_train)

## Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_data <- aggregate(fulldata[,3:ncol(fulldata)],list(Subject=fulldata$subjects, Activity=fulldata$labels), mean)

## Use descriptive activity names to name the activities in the data set
tidy_data$Activity <- activity_labels[tidy_data$Activity,]

## write table to new file
write.table(tidy_data, file="./tidy_data.txt", sep="\t", row.names=FALSE)
