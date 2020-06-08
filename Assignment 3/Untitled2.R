##
## Analysis 500 Section 51
## September 6th, 2016
##

## create a list of example dates - used to demonstrate
## the support functions.
datesList <- c("2016-06-12 11:23:25", 
               "2016-06-13 07:35:25", 
               "2016-06-14 07:35:25", 
               "2016-06-15 21:23:25", 
               "2016-06-16 07:35:25", 
               "2016-06-17 22:23:25", 
               "2016-06-18 07:35:25", 
               "2016-06-19 21:23:25", 
               "2016-01-16 21:23:25", 
               "2016-02-16 17:23:25")

## pull the first date out of the dateList
singleDate <- datesList[[1]]

## -------------------------------------------------------
## function to convert the hour of the day to a part of the day
getPartOfDay <- function(vector) {
  split1 <- strsplit(paste(vector), " ")
  split2 <- strsplit(split1[[1]][2], ":")
  hour <- as.numeric(split2[[1]][1])
  if (hour >= 0 && hour < 5) {
    return ("Night")
  } else if (hour > 4 && hour < 12) {
    return ("Morning")
  } else if (hour > 11 && hour < 17) {
    return ("Afternoon")
  } else if (hour > 16 && hour < 21) {
    return ("Evening")
  } else
    return ("Night")
}

## -------------------------------------------------------
## function to calculate day/night from the date/time
getDayNight <- function(vector) {
  split1 <- strsplit(paste(vector), " ")
  split2 <- strsplit(split1[[1]][2], ":")
  hour <- as.numeric(split2[[1]][1])
  if (hour < 5 || hour > 20) {
    return ("Night")
  } else
    return ("Day")
}

## -------------------------------------------------------
## function to calculate name of the day (Saturday, Sunday, etc.)
getDayName <- function(vector) {
  split1 <- strsplit(paste(vector), " ")
  dayName <- weekdays(as.Date(split1[[1]][1]))
  return (dayName)
}

## -------------------------------------------------------
## function to calculate the day number of the week from the date/time string
getDayOfWeek <- function(vector) {
  split1 <- strsplit(paste(vector), " ")
  dateIs <- as.POSIXlt(split1[[1]][1])
  return (dateIs$wday)
}

## -------------------------------------------------------
## function to calculate the day number of the week from the date/time string
getDayOfMonth <- function(vector) {
  split1 <- strsplit(paste(vector), " ")
  dateIs <- as.POSIXlt(split1[[1]][1])
  return (dateIs$mday)
}

## -------------------------------------------------------
## function to calculate the day number of the week from the date/time string
getDayOfYear <- function(vector) {
  split1 <- strsplit(paste(vector), "T")
  dateIs <- as.POSIXlt(split1[[1]][1])
  return (dateIs$yday)
}

## -------------------------------------------------------
## function to calculate the seaso
getSeason <- function(vector) {
  split1 <- strsplit(paste(vector), "T")
  dateIs <- as.POSIXlt(split1[[1]][1])
  monthNum <- dateIs$mon
  if (monthNum < 2 || monthNum == 11) {
    return ("Winter")
  } else if (monthNum > 1 && monthNum <= 4) {
    return ("Spring")
  } else if (monthNum >= 5 && monthNum <= 7) {
    return ("Summer")
  } else
    return ("Fall")
}

## alternative date functions
weekdays(as.Date(singleDate))
as.POSIXlt(as.Date(singleDate))$mday

weekdays(as.Date(datesList))
as.POSIXlt(as.Date(datesList))$mday

table(weekdays(as.Date(datesList)))

## calculate number of each day name in the jan2015 dataset
table(weekdays(as.Date(jan2015$tpep_pickup_datetime)))
plot(table(weekdays(as.Date(jan2015$tpep_pickup_datetime))))


Jan2015 <- read.csv("~/HarrisburgUniversity/HU500-51_Fall_2016/Session 3 - Sept 6th Tuesday/Jan2015.csv")

library(ggplot2)
jan2015$dayName <- weekdays(as.Date(jan2015$tpep_pickup_datetime))
dayNameAvg = aggregate(total_amount ~ dayName, data=jan2015, mean)
names(dayNameAvg) = c("dayName", "Average_Total_Amount")
ggplot(dayNameAvg, aes(x = dayName, y = Average_Total_Amount)) + geom_bar(stat = "identity")

## ---------------------------------------------------
## End of support function definitions
## ---------------------------------------------------

getPartOfDay(singleDate)
sapply(datesList, FUN=getPartOfDay)

getDayName(singleDate)
sapply(datesList, FUN=getDayName)

getDayOfWeek(singleDate)
sapply(datesList, FUN=getDayOfWeek)

getDayOfMonth(singleDate)
sapply(datesList, FUN=getDayOfMonth)

getDayOfYear(singleDate)
sapply(datesList, FUN=getDayOfYear)

getSeason(singleDate)
sapply(datesList, FUN=getSeason)

getDayNight(singleDate)
sapply(datesList, FUN=getDayNight)

## let's take a quick look at the different payment types
## generate a frequency distribution of the payment_type records
plot(table(jan2015$payment_type))
## or
hist(jan2015$payment_type)


## one way to handle mapping the top 25...
sorted <- arrange(jan2015, desc(total_amount))
top25 <- select(sorted[1:25,], pickup_latitude, pickup_longitude, total_amount)
myMap <- leaflet(data = top25)
myMap <- addTiles(myMap)
myMap <- addMarkers(myMap,~pickup_longitude, ~pickup_latitude, popup=~as.character(total_amount))
myMap

library(dplyr)
library(leaflet)

nycjan2015h <- jan2015

mapsort <- arrange(nycjan2015h, desc(total_amount))
mapsort25 <- select(mapsort[1:25,], pickup_latitude, pickup_longitude, total_amount)
leafletMap <- leaflet(data = mapsort25)
NYCMap <- addTiles(leafletMap)
NYCMap <- addMarkers(NYCMap, ~pickup_longitude, ~pickup_latitude, popup=~as.character(total_amount))
NYCMap

barplot(Orange$age, Orange$circumference, xlab="Age (days)", ylab="Circumference (mm)")}
