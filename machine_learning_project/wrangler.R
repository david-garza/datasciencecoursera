# 1/25/2021
# Author: David C Garza
# Purpose: Functions for specific data wrangling requirements.
# Assumptions: Assumes that the data of interest is from columns 8-159 in data frame

# Fixing divide by zero errors and then converting the column type to numeric 

diverror<-function(x){
  
  #Moves across columns of the data frame
  for (i in 8:159) {
    
    # Check to see if the current column is type character
    if(typeof(x[,i])=="character"){
      
      #Then check rows for #DIV/0! and replace with a blank
      if(x[,i]=="#DIV/0!") ""
      
      # Then replace that column with the numeric data type
      x[,i]<-as.numeric(x[,i])
    }
  }
  
  # Return x
  x
}

# Checks for columns with all NA values
badcol<-function(x){
  
  #Initialize the vector that will store the nearly empty columns
  y<-as.integer()
  
  #Moves across columns of the data frame
  for (i in 8:159) {
    
    #Compute the number of NA in the column
    z<-length(x[,i][is.na(x[,i])])/length(x[,i])
    
    #Check to see if the column has more than .5 missing values and record it
    if(z>.5) y<-c(y,i)
  }
  y
}