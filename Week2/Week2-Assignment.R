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
#pollutantmean("specdata", "sulfate", id <- 1:10)


# Part 2
# Write a function that reads a directory full of files and reports the 
# number of completely observed cases in each data file. 
# The function should return a data frame where the first column is the name 
# of the file and the second column is the number of complete cases. 
# A prototype of this function follows
complete <- function(directory, id = 1:332) {
    # 'directory': a char vector of length 1 indicating the location of the csv files
    # 'id': an integer vector indicating the monitor ID numbers to be used
    
    # Return a data frame of the form:
    # id    nobs
    # 1     117
    # 2     1041
    # ...
    # where 'id' is the monitor ID number and 'nobs' is the number of complete cases
    
    dataPath <- paste0(toString(getwd()),"/",directory)
    newDF <- data.frame()
    for(i in id) {
        tmp <- read.csv(paste0(dataPath, "/", sprintf("%03d", i),".csv"))
        tmpDF <- tmp[complete.cases(tmp), ]
        tmpNumRow <- nrow(tmpDF)
        outTmp <- c(i, tmpNumRow)
        newDF <- rbind(newDF, outTmp)
    }
    colnames(newDF) <- c("id", "nobs")
    return(newDF)
}

#complete("specdata", c(2,4,8,10,12))


# Part 3
# Write a function that takes a directory of data files and a threshold for 
# complete cases and calculates the correlation between sulfate and nitrate 
# for monitor locations where the number of completely observed cases
# (on all variables) is greater than the threshold. 
# The function should return a vector of correlations for the monitors 
# that meet the threshold requirement. 
# If no monitors meet the threshold requirement, 
# then the function should return a numeric vector of length 0. 
# A prototype of this function follows
corr <- function(directory, threshold = 0) {
    # 'directory': a char vector of length 1 indicating the location of the csv files
    # 'threshold': a numeric vector of length 1 indicating the number of 
    # completely observed observations (on all vars) required to compute
    # the correlation between nitrate and sulfate; default is 0
    
    # Return a numeric vector of correlations
    # NOTE: Do not round the result!
    
    correlations <- numeric() # Create a vector to store the correlations
    # List all files in the directory
    fileList <- list.files(directory, full.names = TRUE)

    # Process each file
    for (file in fileList) {
        #print(file)
        # Read the data from the file
        data <- read.csv(file)

        # Check for complete cases
        completeCases <- complete.cases(data)
        numCompleteCases <- sum(completeCases)
        
        # If the number of complete cases is greater than the threshold
        if (numCompleteCases > threshold) {
            # Calculate the correlation and add it to the vector
            correlations <- c(correlations, cor(data$sulfate[completeCases], data$nitrate[completeCases]))
        }
    }
    
    return(correlations)
}
#result <- corr("specdata", 400)
#head(result)
















