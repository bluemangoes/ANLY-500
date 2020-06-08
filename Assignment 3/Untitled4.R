library(stringr)

college <- read.csv("/Users/Bluemangoes/Downloads/ANLY 506/college.csv")
summary(college)

boxplot(Apps ~ Private, college, ylim=c(0,25000), xlab="Applications to Private Schools (Yes/No)")

private_apps = college[college$Private == "Yes", ] 

summary(private_apps)

plot(college$Apps, college$Accept, col=college$Private, ylim=c(0,10000), xlim=c(0,15000))
