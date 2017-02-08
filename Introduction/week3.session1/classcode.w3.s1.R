# code we ran in intro to R
## week 3 session 1

library(RSocrata)

# importing online data directly into R
## identify API endpoint for the dataset
## specify search terms just like in SQL (here we limit to incidents with at least one fatality)
url <- "https://data.cityofnewyork.us/resource/qiz3-axqb.json?$where=number_of_persons_killed > 0"

# read the dataset into R
wrecks <- read.socrata(url)


# read in data using alternative method
download.file("https://raw.githubusercontent.com/ursulakaczmarek/Rlab/master/Introduction/week3.session1/wrecks.csv", "wrecks.csv")
wrecks <- read.csv("wrecks.csv")


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

## total number of cyclists killed per wreck indexed by borough
## table(index, x) == tapply(x, index, sum)
table(wrecks$borough, wrecks$number_of_cyclist_killed)

# frequency tables
table(wrecks$contributing_factor_vehicle_1, wrecks$borough)
table(wrecks$contributing_factor_vehicle_1, wrecks$number_of_persons_killed)

# test to see if there's an association between two categorical variables
## data not a random sample, so code for instruction only
chi.table <- xtabs(~vehicle_type_code1 + contributing_factor_vehicle_1, data = wrecks)
summary(chi.table)
