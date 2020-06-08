## Assignment 1
library(stringr)

Jan2015 <- read.csv("/Users/Bluemangoes/Downloads/ANLY 500/Sept6/Jan2015.csv")

DayofWeek <- weekdays(as.Date(Jan2015$tpep_pickup_datetime))

barplot(table(Jan2015$total_amount, DayofWeek),main ="Total amount of $ collected",xlab ="Days of Week")

getPartOfDay(Jan2015$tpep_pickup_datetime)
PartofDay <-sapply(Jan2015$tpep_pickup_datetime, FUN=getPartOfDay)

barplot(table(Jan2015$tip_amount, PartofDay),main ="Total amount of Tips given", xlab= "Part of the Day")

barplot(table(Jan2015$tip_amount, DayofWeek),main ="Total amount of Tips given", xlab= "Part of the Day")


# There is a co-relation between day of week and time of day against tip amount.
# It can be observed that night time on Thursday, Friday and Saturdays are the best times for tips.  