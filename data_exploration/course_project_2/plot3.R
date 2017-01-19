# This is the third plot for the second course project in data explroation. Author David C Garza 01/07/2017
# This script assumes that either plot1.R or plot2.R have already been run and that summarySCC_PM25.rds is present int he working directory.
# As per the course assignment, this script requires the ggplot package and reshape2

plot3 <- function() {
  
  #Load the R objects into the environment
  NEI <- readRDS("summarySCC_PM25.rds")
  
  #Subset the dataset to only Baltimore data using FIPS == 24510
  NEI <-subset(NEI, NEI$fips == "24510")
  
  
  # Use tapply the subset the NEI data
  total_per_year <- tapply(NEI$Emissions, list(NEI$year,NEI$type), sum)
  total_per_year <- as.data.frame(total_per_year)
  total_per_year$Year <- row.names(total_per_year)
  
  # Melt the data into a tall dataset for use in ggplot
  total_per_year <- melt(total_per_year, id.vars = "Year", variable.name = "Source", value.name = "Emissions")
  total_per_year$Year <- as.numeric(total_per_year$Year) # I had to change the year to numeric to get the lines to work correctly
  
  #open plotting device for png
  png(file = "plot3.png")
  
  g <- ggplot(total_per_year, aes(Year, Emissions)) + geom_line(aes(color = Source)) + labs(title = "Yearly Trend of Emissions Sources in Baltimore")
  print(g)
  #Close plotting device
  dev.off()
}