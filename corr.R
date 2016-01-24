corr <- function(directory, threshold = 0){
  
  df <- complete(directory)
  
  threshold_met <- df[, "nobs"] > threshold
  
  if (sum(threshold_met)==0){
    return()
  }
  file_list <- df[threshold_met,]
  
  id <- file_list[,"station"]
  
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
    
    sulfate <- tmp_df[,"sulfate"]
    nitrate <- tmp_df[,"nitrate"]
    
    x_tmp <- cor(sulfate, nitrate, use="pairwise.complete.obs")
    
    if(i == 1) { #Create x if it is the first run
      
      x <- x_tmp
      
    } else {
      
      x <- c(x, x_tmp) #Add data from current file running total of values
  
    }
    
  }
  
  setwd("..")
  x
}