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

complete("specdata", c(2,4,8,10,12))
