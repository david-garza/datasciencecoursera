# This is the sixth plot for the second course project in data explroation. Author David C Garza 01/07/2017
# This assumes that you the data files are already downloaded and unzipped in the current working directory.
# Requires the reshape2 package and ggplot2

plot6 <- function() {
  
  #Load the R objects into the environment
  NEI <- readRDS("summarySCC_PM25.rds")
  SCC <- readRDS("Source_Classification_Code.rds")
  
  #Subset the dataset to only Baltimore and Los Angles data using FIPS == 24510 and fips == "06037"
  bmd_lax <-subset(NEI, NEI$fips == "24510" | NEI$fips == "06037")
  
  # Use the SCC table to find Vehicle sources
  vehicle <- grep("Vehicle", SCC$EI.Sector)
  SCC_vehicle <- SCC[vehicle,]
  vehicle_codes <- as.character(SCC_vehicle$SCC)
  
  # Use vehicle_codes to subset baltimore for vehicle sources
  bmd_lax_vehicle <- subset(bmd_lax, bmd_lax$SCC %in% vehicle_codes)
  
  # Use tapply the subset the NEI data
  total_per_year <- tapply(bmd_lax_vehicle$Emissions, list(as.factor(bmd_lax_vehicle$year), as.factor(bmd_lax_vehicle$fips)), sum)
  
  # Format the data to make it more user friendly
  colnames(total_per_year) <- c("Los Angles","Baltimore")
  total_per_year <- as.data.frame(total_per_year)
  total_per_year$Year <- as.numeric(row.names(total_per_year))
  
  # Format the data frame for use in ggplot
  df <- melt(total_per_year, id.var = "Year", variable.name = "Location", value.name = "Emissions")
  
  
  #open plotting device for png
  png(file = "plot6.png", width = 520)
  
  g <- ggplot(df, aes(Year, Emissions))+geom_line(aes(color = Location))+labs(title = "Comparison of Yearly Vehicle Emissions between Balitmore and Los Angles")
  print(g)
  
  #Close plotting device
  dev.off()
}