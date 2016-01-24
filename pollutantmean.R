pollutantmean <- function(directory, pollutant, id = 1:332){
  
  setwd(directory) #Changes the directory to the data location
    
  #Loop through file names
  
  for (i in seq_along(id)) {
    
    if (id[i] < 10) { #Test file names
      
      filename <- paste("00",id[i],".csv", sep = "")
      
    } else if (id[i] < 100){ 
      
      filename <- paste("0",id[i],".csv", sep = "")
      
    } else {
      
      filename <- paste(id[i],".csv", sep = "")
      
    }
    
    tmp_df <- read.csv(filename) # Create a Temporay Data Frame
    
    tmp_data <- tmp_df[,pollutant] # Pull the column of interest
    
    clean <- !is.na(tmp_data) # Produce a logical vector to test for NA
    
    x_tmp <- tmp_data[clean] # Pull out the clean data
    
    if(i == 1) { #Create x if it is the first run
      
      x <- x_tmp
      
    } else {
      
      x <- c(x, x_tmp) #Add data from current file running total of values
      
    }
    
  }
  
  setwd("..")
  
  mean(x)
  
}