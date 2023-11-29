## Week 3: Loop Functions and Debugging
## Loop functions: lapply, apply, tapply, split, mapply
## Debugger, Parts 1-3

# Learning Objectives
# By the end of this week you should be able to:
#   Define an anonymous function and describe its use in loop functions [see lapply]
#   Describe how to start the R debugger for an arbitrary R function
#   Describe what the traceback() function does and what is the function call stack


# When programming, for and while loops are useful, 
# but not easy when working interactively on the cli

# To make life easier when looping, you can use the following functions:
#   lapply: Loop over a list and evaluate a function on each element
#   sapply: Same as lapply but try to simplify the result
#   apply:  Apply a function over the margins of an array
#   tapply (I.E., TABLE APPLY): Apply a function over subsets of a vector
#   mapply: Multivariate version of lapply
# An auxillary FN split is also useful, particularly in conjunction with lapply
# split doesn't apply anything to objects, 
# but useful because it splits objects into subpieces


# Loop Functions - lapply
# Takes three arguments
#   (1): a list x
#   (2): a function (or name of a function) FUN
#   (3): other arguments via its... argument (can be the functions arguements)
# If x is not a list, it will be coerced to a list using as.list
# Actual looping is done internally in C code
# lapply always returns a list, regardless of the class of the input
# RETURNS A LIST
x <- list(a = 1:5, b = rnorm(10))
lapply(x, mean) # gets mean of each element

x <- 1:4
lapply(x, runif) # runif generates random deviates.. use ?runif to get more info
lapply(x, runif, min = 0, max = 10) # change default arguments in runif

# anon functions are fns without names, can generate them on the fly

# an anon fn for extracting the 1st col of each matrix
x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))
lapply(x, function(elt) elt[,1]) # [row, col], so here we take all rows for col 1, apply that for both matrices
# gets 1st col of a and b
# anon fn used heavily, need to write function on spot since most aren't already available

# SAPPLY
# Will try to simplify results of lapply if possible
#   If the result is a list where every element is length 1, then a vector is returned
#   If the result is a list where every element is a vector of the same length (>1), a matrix is returned
#   If it can't figure things out, a list is returned
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d = rnorm(100,5))
lapply(x, mean)
sapply(x, mean) # easier/nicer to get a vector back w all the numbers

# Loop Functions - apply
# apply: used to eval a FN (often an anon one) over the margins of an array
#   It is most often used to apply a FN to the rows or cols of a matrix
#   It can be used with general arrays, e.g., taking the avg of an array of matrices
#   It is not really faster then writing a loop, but it works in one line! 
#   Requires less typing!
# Returns a VECTOR
### apply
### > str(apply)
### function(x, MARGIN, FUN, ...)
###     x is an array
###     MARGIN is an integer vector indicating which margins should be "retained"
###     FUN is a function to be applied
###     ... is for other arguments to be passed to FUN
x <- matrix(rnorm(200), 20, 10) # 20 rows and 10 cols
apply(x, 2, mean) # calculate the mean of each col
apply(x, 1, sum) # calculate the sum of each row

# col/row sums and means
# For sums and means of matrix dimensions, shortcuts are available:
#   rowSums = apply(x, 1, sum)
#   rowMeans = apply(x, 1, mean)
#   colSums = apply(x, 2, sum)
#   colMeans = apply(x, 2, mean)
# The shortcut functions are MUCH FASTER, but you won't notice unless using large matrix

# Other ways to apply "apply"
# Quantiles of the rows of a matrix
x <- matrix(rnorm(200), 20, 10)
apply(x, 1, quantile, probs = c(0.25, 0.75)) #go through each row of matrix and calc 25th and 75th percentile of each row
# apply will create matrix that has 2 rows and numcol=numrows in this matrix, so 20
# so 2x20 matrix (2 rows, 20 cols)

# average matrix in an array
a <- array(rnorm(2 * 2 * 10), c(2, 2, 10)) # 2 rows, 2 col, 3rd dim = 10
# bunch of 2x2 matrices stacked 10 times
apply(a, c(1, 2), mean) # average of 2x2 matrices. keep first and 2nd dim (1, 2) and collapse third
# will take array and collapse it (avg over 3rd dim) and give mean matrix

