## Code we ran in Intro to R
## Week 1 Session 2

# here is a simple operation using the variables x and y
x <- 10
y <- x * 10
is.vector(y)
y

# get the expression that makes up that operation
exp <- quote(y <- x * 10)
exp

# parse the syntax tree of the expression using the ast() function
install.packages("pryr")
library(pryr)

ast(x <- 10)

# object naming and modification
## naming at creation
x <- list(1, "list")

## naming through modification
names(x) <- c("number", "type")

## naming with a modified copy
x <- setNames(list(1, "list"), c("number", "type"))
str(attributes(x))

# creating expressions
num.range <- 1:100
num.mean <- mean(num.range)

string <- "this is a string"
?gsub

string.sub <- gsub("s", "$", string)

ast(string.sub <- gsub("s", "$", string))

# the factor class
## predefined categorical levels
x <- as.factor(1:10)

## view levels
levels(x)

## this will throw an error
mean(x)
## as will this attempt to assign a new value to predefined level
x[3] <- 3.5


# multi-dimensional structures (grid structures)
## homogeneous matrices and arrays
x <- matrix(1:10, c(2,5))
x

y <- array(1:12, c(2,3,2))
y 

## heterogeneous data frames
shows <- data.frame(character = c("Kirk", "Picard", "Janeway"),
                    show = c("Star Trek", "TNG", "Voyager"),
                    show.order = c(1,2,3), stringsAsFactors = FALSE)

# view column names
colnames(shows)

# change all column names
colnames(shows) <- c("captains", "show", "show.order")

# changing one column name involves subsetting
colnames(shows)[colnames(shows) == 'show'] <- 'show.name' #or
colnames(shows)[2] <- 'show.name'

# let's load the dataset we'll be using a lot in class
## data pulled from data.ny.gov with script mobile.violations.R
traffic <- read.csv("traffic.csv", stringsAsFactors = FALSE)

# exploring the dataset
str(traffic)
summary(traffic)
colnames(traffic)

