# This function is designed to:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# This script is hardcoded to assume that the data is stored in a direcotry called
# UCI_HAR_Dataset


run_analysis <- function() {
  # 1 Read the data
  # Define data locations
  
  home <- "~/datasciencecoursera/UCI_HAR_Dataset/"
  train <- "~/datasciencecoursera/UCI_HAR_Dataset/train/"
  test <- "~/datasciencecoursera/UCI_HAR_Dataset/test/"
  
  # Read the files in the home directory
  
  features <- read.table(paste(home,"features.txt",sep=""))
  activity_labels <- read.table(paste(home,"activity_labels.txt",sep=""))

  # Read the data from the train directory
  
  y_train <- read.table(paste(train,"y_train.txt",sep=""))
  x_train <- read.table(paste(train,"X_train.txt",sep=""))
  subject_train <- read.table(paste(train,"subject_train.txt",sep=""))
  
  # Read the data from the test directory
  
  y_test <- read.table(paste(test,"y_test.txt",sep=""))
  x_test <- read.table(paste(test,"X_test.txt",sep=""))
  subject_test <- read.table(paste(test,"subject_test.txt",sep=""))
  
  # Combine the datasets by test then train
  
  # Combine the main raw data first x_test then x_train
  processed_data <- rbind(x_test,x_train)
  #Free up memory
  rm(x_test)
  rm(x_train)
  
  # Apply the feature names to each variable in the processed_data set
  names(processed_data) <- features$V2
  
  # Combine the activity label by y_test then y_train
  activity_test_train <- rbind(y_test,y_train)
  
  # Merge the labels to the numbers
  activity <- merge(activity_test_train, activity_labels)
  
  # Combine the activy label to the processed data table
  processed_data <- cbind(activity$V2,processed_data)
  
  # Combine the subject list by subject_test then subject_train
  subject <- rbind(subject_test,subject_train)
  
  #combine the subject list to the processed data table
  processed_data <- cbind(subject, processed_data)
  
  # Rename the first two columns in processed data table
  colnames(processed_data)[colnames(processed_data)=="V1"] <- "subject"
  colnames(processed_data)[colnames(processed_data)=="activity$V2"] <- "activity"
  
  # Now that the data is all merged and labeled, the script will not extract only the columns of subject, activity, mean and std values
  columns <- sort(c(1,2,grep("mean",names(processed_data)),grep("std",names(processed_data))))
  
  tiddy_data <- processed_data[columns]
  
  #Perform step 5 subset the data by activty and subject and average
  mean_table <- aggregate(tiddy_data, by=list(tiddy_data$activity, tiddy_data$subject),mean)
  
  # Format mean_table by removing the now defunct subject and activity columns
  mean_table$subject <- NULL
  mean_table$activity <- NULL
  
  # Rename the grouping columns to become more descriptive
  colnames(mean_table)[colnames(mean_table)=="Group.1"] <- "activity"
  colnames(mean_table)[colnames(mean_table)=="Group.2"] <- "subject"
  
  # Ensure that the last item gets printed
  mean_table
 }