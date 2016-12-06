# code we ran in class
## week 4 session 1


library(lubridate)

# import the winning NY lotto dataset
download.file("https://raw.githubusercontent.com/ursulakaczmarek/Rlab/master/Introduction/week4.session1/lotto.csv",
              "lotto.csv")

lotto <- read.csv("lotto.csv", stringsAsFactors = FALSE)

# coerce to proper date format
lotto['drawdate'] <- ymd(lotto$drawdate)

# take a random sample of 150
lotto <- lotto[sample(1:nrow(lotto), 150,
                               replace=FALSE), ]

# frequency histogram 
hist(lotto$num1, freq = TRUE, breaks = 60)
hist(lotto$num5, freq = TRUE, breaks = 60)
hist(lotto$num5, freq = TRUE, breaks = 60, xlim = (c(0,60)))

# probability density (expected prob. = 1/60 or 0.01667)
hist(lotto$num5, freq = FALSE, breaks = 60, xlim = c(1,60), ylim = (c(0.00, 0.20)))
hist(lotto$num1, freq = FALSE, breaks = 60, xlim = c(1,60), ylim = (c(0.00, 0.20)))

# scatterplots and regression
plot(num5~num1, lotto)
plot(num5~num1, lotto, xlim = c(1,60), ylim = c(1,60))

# estimated slope (estimate of the multiplier of num1, the independent variable)
line <- lm(num5~num1, lotto)
abline(line, lwd=3, col="red")
summary(line)

plot(num5~num1, lotto, xlim = c(1,60), ylim = c(1,60),
     pch=17, cex=1, col = "blue")
abline(line, lwd=5, col="green")
abline(h=mean(lotto$num5),col="red",lwd=2)
abline(v=mean(lotto$num1),col="red",lwd=2)

# visualizing all numbers on the plot 
plot(lotto[,-c(1:3)], xlim = c(1,60), ylim = c(1,60))

# with overlay
plot(lotto$num1, xlim = c(1,60), ylim = c(1,60), pch = 20, col = "purple")
points(lotto$num2, pch=20, col="blue")
points(lotto$num3, pch=20, col="green")
points(lotto$num4, pch=20, col="yellow")
points(lotto$num5, pch=20, col="red")

# boxplot
boxplot(lotto$num1, lotto$num2, lotto$num3, lotto$num4, lotto$num5)
