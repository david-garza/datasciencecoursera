complete <- function(directory, id = 1:332){
  
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
    
    test_complete <- !is.na(tmp_df["sulfate"] & tmp_df["nitrate"])
    
    n_complete_obs <- sum(test_complete) #Sum the number of TRUE where TRUE = 1
    
    if(i == 1) { #Create x if it is the first run
      
      station <- id[i]
      nobs <- n_complete_obs
      
    } else {
      
      station <- c(station, id[i]) #Add data from current file running total of values
      nobs <- c(nobs, n_complete_obs)
    }
    
  }
  
  setwd("..")
  
  data.frame(station, nobs) # Create and report the data frame

}