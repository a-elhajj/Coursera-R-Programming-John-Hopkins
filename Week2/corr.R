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
        print(file)
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
result <- corr("specdata", 400)
head(result)