rowMeans(a, dims = 2) # dims = 2 means only 2 dimensions
rowMeans(a, dims = 1) # dims = 1 means only 1 dimension


# Loop Functions - mapply (multivariate version of lapply, sapply)
# RECALL: lapply,sapply, both apply function over a single list (input is one list)
# What happens if you have two lists? - could write a for loop
# mapply is a multivariate apply of sorts which applies a fn in parallel over a set of args
# > str(mapply)
# function(FUN, ..., MoreArgs = NULL, SIMPLIFY = TRUE, USE.NAMES = TRUE)
# FUN: a function to apply. # of args that fn takes has to be at least as many as the # of lists you pass in mapply
# ...: contains arguments to apply over. if have 3 lists then pass 3 objects, then fn has to take at least 3 arguments
# MoreArgs: a list of other arguments to FUN
# SIMPLIFY: indicates whether the result should be simplified

# Following is tedious to type:
list(rep(1, 4), rep(2, 3), rep(3, 2), rep(1, 4)) # repeat 1 four times, and so on...

# Instead we can do:
mapply(rep, 1:4, 4:1)

# MAPPLY CAN BE USED TO APPLY A FN TO MULTIPLE SETS OF ARGUEMENTS.

# Vectorizing a Function
noise <- function(n, mean, sd) {
    rnorm(n, mean, sd)
}
noise(5, 1, 2) # get 5 random norm vars with mean 1 and sd 2
noise(1:5, 1:5, 2) # function doesn't work correctly when pass it a vector of args
# want: 1 random norm with mean 1, two random normals with mean 2, three random normals with mean 3, etc
# need to use mapply
mapply(noise, 1:5, 1:5, 2)
# this is correct way to vectorize a function that doesn't allow vector args (as seen above)
# this is the same as:
list(noise(1, 1, 2), noise(2, 2, 2),
     noise(3, 3, 2), noise(4, 4, 2), 
     noise(5, 5, 2))



# Loop Functions - tapply
# tapply is used to apply a function over subsets of a vector.
# > str(tapply)
# function(X, INDEX, FUN = NULL, ..., SIMPLIFY = TRUE)
# X is a vector
# INDEX is a factor or a list of factors (or else they are coerced to factors)
# FUN is a function to be applied
# ... contains other arguments to be passed FUN
# simplify, should we simplify the results?

# -- useful for calculating summary statistics, i.e., subset of different groups of data, gender

# Example: take group means
x <- c(rnorm(10), runif(10), rnorm(10, 1)) # vector of three groups, 10 normals, 10 uniforms, 10 normals
# rnorm(10) = 10 normals of mean 0; rnorm(10, 1) = 10 normals of mean 1
f <- gl(3, 10) # creating a factor variable using gl function; 3 levels, each repeated 10 times
f

tapply(x, f, mean) # tapply on x, pass x to the factor variable f in the mean function
# allows to take the mean of each group of numbers in x
# So using the classifications of f, we get the means of each group in x
# get a vector of three for each group

# Take group means without simplification
tapply(x, f, mean, simplify = FALSE)
# get a list if don't simplify...

# Find group ranges
tapply(x, f, range)


# Loop Functions - split
# split: takes a vector or other objects and splits it into groups determined by a factor or list of factors
# > str(split)
# function (x, f, drop = FALSE, ...)
# x is a vector (or list) or dataframe
# f is a vector (or coerced to one) or a list of factors
# drop indicates whether empty factors levels should be dropped

# split can be used in conjunction with lapply, sapply
# once split is done (data is split into groups based on f), you can use lapply or sapply

x <- c(rnorm(10), runif(10), rnorm(10, 1)) # rnorm(10) 10 normals of mean 0; rnorm(10, 1) 10 normals of mean 1
f <- gl(3, 10)
split(x, f) # split into three parts bc factor has three levels,  
# get list of 3 elements: 1. 10 normals, 2. 10 uniforms, 3. 10 normals
# to do something with this list can use lapply or sapply:
lapply(split(x, f), mean)
# in this case, better to just use tapply bc more compact

