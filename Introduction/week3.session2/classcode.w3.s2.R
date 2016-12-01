# code we ran in intro to R
## week 3 session 2

# base R date functions
## convert character vector to date using strptime()
## we need to look up format abbreviations

?strptime
char.date <- "01/01/2000"
class(char.date)
char.date2 <- strptime(char.date, format = "%m/%d/%Y")
class(char.date2)

# date class coerced using as.Date()
char.date3 <- as.Date(char.date, format = "%m/%d/%Y" )
class(char.date3)
weekdays(char.date3)

# let's add a weekday field to our wrecks dataset
wrecks['weekday'] <- weekdays(wrecks$date)

# calcuate days passed
Sys.Date() - char.date3

# lubridate functions
library(lubridate)
char.date4 <- "010116"
char.date4 <- mdy(char.date4)

# date formats found in financial data
library(zoo)
date.qtr <- "20163"
as.yearqtr(date.qtr, format = "%Y%q")

# number sequences and sampling 
## simple range
1:20

## same range, but with an increment argument
seq(1,20, 2)

## date range
seq.Date(char.date3, char.date4, by = "month")

## create date and quarter data frame to bind to other data
from.date <- dmy(01012000)
to.date <- dmy(01102015)
date.qtr <- data.frame(date = seq.Date(from.date, to.date, by = "quarter"), quarter = c("Q1", "Q2", "Q3", "Q4"))

# creates a new data frame which is a simple random sample
sample.wrecks <- wrecks[sample(1:nrow(wrecks), 200,
                               replace=FALSE), ]
