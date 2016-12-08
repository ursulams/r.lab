# code we ran in class
## week4 session2

library(ggplot2)

# creating a basic ggplot
# basic dot plot of cashball values with date range formatting
ggplot(lotto, aes(x = drawdate, y = cashball, color = cashball)) +
  geom_point() +
  scale_x_date(date_labels = "%b %y")

# same plot of number picks
# first let's format our data from wide to long using the tidyr package

library(tidyr)

lotto <- gather(lotto, pick, number, num1:num5)

ggplot(lotto, aes(x = drawdate, y = number, color = pick)) +
  geom_point() +
  scale_x_date(date_labels = "%b %y")

# apply a different color scale 
ggplot(lotto, aes(x = drawdate, y = number, color = pick)) +
  geom_point() +
  scale_x_date(date_labels = "%b %y") +
  scale_color_brewer()

ggplot(lotto, aes(x = drawdate, y = number, color = pick)) +
  geom_point() +
  scale_x_date(date_labels = "%b %y") +
  scale_color_brewer(type = "div", palette = 7)

# the ggplot histogram
ggplot(lotto, aes(x = number)) +
  geom_histogram(bins = 100, fill = 8, color = 9) 

ggplot(lotto, aes(x = number)) +
  geom_histogram(bins = 100, aes(fill = ..count..))
  
ggplot(lotto, aes(x = number, fill = pick)) +
  geom_histogram(bins = 100) +
  scale_fill_brewer(type = "div", palette = 7) +
  scale_x_continuous(breaks = seq(1,60,2))

# faceting
ggplot(lotto, aes(x = number, y = pick, color = pick)) +
geom_point() +
facet_grid(facets = month(drawdate) ~ year(drawdate))

ggplot(lotto, aes(x = number, y = pick, color = pick)) +
  geom_point() +
  facet_wrap(~ month(drawdate), ncol = 6)

