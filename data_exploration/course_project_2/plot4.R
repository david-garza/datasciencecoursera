# This is the fourth plot for the second course project in data explroation. Author David C Garza 01/07/2017
# Requiares the curl package.

plot4 <- function() {
  
  #Load the R objects into the environment
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  # Use the SCC table to fine coal combustion sources
  coal <- grep("Coal", SCC$EI.Sector)
  SCC_coal <- SCC[coal,]
  coal_codes <- as.character(SCC_coal$SCC)
  
  # Use Coal_codes to subset NEI for coal cumbustion sources
  coal_combustion <- subset(NEI, NEI$SCC %in% coal_codes)
  
  # Use tapply to tabulate by year
  total_per_year <- tapply(NEI$Emissions, NEI$year, sum)
  
  #open plotting device for png
  png(file = "plot4.png")
  
  plot(names(total_per_year), total_per_year, xlab = "Year", ylab = "PM 2.5 Emissions (Tons)", main = "Yearly National PM 2.5 Emissions from Coal Combustion")
  lines(names(total_per_year), total_per_year)
  
  #Close plotting device
  dev.off()
}