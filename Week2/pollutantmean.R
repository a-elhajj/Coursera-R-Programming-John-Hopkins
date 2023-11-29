# Part 1
# Write a function named 'pollutantmean' that calculates the mean of a pollutant
#c(sulfate or nitrate) across a specified list of monitors. 
# The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', 
# and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that 
# monitors' particulate matter data from the directory specified in the 
# 'directory' argument and returns the mean of the pollutant across all of 
# the monitors, ignoring any missing values coded as NA. 
# A prototype of the function is as follows

pollutantmean <- function(directory, pollutant, id = 1:332) {
    # 'directory': a char vector of length 1 indicating the location of the csv files
    # 'pollutant': a char vector of length 1 indicating the name of the pollutant
    #       for which we will calculate the mean; either sulfate or nitrate
    # 'id': an integer vector indicating the monitor ID numbers to be used
    
    # Return the mean of the pollutant across all monitors list in the 'id'
    #       vector (ignoring NA values)
    # Note: DO NOT round the results
    dataPath <- paste0(toString(getwd()),"/",directory)
    meanList <- list()
    for(i in id) {
        tmp <- read.csv(paste0(dataPath, "/", sprintf("%03d", i),".csv"))
        tmpList <- tmp[complete.cases(tmp[pollutant]), ]
        meanList <- append(meanList, tmpList[pollutant])
        meanValue <- mean(unlist(meanList))
        
    }
    return(meanValue)
}
pollutantmean("specdata", "sulfate", id <- 1:10)