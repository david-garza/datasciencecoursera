# This is the first plot for the second course project in data explroation. Author David C Garza 01/07/2017
# Requiares the curl package.

plot1 <- function() {
  
  #Download file note that the connection is an https secure connection
  con <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  curl_download(con, "exdata%2Fdata%2FNEI_data.zip")
  
  #unzip the file
  unzip("exdata%2Fdata%2FNEI_data.zip")
  
  #Load the R objects into the environment
  NEI <- readRDS("summarySCC_PM25.rds")
  
  # Use tapply the subset the NEI data
  total_per_year <- tapply(NEI$Emissions, as.factor(NEI$year), sum)
  
  #open plotting device for png
  png(file = "plot1.png")
  
  plot(names(total_per_year),total_per_year, xlab = "Year", ylab = "PM 2.5 Emissions (Tons)", main ="National Total Yearly PM 2.5 Emissions Trending Downward")
  lines(names(total_per_year),total_per_year)
  
  #Close plotting device
  dev.off()
}