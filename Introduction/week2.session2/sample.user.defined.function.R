# generate a sample of size n of dates of type character vector
## create a sample of size 25: make.date(25)
make.date <- function(n, first = as.Date("1900-01-01"), last = Sys.Date()) {
  as.Date(sample.int(last - first, n), origin = first)
}

