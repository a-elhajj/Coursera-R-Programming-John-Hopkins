#Coursera R Programming Notes
#Week 2:
#  Different ways of writing if statement
# 1
if(x > 3) {
    y <- 10
} else {
    y <- 0
}

# 2
y <- if(x > 3) {
    10
} else {
    0
}


# for loop
for(i in 1:10){
    print(i)
}

x <- c("a", "b", "c", "d")

for(i in 1:4){
    print(x[i])
}

for(i in seq_along(x)){ # seq_along: takes a vector as input and creates integer sequence equal to length of vector. Since x length =4, creates integer sequence of length 4
    print(x[i]) # creates sequence based on length of var x.. BETTER since don't need to know length of vector.
}

for(letter in x){
    print(letter)
}

for(i in 1:4) print(x[i])


# nested
x <- matrix(1:10, 2, 5)
x
for(i in seq_len(nrow(x))){ #seq_len: takes integer (num row x) and creates sequence from that. So since x has 2 rows will create sequence 1, 2
    for(j in seq_len(ncol(x))){ #Since x has 5 cols will create sequence 1, 2, 3, 4, 5
        print(x[i,j])
    }
}
# prints all values from row 1 then all values from row 2 sequentially. ie.., 1,3,4,5,7,9,2,4,6,8,10.
# So it goes to row 1, then prints all column values in row 1 then goes to row 2 then prints and col values in row 2

# while
count <- 0
while(count < 10) {
    print(count)
    count <- count + 1
}

z <- 5
while(z >= 3 && z <= 10){
    print(paste0("Beginning New z value: ", z))
    coin <- rbinom(1,1,0.5)
    print(paste0("Coin value: ", coin))
    if(coin==1){
        z <- z + 1
    } else{
        z <- z - 1
    }
    print(paste0("End New z value: ", z))
}


# repeat, next, break
# repeat
# only way to exit a repeat loop is to call break
x0 <- 1
tol <- 1e-8

repeat {
    x1 <- mean(x)
    
    if(abs(x1 - x0) < tol) {
        break
    } else {
        x0 <- x1
    }
}

#better to set a hard limit on the num of iters like using a for loop and then report
# whether convergence was achieved or not

# next, return

# next is used to skip an iteration of a loop

for(i in 1:100) {
    if(i <= 20){
        ## skip the first 20 iters
        next
    }
    ## do something here
}
# return signals that a function should exit and return a given value


# apply function better for command line interactive work rather than control structures (if, else, while)



# First R function...
# default values can be used in R like Python
colmeans <- function(y, removeNA = TRUE) {
    nc <- ncol(y) # get num cols in y. nc=6
    print(paste0("nc: ", nc))
    means <- numeric(nc) # creates vector of size nc, ie, creates a 1x6 vector with all 0s
    print(paste0("means: ", means))
    for(i in 1:nc){ #loop through numcols (6) in db 
        means[i] <- mean(y[, i], na.rm = removeNA) # gets the mean for each col that we loop through. Adds the mean to the empty vector we created for that specific col
        print(paste0("means[i]: ", means[i]))
    }
    means
}
# y[, 1] gets all the rows in each column


# FUNCTIONS CAN BE PASSED AS ARGUEMENTS TO OTHER FUNCTIONS
# FUNCTIONS CAN BE NESTED SO THAT YOU CAN DEFINE A FN INSIDE ANOTHER FN
# RETURN VALUE OF A FN IS THE LAST EXPRESSION IN THE FN BODY TO BE EVALUATED

# FORMALS FUNCTION RETURNS A LIST OF ALL THE FORMAL ARGUMENTS OF A FUNCTION

# ... USED WHEN EXTENDING ANOTHER FUNCTION AND YOU DONT WANT TO COPY THE ENTURE ARGUEMNT LIST OF THE ORIGINAL FUNCTION
# ... ALSO NECESSARY WHEN THE NUMBER OF ARGUMENTS PASSED TO THE FN CANNOT BE KNOWN IN ADVANCE
# like in args(paste)... don't know what will be passed so prints ...
# Catch f using ...: any argument that appears after ... on the argument list must be named explicitly and cannot be partially matched
# 



## Lexical Scoping
# Can use a function within a function
make.power <- function(n) {
    pow <- function(x) {
        x^n
    }
    pow
}

cube <- make.power(3)
square <- make.power(2)

cube(3) # using pow function... i.e., 3^3
square(3) # using pow function... i.e, 3^2


ls(environment(cube)) #[1] "n"   "pow"
get("n", environment(cube)) #[1] 3

ls(environment(square)) #[1] "n"   "pow"
get("n", environment(square)) #[1] 2


## Coding Standards
# Always use text editor and save as text file?
# Indent code (4 spaces min, 8 spaces max)
# Limit width of your code (80 cols)
# Limit the length of individual functions (limit to 1 basic activity)


# Dates and Times
# Dates represented by the Date class
# Times represented by POSIXct or the POSIXlt class
# Dates are stored internally as the number of days since 1970-01-01
# Times are stored internally as the number of seconds since 1970-01-01
# as.date("1970-01-01")


