# Week 3 Quiz

# Question 1
library(datasets)
data(iris)

head(iris)

# split data into months then calc mean of other vars
species <- split(iris, iris$Species)

sapply(species, function(x) colMeans(x[, c("Sepal.Length", "Sepal.Width",
                                           "Petal.Length", "Petal.Width")], 
                                     na.rm = TRUE))
tapply(iris$Sepal.Length, iris$Species, mean, na.rm = TRUE) # BETTER

# Question 2
# Guess before coding: (A)
apply(iris[, 1:4], 2, mean) # keeps first 4 cols, and all rows, calculates mean. RIGHT ANSWER
colMeans(iris) # error since species is not int
apply(iris, 1, mean) # calculates mean of each row BUT warnings since species is not int
apply(iris, 2, mean) # calculates mean of each col BUT warnings since species is not int
apply(iris[, 1:4], 1, mean) # removes species col but calculates rows
rowMeans(iris[, 1:4]) # do not need to calculate row means

# Question 3
library(datasets)
data(mtcars)
head(mtcars)


# calculate avg miles per gallon (mpg) by # of cylinders in the car (cyl)?
tapply(mtcars$mpg, mtcars$cyl, mean, na.rm = TRUE) # Correct


split(mtcars, mtcars$cyl) # NO - just splits dataset by cyl column
mean(mtcars$mpg, mtcars$cyl, na.rm = TRUE, trim = 0) # NO - ERROR need trim
with(mtcars, tapply(mpg, cyl, mean)) #YES - within the with statement it does not alter the OG dataset, good for quick computations
tapply(mtcars$cyl, mtcars$mpg, mean) # NO - Needs to be flipped.. calc the mpg by cyl
sapply(split(mtcars$mpg, mtcars$cyl), mean) # YES
lapply(mtcars, mean) # NO - calculates the col means
apply(mtcars, 2, mean) # NO - calcs the col means
tapply(mtcars$mpg, mtcars$cyl, mean) # YES
sapply(mtcars, cyl, mean) #NO - ERROR. Second arg needs to be FN


# Question 4: abs diff between avg horsepower of 4-cyl and avg horsepower of 8-cyl cars

avgHP4Cyl <- sapply(split(mtcars$hp, mtcars$cyl == 4), mean)[2]
avgHP8Cyl <- sapply(split(mtcars$hp, mtcars$cyl == 8), mean)[2]
abs(avgHP4Cyl-avgHP8Cyl)
abs(avgHP8Cyl-avgHP4Cyl)

# Question 5: 
debug(ls)
ls()

# what happens when you call the ls function?
# A: Execution of 'ls' will suspend at the beginning of the function 
#       and you will be in the browser.