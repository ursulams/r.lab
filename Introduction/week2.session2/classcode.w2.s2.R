library(stringr)

# load our traffic dataset
traffic <- read.csv("C:/Users/ukaczmarek/Documents/traffic.csv", stringsAsFactors = FALSE)

# create a character vector called 'borough'
## use str_replace() from the stringr package to create the borough character strings
borough <- str_replace(traffic$court, " .*$", "")
## don't forget to rename to Staten Island
borough <- str_replace(borough,"RICHMOND", "STATEN ISLAND")

# bind the borough column to the front of the traffic df
traffic <- cbind(traffic, borough, stringsAsFactors = FALSE)

# user-defined function to find the mode of an object in our dataset
## based on the sort(table(x)) functions we used earlier to create contingency tables

find.mode <- function(x){
  sort(table(x), decreasing = TRUE)[1]
}

# apply the function to a single column
find.mode(traffic$borough)

# apply it to the whole dataframe
lapply(traffic, find.mode) # returned as a list


# using a user-defined function to create the borough column
create.borough <- function(traffic, borough, court) {
  traffic['borough'] <- sapply(traffic['court'], 
                               function(court) str_replace_all(court, 
                                                  c(" .*$"="", "RICHMOND"="STATEN ISLAND")))
  return(traffic)
}

traffic <- create.borough(traffic)

