## Code we ran in Intro to R
## Week 1 Session 1

# installs the package in your library 
## (don't forget the quotes!)
install.packages("stringr") 

# loads the package for that R session 
## (with or without quotes)
library(stringr) 

# let's create atomic vectors of length three
x <- c("a", "character", "string") # atomic vector of type character
y <- c(1.0, 2.5, 3) # atomic vector of type numeric
z <- c(1L, 2, 3) # atomic vector coerced to numeric
tf <- c(TRUE, FALSE, 1) # atomic vector coerced to numeric
typeof(tf)
class(tf)
is.atomic(tf)
length(tf)

# let's create some more atomic vectors
## create a character string of length one with your name and assign it to a variable called 'my.name'
## do we need the c() function if its a vector of length one?
my.name <- "first.name last.name"

# let's create a variable called 'intro' with a character string of length one where we say "my name is"
intro <- "my name is"

# let's create a third string called 'my.intro' in which we paste together intro and my.name using the str_c function from the stringr package
## remember you don't have to write out your strings again, just write the variable names
## let's look up the str_c function to see what arguments it takes
my.intro <- str_c(intro, my.name, sep = " ")


# let's create a list of length three
x <- list("list", "of", 3)
class(x)
is.list(x)
is.atomic(x)
length(x)

# create a list named 'my.intro.list' out of the my.name and intro variables
my.intro.list <- list(intro, my.name)

# creating objects
captains <- c("Kirk", "Picard", "Janeway") # object is a vector of class character
all.captains <- data.frame(character = captains,
                           show = c("Star Trek", "ST:TNG", "ST:Voyager"),
                           show.order = c(1,2,3), stringsAsFactors = FALSE) # object is a data frame

# learn on your own with Swirl
install.packages("swirl")
library(swirl)
 
