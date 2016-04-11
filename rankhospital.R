#This function returns the name of a hospital in a state with a given rank, uses most of the lines from best.R

rankhospital <- function(state, outcome, num = "best"){
  
  #Read the outcome data from outcome-of-care-measures.csv
  care.outcome <- read.csv("rprog-data-ProgAssignment3-data/outcome-of-care-measures.csv", colClasses = "character")
  
  #Create a list of all of the states in the data
  
  state.list <- unique(care.outcome[,7])
  
  #Test the  entered state value against the list of states
  
  if (length(state.list[state.list == state]) == 0) {
    stop("invalid state")
  }
  
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
  
  care.state <- care.outcome[care.outcome[,7] == state,] #Narrows the data set to only the state that was entered
  
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
    } else if (num > nrow(care.state)) {
      return(NA)
    }
    
    care.state.ordered <- care.state[order(care.state[,11],care.state[,2]),]
    return(care.state.ordered[num,2])
  }
  
  # Second order by Heart Failure
  if  (outcome == outcome.list[2]){
    
    #Remove NA from the state data
    care.state <- care.state[!is.na(care.state[,17]),]
    
    #Set num properly
    if (num == "best") {
      num <- 1
    } else if (num == "worst") {
      num <- nrow(care.state)
    } else if (num > nrow(care.state)) {
      return(NA)
    }
    
    care.state.ordered <- care.state[order(care.state[,17],care.state[,2]),]
    return(care.state.ordered[num,2])
    
  }
  
  # Third order by Pneumonia
  if  (outcome == outcome.list[3]){
    
    #Remove NA from the state data
    care.state <- care.state[!is.na(care.state[,23]),]
    
    #Set num properly
    if (num == "best") {
      num <- 1
    } else if (num == "worst") {
      num <- nrow(care.state)
    } else if (num > nrow(care.state)) {
      return(NA)
    }
    care.state.ordered <- care.state[order(care.state[,23],care.state[,2]),]
    return(care.state.ordered[num,2])
  }
}