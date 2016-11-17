# script to load and parse data on mobile phone use tickets issued by the NYPD since 2015
## write to file for class

library(RSocrata)
library(dplyr)


# read statewide moving violation dataset
url <- "https://data.ny.gov/resource/85dq-q63a.json?violation_charged_code=1225C2A&violation_year=2015"

traffic <- read.socrata(url)

# concatenate month and year, subset to violation type and issuer
traffic  %<>%
  filter(police_agency == "NYC POLICE DEPT") %>%
  select(court, gender, age = age_at_violation, licensed = state_of_license, department = police_agency, 
         violation = violation_description, weekday = violation_dow, violation_month, violation_year) 

write.csv(traffic, file="traffic.csv", row.names = FALSE)
