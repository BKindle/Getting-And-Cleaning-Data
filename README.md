## Purpose
###You should create one R script called run_analysis.R that does the following: 
*1. Merges the training and the test sets to create one data set. 
*2. Extracts only the measurements on the mean and standard deviation for each measurement. 
*3. Uses descriptive activity names to name the activities in the data set 
*4. Appropriately labels the data set with descriptive activity names. 
*5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Process
*Step1: Bring in relevant packages (specifically dplyr and reshape2) using the library() function and set working directory using setwd() function.
*Step2: Read the activity labels from activity_labels.txt and replace numeric values with descriptive text.
*Step3: Read features.txt and filter it to leave only features that are either "mean()" or "Std()."
*Step4: Read, process/rename, and bind "test" data frame.
*Step5: Read, process/rename, and bind "train" data frame.
*Step6: Combine train and test into single data frame, and then find the mean for each combination of subject and label.
*Step7: Write the final data frame to tidy.txt using the write.table() function.