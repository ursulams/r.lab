
# script to create NY winning lotto dataset

library(RSocrata)

# import lotto numbers
url <- "https://data.ny.gov/resource/7pxf-c5iz.json"

# read the dataset into R
lotto <- read.socrata(url)

# coercing to proper data type
lotto['cash_ball'] <- as.numeric(lotto$cash_ball)

# function to split winning numbers into 5 cols
lotto <- setNames(data.frame(lotto, do.call(rbind, 
                                            strsplit(lotto$winning_numbers, split = " "))),
                  c("cashball", "drawdate", "winningnums",paste0("num", 1:5)))

# convert factor class to numeric class for number columns
to.num <- function(x){
  as.numeric(levels(x))[x]
}

lotto[,4:8] <- lapply(lotto[,4:8], to.num)

write.csv(lotto, file="lotto.csv", row.names = FALSE)
