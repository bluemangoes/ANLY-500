##                         ━━━━━━━━━━━━━━━━━━━━━━━━
##                          REGRESSION MODELS IN R
##                         ━━━━━━━━━━━━━━━━━━━━━━━━

## Table of Contents
## ─────────────────

## 1 Introduction
## 2 Linear regression
## 3 Interactions and factors
## 4 Regression with binary outcomes
## 5 Multilevel Modeling
## 6 Exercise solutions                                         :prototype:
## 7 Wrap-up

## 1 Introduction
## ══════════════

## 1.1 Workshop description
## ────────────────────────

##   • This is an intermediate/advanced R course
##   • Appropriate for those with basic knowledge of R
##   • This is not a statistics course!
##   • Learning objectives:
##     • Learn the R formula interface
##     • Specify factor contrasts to test specific hypotheses
##     • Perform model comparisons
##     • Run and interpret variety of regression models in R

## 1.2 Materials and Setup                                          :setup:
## ───────────────────────

##   Lab computer users: Log in using the user name and password on the
##   board to your left.

##   Everyone should have R installed –if not:

##   • Open a web browser and go to [http://cran.r-project.org] and
##     download and install it
##   • Also helpful to install RStudo (download from [http://rstudio.com])

##   Materials for this workshop include slides, example data sets, and
##   example code.

##   • Download materials from
##     [http://tutorials.iq.harvard.edu/R/Rstatistics.zip]
##   • Extract materials from RStatistics.zip (on lab machines /right-click
##     -> WinZip -> Extract to here/) and move to your desktop.

## 1.3 Launch RStudio                                            :labsetup:
## ──────────────────

##   • Open the RStudio program from the Windows start menu

##   • Open up today's R script
##     • In RStudio, Go to *File => Open Script*
##     • Locate and open the `Rstatistics.R' script in the Rstatistics
##       folder on your desktop

##   • Go to *Tools => Set working directory => To source file location*
##     (more on the working directory later)
##   • I encourage you to add your own notes to this file!

## 1.4 Set working directory
## ─────────────────────────

##   It is often helpful to start your R session by setting your working
##   directory so you don't have to type the full path names to your data
##   and other files

# set the working directory
# setwd("~/Desktop/Rstatistics")
# setwd("C:/Users/dataclass/Desktop/Rstatistics")

##   You might also start by listing the files in your working directory

getwd() # where am I?
list.files("dataSets") # files in the dataSets folder

## 1.5 Load the states data
## ────────────────────────

##   The /states.dta/ data comes from
##   [http://anawida.de/teach/SS14/anawida/4.linReg/data/states.dta.txt]
##   and appears to have originally appeared in /Statistics with Stata/ by
##   Lawrence C. Hamilton.

# read the states data
states.data <- readRDS("dataSets/states.rds") 
#get labels
states.info <- data.frame(attributes(states.data)[c("names", "var.labels")])
#look at last few labels
tail(states.info, 8)

## 2 Linear regression
## ═══════════════════

## 2.1 Examine the data before fitting models
## ──────────────────────────────────────────

##   Start by examining the data to check for problems.

# summary of expense and csat columns, all rows
sts.ex.sat <- subset(states.data, select = c("expense", "csat"))
summary(sts.ex.sat)
# correlation between expense and csat
cor(sts.ex.sat)

## 2.2 Plot the data before fitting models
## ───────────────────────────────────────

##   Plot the data to look for multivariate outliers, non-linear
##   relationships etc.

# scatter plot of expense vs csat
plot(sts.ex.sat)

## 2.3 Linear regression example
## ─────────────────────────────

##   • Linear regression models can be fit with the `lm()' function
##   • For example, we can use `lm' to predict SAT scores based on
##     per-pupal expenditures:

# Fit our regression model
sat.mod <- lm(csat ~ expense, # regression formula
              data=states.data) # data set
# Summarize and print the results
summary(sat.mod) # show regression coefficients table

## 2.4 Why is the association between expense and SAT scores /negative/?
## ─────────────────────────────────────────────────────────────────────

##   Many people find it surprising that the per-capita expenditure on
##   students is negatively related to SAT scores. The beauty of multiple
##   regression is that we can try to pull these apart. What would the
##   association between expense and SAT scores be if there were no
##   difference among the states in the percentage of students taking the
##   SAT?

summary(lm(csat ~ expense + percent, data = states.data))

## 2.5 The lm class and methods
## ────────────────────────────

##   OK, we fit our model. Now what?
##   • Examine the model object:

class(sat.mod)
names(sat.mod)
methods(class = class(sat.mod))[1:9]

##   • Use function methods to get more information about the fit

confint(sat.mod)
# hist(residuals(sat.mod))

## 2.6 Linear Regression Assumptions
## ─────────────────────────────────

##   • Ordinary least squares regression relies on several assumptions,
##     including that the residuals are normally distributed and
##     homoscedastic, the errors are independent and the relationships are
##     linear.

##   • Investigate these assumptions visually by plotting your model:

par(mar = c(4, 4, 2, 2), mfrow = c(1, 2)) #optional
plot(sat.mod, which = c(1, 2)) # "which" argument optional

##   [file:images/regressionsAssumptions1.png]

## 2.7 Comparing models
## ────────────────────

##   Do congressional voting patterns predict SAT scores over and above
##   expense? Fit two models and compare them:

# fit another model, adding house and senate as predictors
sat.voting.mod <-  lm(csat ~ expense + house + senate,
                      data = na.omit(states.data))
sat.mod <- update(sat.mod, data=na.omit(states.data))
# compare using the anova() function
anova(sat.mod, sat.voting.mod)
coef(summary(sat.voting.mod))

## 2.8 Exercise 0: least squares regression
## ────────────────────────────────────────

##   Use the /states.rds/ data set. Fit a model predicting energy consumed
##   per capita (energy) from the percentage of residents living in
##   metropolitan areas (metro). Be sure to
##   1. Examine/plot the data before fitting the model
##   2. Print and interpret the model `summary'
##   3. `plot' the model to look for deviations from modeling assumptions

##   Select one or more additional predictors to add to your model and
##   repeat steps 1-3. Is this model significantly better than the model
##   with /metro/ as the only predictor?
