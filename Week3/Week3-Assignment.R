# Week 3 Assignment

makeVector <- function(x = numeric()) {
    m <- NULL
    print(paste0(cat("m1: "), m))
    set <- function(y) {
        x <<- y
        print(paste0(cat("x: "), x))
        print(paste0(cat("y: "), y))
        m <<- NULL
        print(paste0(cat("m2: "), m))
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}

cachemean <- function(x, ...) {
    m <- x$getmean()
    print(paste0(cat("cachemean m1: "), m))
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    print(paste0(cat("cachemean data: "), data))
    m <- mean(data, ...)
    print(paste0(cat("cachemean m1: "), m))
    x$setmean(m)
    print(paste0(cat("cachemean x$setmean(m): "), x$setmean(m)))
    m
    print(paste0(cat("cachemean m: "), m))
}

# Create a special vector with initial values
v <- makeVector(c(1, 2, 3, 4, 5))

# Calculate and cache the mean
mean1 <- cachemean(v)
print(mean1)  # This will compute the mean and output it

# Get the cached mean
mean2 <- cachemean(v)
print(mean2)  # This will fetch the cached mean and output it

# Update the vector
v$set(c(10, 20, 30, 40, 50))

# Recalculate and cache the new mean
mean3 <- cachemean(v)
print(mean3)  # This will compute and output the new mean
mean4 <- cachemean(v)
print(mean4)  # This will fetch the cached mean and output it



## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
    # check if x is a matrix
    if(is.matrix(x)) {
        print("It is a matix, continue...")
        m <- NULL
        #print(paste0(cat("m1: "), m))
        set <- function(y) {
            x <<- y
            m <<- NULL
        }
        get <- function() x
        setinverse <- function(solve) m <<- solve
        getinverse <- function() m
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
    } else {
        print("x is not a matrix... input a matrix to use the function...")
        return(message("The matrix is'n invertible."))
    }
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    m <- x$getinverse()
    print(paste0(cat("cacheSolve m1: "), m))
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    print(paste0(cat("cacheSolve data: "), data))
    m <- solve(data, ...)
    print(paste0(cat("cacheSolve m1: "), m))
    x$setinverse(m)
    print(paste0(cat("cacheSolve x$setinverse(m): "), x$setinverse(m)))
    m
    print(paste0(cat("cacheSolve m: "), m))
}


# make matrix
# Create a special matrix with initial values
m <- makeCacheMatrix(matrix(c(1,2,3,4),ncol=2,nrow=2))

# Calculate and cache the inverse
inv1 <- cacheSolve(m)
print(inv1)  # This will compute the inverse and output it

# Get the cached inverse
inv2 <- cacheSolve(m)
print(inv2)  # This will fetch the cached inverse and output it


































