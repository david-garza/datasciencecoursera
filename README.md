# Assignment: Getting and Cleaning Data Course Project
##This readme pertains to the run_analysis.R script.
The script run_analysis.R is designed to perform the following functions.

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Assumptions
The script assumes that the data is stored in the directory UCI_HAR_Datase with the sub directories train and test. This is the structure directory structure in the provided zip file.

## Logical Flow of run_analysis.R

1. Reads the following files: features.txt, activity_labels.txt, y_train.txt, X_train.txt, subject_train.txt,y_test.txt, X_test.txt, subject_test.txt

2. Combines the x files, to combine the training and test data into one large table.

3. Add labels to the combined data set using the lables provided in the features.txt file.

4. Combine the train and test activity tables to create a master table that matches the data rows from step 2.

5. Perform a table join to combine the activity list for the data with activity labels to make the more readable.

6. Combine the train and test subject tables to creae a master table that matches the data rows from step 2.

7. Merge the activty labels and the subject numbers to the master data table create in step 2.

8. Pull the subject, activit, and any variable identified as mean or standard deviation to create a tiddy table.

9. Run and aggregate function to average the variables by activty and subject.

10. Perform cleaning of the columns and column names to make it more readable.

## Output
The function produces a tiddy data table averaged by activty and by subject.