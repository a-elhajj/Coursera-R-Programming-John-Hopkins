
## Question 10
x <- c(3, 5, 1, 10, 12, 6)
x <- c(3, 5, 1, 10, 12, 6)
x[x==0] <- 6
x <- c(3, 5, 1, 10, 12, 6)
x[x<6] == 0
x <- c(3, 5, 1, 10, 12, 6)
x[x>0] <- 6
x <- c(3, 5, 1, 10, 12, 6)
x[x<=5] <- 0 ## good
x <- c(3, 5, 1, 10, 12, 6)
x[x==0] < 6
x <- c(3, 5, 1, 10, 12, 6)
x[x==6] <- 0
x <- c(3, 5, 1, 10, 12, 6)
x[x != 6] <- 0
x <- c(3, 5, 1, 10, 12, 6)
x[x >= 6] <- 0
x <- c(3, 5, 1, 10, 12, 6)
x[x %in% 1:5] <- 0 #good
x <- c(3, 5, 1, 10, 12, 6)
x[x > 6] <- 0
x <- c(3, 5, 1, 10, 12, 6)
x[x < 6] <- 0 #good


# Question 11-20

# Question 11

db = read.csv("hw1_data.csv")
View(db) # shows the values of the csv in table format
nrow(db) # shows the total number of rows in the dataframe
ncol(db) # shows the total number of cols in the dataframe
colnames(db) # returns the col headers or col names
str(db) # returns the structure of the db. Col names with data types and factors

# First two rows of the db
# Method 1: head()
head(db, 2)
# Method 2: indexing
db[1:2, ]
# Method 3: slice() from dplyr
install.packages("dplyr")
library(dplyr)
db %>% slice(1:2)
# Method 4: use read.tabkle and nrows
db_table = read.table("hw1_data.csv", 
                      nrows = 2, 
                      sep = ",",
                      header = TRUE)
db_table

# Question 14 : Last 2 rows
tail(db, 2)

# Question 15
db[47, 'Ozone']
db[47, 1]

# Question 16
good <- sum(complete.cases(db$Ozone))
153-good
# or
sum(is.na(db$Ozone))

# Question 17
good_db <- db[complete.cases(db$Ozone), ]
mean(good_db$Ozone)

# Question 18
good_db <- db[complete.cases(db), ]
preMeandb <- good_db[(good_db$Ozone > 31 & good_db$Temp > 90), ]
mean(preMeandb$Solar.R)

# Question 19
preMeandb <- db[db$Month == 6, ]
mean(preMeandb$Temp)

# Question 20
good_db <- db[complete.cases(db), ]
preMaxdb <- good_db[good_db$Month == 5, ]
max(preMaxdb$Ozone)




