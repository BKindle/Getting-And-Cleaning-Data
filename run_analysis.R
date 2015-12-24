## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
library(reshape2)
setwd("C:/Users/bkindle/Desktop/Data Science/3 - Getting and Cleaning Data/Project 1/UCI HAR Dataset")

# Load Activity Labels
activity_labels <- read.table("./activity_labels.txt")[,2]

# Load Features (Data Column Names)
features <- read.table("./features.txt")[,2]

# Extract Mean and Standard Deviation
extract <- grep("mean\\(\\)|std\\(\\)", features)

# --------------- TEST -------------------
# Load Three Data Frames
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

# Process and Rename
names(x_test) = features
x_test = x_test[,extract]
y_test$V2 <- activity_labels[y_test$V1]
y_test <- rename(y_test, Activity_ID=V1, Activity_Label=V2)
subject_test <- rename(subject_test, Subject=V1)

# Bind Three Data Frames
test_part1 <- cbind(subject_test, y_test)
test_data <- cbind(test_part1, x_test)

# --------------- TRAIN -------------------
# Load Three Data Frames
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

# Process and Rename
names(x_train) = features
x_train = x_train[,extract]
y_train$V2 <- activity_labels[y_train$V1]
y_train <- rename(y_train, Activity_ID=V1, Activity_Label=V2)
subject_train <- rename(subject_train, Subject=V1)

# Bind Three Data Frames
train_part1 <- cbind(subject_train, y_train)
train_data <- cbind(train_part1, x_train)

# --------------- COMBINE and WRITE -------------------
data <- rbind(test_data, train_data)
lab1 <- c("Subject", "Activity_ID", "Activity_Label")
lab2 <- setdiff(colnames(data), lab1)
melt <- melt(data, id = lab1, measure.vars = lab2)
tidy <- dcast(melt, Subject + Activity_Label ~ variable, mean)
write.table(format(tidy, scientific=TRUE), "tidy.txt", 
		sep=" ", row.names=FALSE, col.names=FALSE, quote=2)
