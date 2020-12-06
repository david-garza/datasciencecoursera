# Plotting practice script. 2017/02/03. By David Carlos Garza

# Plot 1 what is the relationship between mean covered charges (Average.Covered.Charges) and mean total payments (Average.Total.Payments) in New York?

plot1 <- function(){
  
  # Read data
  df <- read.csv("payments.csv")
  
  # Subset the data set to NY state only
  ny <- subset.data.frame(df, df$Provider.State == "NY")
  
  # Open the pdf plotting device
  
  pdf("plot1.pdf")
  
  boxplot(log(ny$Average.Covered.Charges), log(ny$Average.Total.Payments), names = c("Average Covered Cost","Average Total Payments"), ylab = "Log of Cost", main = "Covered Cost as Compared to Total Payments")
  
  # Close the plotting Device
  dev.off()
}