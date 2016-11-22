# Code we ran in Intro to R
## Week 2 Session 1

# read in our traffic dataset and call it traffic
traffic <- read.csv("traffic.csv", stringsAsFactors = FALSE)

# get an overview of the data
str(traffic)


# let's look at the number of people getting ticketed
## broken down by state
table(traffic$licensed)

## we can sort in ascending order
sort(table(traffic$licensed))
## or descending
sort(table(traffic$licensed), decreasing = TRUE)

# two variables in the contintency table (like a pivot table) 
table(traffic$licensed, traffic$gender)

# subsetting columns
# we can subset based on column name
traffic$weekday

# this will print out exactly the same thing but R simplifies it to a character vector
traffic[[7]]
## if you're creating an assignment and want to keep it as a data frame
traffic.weekday <- traffic[7]

# subsetting single row
## R subsets dfs with a [row, column] index
traffic[1, ]

# subsetting more than one column
## use single square brackets
traffic[c("court", "weekday")] #or
traffic[c(1,7)]

# subset the first ten rows on the data
## note the comma! we need it tell R to focus on the row part of the index
traffic[1:10, ]
## subset rows 10 and 15
traffic[c(10, 15), ]

# subsetting to tickets issued in the Bronx
## what is the Bronx court called?
table(traffic$court) 

# logical subsetting: note the indexing and the double equal sign!
## we're not assigning values, so we use a double equal sign operator
bronx <- traffic[traffic$court == "BRONX TVB", ]

# logical subsetting on two values 
## using the pipe operator
manhattan <- traffic[traffic$court == "MANHATTAN NORTH TVB" | 
                     traffic$court == "MANHATTAN SOUTH TVB", ]
## using 'in'
manhattan <- traffic[traffic$court %in% 
                     c("MANHATTAN NORTH TVB", "MANHATTAN SOUTH TVB"), ]

# the subset() function
brooklyn.north <- subset(traffic, court == "BROOKLYN NORTH TVB")
brooklyn.south <- subset(traffic, court == "BROOKLYN SOUTH TVB")

# bind the rows of brooklyn north and brooklyn south into a single df
brooklyn <- rbind(brooklyn.north, brooklyn.south, make.row.names = FALSE)

# create unique ID for brooklyn rows and add it to the df using cbind()
unique.id <- 1:nrow(brooklyn)
brooklyn <- cbind(unique.id, brooklyn)
