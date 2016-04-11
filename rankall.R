#This function list all the hospitals of a given rank in every state

rankall <- function(outcome, num="best") {
  
  check <- FALSE
  #Read the outcome data from outcome-of-care-measures.csv
  care.outcome <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  #Create a list of all of the states in the data
  
  state.list <- unique(care.outcome[,7])
  
  
  
  #Create a list of the current outcomes
  
  outcome.list <- c("heart attack","heart failure","pneumonia")
  
  #Test the entered value against the outcome list
  
  if(length(outcome.list[outcome.list == outcome])==0) {
    stop("invalid outcome")
  }
  
  #Format the data rate data into numerics
  
  care.outcome[,11] <- as.numeric(care.outcome[,11]) # Heart Attacke Mortality Rate
  care.outcome[,17] <- as.numeric(care.outcome[,17]) # Heart Failure Mortality Rate
  care.outcome[,23] <- as.numeric(care.outcome[,23]) # Pneumonia Mortality Rate
  
  #Create a list of the data by state
  
  national <- split.data.frame(care.outcome,care.outcome[,7])
  
  #Loop through the state list
  state <- NULL
  hospital <- NULL
  
  
  for (i in seq_along(state.list)) {
   
    care.state <- national[[state.list[i]]] #Data Farm with current state data
    
    #Now we order the data by the requested outcome
    
    # First order by Heart Attack
    if (outcome == outcome.list[1]){
      
      #Remove NA from the state data
      care.state <- care.state[!is.na(care.state[,11]),]
      
      #Set num properly
      if (num == "best") {
        num <- 1
      } else if (num == "worst") {
        num <- nrow(care.state)
        check <- TRUE
      } else if (num > nrow(care.state)) {
        x <- NA
        
        
      }
      
      care.state.ordered <- care.state[order(care.state[,11],care.state[,2]),]
      x <- care.state.ordered[num,2]
      
      
    }
    
    # Second order by Heart Failure
    else if  (outcome == outcome.list[2]){
      
      #Remove NA from the state data
      care.state <- care.state[!is.na(care.state[,17]),]
      
      #Set num properly
      if (num == "best") {
        num <- 1
      } else if (num == "worst") {
        num <- nrow(care.state)
        check <- TRUE
      } else if (num > nrow(care.state)) {
        x <- NA
        
        
      }
      
      care.state.ordered <- care.state[order(care.state[,17],care.state[,2]),]
      x <- care.state.ordered[num,2]
      
      
      
    }
    
    # Third order by Pneumonia
    else if  (outcome == outcome.list[3]){
      
      #Remove NA from the state data
      care.state <- care.state[!is.na(care.state[,23]),]
      
      #Set num properly
      if (num == "best") {
        num <- 1
      } else if (num == "worst") {
        num <- nrow(care.state)
        check <- TRUE
      } else if (num > nrow(care.state)) {
        x <- NA
        
      
      }
      care.state.ordered <- care.state[order(care.state[,23],care.state[,2]),]
      x <- care.state.ordered[num,2]
      
      
    }
    
    state <- c(state, state.list[i])
    hospital <- c(hospital, x)
    if (check == TRUE){
      num <- "worst"
    }
  }
  
  df <- data.frame(state,hospital)
  dfo <- df[order(df[,1]),]
}