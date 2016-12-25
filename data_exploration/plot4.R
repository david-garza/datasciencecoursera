## This script creates the combo plot for plot4.png of the Exploring Data Project 1 assignment. Author David Garza
## 2016.12.12.
## This script assumes that the file househod_power_consumption.txt is present in the active directory.

# First read the data

plot4 <- function() {
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
  
  #open and PNG file plot a histogram into it
  
  png("plot4.png")
  
  #Create partitions
  par(mfcol = c(2,2))
  
  #Plot 1
  with(february,plot(datetime, Global_active_power, type = "n", ylab = "Global Active Power"))
  with(february, lines(datetime, Global_active_power))
  
  #Plot 2
  with(february, plot(datetime, Sub_metering_1, type = "n", ylab = "Energy submetering"))
  with(february, lines(datetime, Sub_metering_1))
  with(february, points(datetime, Sub_metering_2, pch = NA_integer_))
  with(february, lines(datetime, Sub_metering_2, col = "red"))
  with(february, points(datetime, Sub_metering_3, pch = NA_integer_))
  with(february, lines(datetime, Sub_metering_3, col = "blue"))
  with(february, legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lwd = 2))
  
  #Plot 3
  with(february, plot(datetime,Voltage, type = "n", ylab = "Voltage"))
  with(february, lines(datetime,Voltage))
  
  #Plot 4
  with(february, plot(datetime,Global_reactive_power, type = "n", ylab = "Global_reactive_power"))
  with(february, lines(datetime,Global_reactive_power))
  dev.off()
  
} 