# split can be used to split a dataframe
library(datasets)
head(airquality)
# split data into months then calc mean of other vars
s <- split(airquality, airquality$Month)

lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")])) 
# now that data is split by Month
# can calculate the mean for each variable for each month
# if missing values, can't take mean... why values for Ozone are NA

# Can also use sapply, which will simplify results by instead of returning a list, 
# will return a matrix; 3 rows and 5 cols
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm = TRUE)) #  removes missings so NA no longer showing for Ozone values

# Splitting on more than one level
x <- rnorm(10)
f1 <- gl(2, 5) # 2 levels
f2 <- gl(5, 2) # 5 levels
f1
f2
interaction(f1, f2) # combine all the levels of the 1st factor with all the levels of the 2nd factor
# will print out 10 level (2 x 5)

str(split(x, list(f1, f2))) # split numeric var x
# when use split fn don't need to use interaction fn
# can just pass a list with the 2 factors and will automatically call the interaction function
# and create 10 level interaction factor
# returns list with 10 interaction level and the elements of the numeric factors that are within those 10 levels
# some empty levels...
# can use argument drop to drop the empty levels
str(split(x, list(f1, f2), drop = TRUE))


# Debugger Tools - Diagnosing the Problem
# Three main levels of indication:
# message*: A generic notification/diagnostic message produced by the message function; 
#           execution of the function continues
# warning*: An indication that something is wrong but not necessarily fatal; .
#           execution of the function continues; generated by the warning function
#           - Get warning at end of execution
# error*: An indication that a fatal problem has occurred; execution stops; 
#           produced by the stop function
# condition: A generic concept for indicating that something unexpected can occur
#           programmers can create their own conditions

log(-1) # basic warning
# Warning Message below:
#[1] NaN
#Warning message:
#    In log(-1) : NaNs produced

# filter for nas when writing functions/conditional statements to prevet error or warning messages

# DEBUGGING QUESTIONS TO ASK YOURSELF
# 1. What was your input? How did you call the function?
# 2. What were you expecting? Output, messages, other results?
# 3. What did you get?
# 4. How does what you get differ from what you were expecting?
# 5. Were your expectations correct in the first place?
# 6. Can you reproduce the problem (exactly)?


# Debugger Tools - Basic Tools
# Primary tools for debugging functions in R are:
# 1. traceback: prints out the function call stack after an error occurs; 
#       does nothing if there's no error
#       -- tells you how many function calls you're in and where the error occurred
#       -- tells you where in the function call the error occurs
# 2. debug: flags a function for "debug" mode which allows you to step through 
#       execution of a function one line at a time
# 3. browser: suspends the execution of a function wherever it is called and 
#       puts the function in debug mode
# 4. trace: allows you to insert debugging code into a function a specific places
# 5. recover: allows you to modify the error behavior so that you can browse 
#       the function call stack

# Debugger Tools - Using the Tools
# Have to call traceback immediately after the error occurs
# traceback will only give most recent error
# if you execute another fn and no error then no traceback to give
# therefore, need to call traceback right away

mean(xy) 
traceback() # not useful... know it is mean that is causing error.
lm(xy-yx)
traceback() # error occurs 4 levels deep

#debug function
# can debug any FN whether you wrote it or not
# will print out entire FN value code
# then you get prompt at bottom with browser (you are now in browser)
# browser like R workspace

debug(lm)
lm(x - y)
# press n to move through function

#recover function
options(error = recover)
read.csv("nofileExists") # same as what you'd get back if you used traceback
# can go through all function call stacks
# error occurred at last level (3rd in this case)
# can press number and browse that function (see env)
# If have long fn call stack can go through all the fns to find where the error occurs

# Debugging: Summary
# 3 main indications of a problem/condition: message, warning, error
#   Only an error is fatal
# When analyzing a fn with a problem, make sure you can reproduce the problem;
#   clearly state your expectations and how the output differs from your expectation
# Interactive debugging tools: traceback, debug, browser, trace, and recover
#   can be used to find problematic code in functions
# Debugging tools are not a substitute for thinking!



# What is vapply?














