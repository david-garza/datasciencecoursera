## This script creates the line graph for plot2.png of the Exploring Data Project 1 assignment. Author David Garza
## 2016.12.17.
## This script assumes that the file househod_power_consumption.txt is present in the active directory.

# First read the data

plot2 <- function() {
  # First read the data
  raw_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
  
  # Combine the Date and Time columns together to create a singe time variable
  raw_data$datetime <- paste(raw_data$Date," ", raw_data$Time)
  
  #Convert the new datetime variable into POSIXlt format
  raw_data$datetime <- strptime(raw_data$datetime, format = "%d/%m/%Y %H:%M:%S")
  
  #Subset the data to only pull 2007-02-01 to 2007-02-02
  february <- subset(raw_data, subset = raw_data$datetime >= '2007-02-01' & raw_data$datetime < '2007-02-03')
  
  #Free up memory be removing the larger dataset
  rm(raw_data)
  
  #open and PNG file plot a line graph into it
  
  png("plot2.png")
  with(february,plot(datetime, Global_active_power, type = "n"))
  with(february, lines(datetime, Global_active_power))
  dev.off()
  
} 