# This is the fifth plot for the second course project in data explroation. Author David C Garza 01/07/2017
# This assumes that you the data files are already downloaded and unzipped in the current working directory.

plot5 <- function() {
  
  #Load the R objects into the environment
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #Subset the dataset to only Baltimore data using FIPS == 24510
  baltimore <-subset(NEI, NEI$fips == "24510")
  
  # Use the SCC table to find Vehicle sources
  vehicle <- grep("Vehicle", SCC$EI.Sector)
  SCC_vehicle <- SCC[vehicle,]
  vehicle_codes <- as.character(SCC_vehicle$SCC)
  
  # Use vehicle_codes to subset baltimore for vehicle sources
  baltimore_vehicle <- subset(baltimore, baltimore$SCC %in% vehicle_codes)
  
  # Use tapply the subset the NEI data
  total_per_year <- tapply(baltimore_vehicle$Emissions, as.factor(baltimore_vehicle$year), sum)
  
  #open plotting device for png
  png(file = "plot5.png")
  
  plot(names(total_per_year), total_per_year, main = "Yearly Total Emissions from Vehicles in Baltimore", xlab = "Year", ylab = "PM 2.5 Emissions (Tons)")
  lines(names(total_per_year), total_per_year)
  
  #Close plotting device
  dev.off()
}