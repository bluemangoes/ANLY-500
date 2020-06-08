##
## Class script - August 30th 2016
##

library(stringr)

## load the january 2015 taxi data set
jan2015 <- read.csv("/Users/Bluemangoes/Downloads/ANLY 500/Aug30/jan2015.csv")

## step 1 - analyze the data file, looking for boundaries, ranges, outliers, and missing data
summary(jan2015)

## look at the structure of the data
str(jan2015)

## look at the names (columns) of the data frame
names(jan2015)

## create a list of the column names
colNames<- names(jan2015)
print (colNames)
colNames

## some typical statistical functions
## mean
## sum
mean(jan2015$trip_distance)
sum(jan2015$trip_distance)
sd(jan2015$trip_distance)
max(jan2015$trip_distance)
min(jan2015$trip_distance)
range(jan2015$trip_distance)
quantile(jan2015$trip_distance)
table(jan2015$payment_type)
table(jan2015$payment_type, jan2015$passenger_count)

## basic bar plot
barplot(table(jan2015$trip_distance, jan2015$passenger_count), col=c(blues9), 
        main = "Distance / Count", xlab="# Passengers", ylab="Count by Distance")

barplot(table(jan2015$trip_distance, jan2015$passenger_count), col=topo.colors(12), 
        main = "Distance / Count", xlab="# Passengers", ylab="Count by Distance")

data()

demo(graphics)

# Stacked Bar Plot with Colors and Legend
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts))

# Grouped Bar Plot
counts <- table(mtcars$vs, mtcars$gear)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)

## correlations...
cor(jan2015$payment_type, jan2015$tip_amount)
cor(mtcars)

## some example descriptive statistics links
## http://www.statmethods.net/stats/descriptives.html
## https://www.r-bloggers.com/r-tutorial-series-summary-and-descriptive-statistics/


