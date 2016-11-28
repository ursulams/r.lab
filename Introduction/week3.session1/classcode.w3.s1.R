# code we ran in intro to R
## week 3 session 1

library(RSocrata)

# importing online data directly into R
## identify API endpoint for the dataset
## specify search terms just like in SQL (here we limit to incidents with at least one fatality)
url <- "https://data.cityofnewyork.us/resource/qiz3-axqb.json?$where=number_of_persons_killed > 0"

# read the dataset into R
wrecks <- read.socrata(url)

# read in ZIP code demographic data using alternative method (for smaller datasets or no query in API call)
download.file("https://data.cityofnewyork.us/resource/rreq-n6zk.csv", "demo.by.zip.csv")
demographics <- read.csv("demo.by.zip.csv")


# examining the wrecks dataset
str(wrecks)

# coercing to proper numeric type
wrecks[, c(3:10, 17, 20)] <- sapply(wrecks[, c(3:10, 17, 20)], as.numeric)

## examine again
str(wrecks)
summary(wrecks)

# summary stats
## average number of persons killed per wreck indexed by borough
tapply(wrecks$number_of_persons_killed, wrecks$borough, mean)
## maximum number of fatalities indexed by borough
tapply(wrecks$number_of_persons_killed, wrecks$borough, max)
## total number of fatalities indexed by borough
tapply(wrecks$number_of_persons_killed, wrecks$borough, sum)

## total number of cyclists killed per wreck indexed by borough
tapply(wrecks$number_of_cyclist_killed, wrecks$borough, sum)

# frequency tables
table(wrecks$contributing_factor_vehicle_1, wrecks$borough)
table(wrecks$contributing_factor_vehicle_1, wrecks$number_of_persons_killed)

# test to see if there's an association between two categorical variables
## data not a random sample, so code for instruction only
chi.table <- xtabs(~contributing_factor_vehicle_1 + vehicle_type_code1, data = wrecks)
summary(chi.table)
