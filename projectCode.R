setwd("~/Desktop/Fall21/ISA401-Data viz/project data")
#install.packages("pacman")
pacman::p_load(tidyverse, xlsx, tibble, dplyr, readr)

# Unemployment by state and month 2020 dataset originally from: https://www.bls.gov/lau/. 
#Clicked through each state's page located on the right hand side to get their individual unemployment rate
# over the year. Data is then collected in an excel sheet and formatted into a CSV file

unempRate<-read_csv("unemp by state and month 2020.csv")

# Covid risk dataset originally consisted of many different dataset from: 
#https://www.kff.org/report-section/state-covid-19-data-and-policy-actions-policy-actions/#stateleveldata
#The following code is used to merge them

highRisk<-read.csv("adults at higher risk.csv", skip = 2)
covidCase<-read.csv("covid data.csv")
schoolPoly<-read.csv("school policies.csv", skip = 2)
socialDistancing<-read.csv("social_distancing.csv", skip = 2)
statePolicy<-read.csv("state_health_policy.csv", skip = 2)
vaccine<-read.csv("vaccine_mandates.csv", skip = 2)

highRisk<-highRisk[2:52,1:9]
covidCase<-covidCase[2:52,]
schoolPoly<-schoolPoly[2:52,1:5]
socialDistancing<-socialDistancing[2:52,1:4]
statePolicy<-statePolicy[2:52,1:10]
vaccine<-vaccine[2:52,1:3]

colnames(covidCase)[1] <- "Location"
highRisk$Location[9] <- "District of Columbia"

covidRisk <- merge(highRisk, covidCase, by="Location")
policy <- merge(schoolPoly, statePolicy, by="Location")
mandate <- merge(socialDistancing, vaccine, by="Location")

write.csv(covidRisk, "covidRisk.csv")
write.csv(policy, "policy.csv")
write.csv(mandate, "mandate.csv")


# Total number of COVID cases ---------------------------------------------
#https://covidtracking.com/data/download

covidSum<-read.csv("all-states-history.csv")
covidSum$date<-as.Date(covidSum$date, format =  "%Y-%m-%d")

covidStateTotal<-covidSum %>%
  mutate(month = format(date, "%m")) %>%
  group_by(state, month) %>%
  summarise(totalCovid = sum(positiveIncrease),
            totalDeath = sum(deathIncrease),
            totalHospitalized = sum(hospitalizedIncrease))
#covidStateTotal$state<-state.name[match(covidStateTotal$state, state.abb)]

write.csv(covidStateTotal, "Covid by State total.csv")


# Stingency Index ---------------------------------------------------------

install.packages("COVID19")
library(COVID19)
library(tidyverse)
x <- covid19(country = "US", level = 2)
x<-x[x$date < "2021-01-01", ]
x1<-x %>%
  mutate(mY = format(date, "%m-%Y"))
x1<-x1[complete.cases(x1), ]
names(x1)[names(x1) == "key_apple_mobility"] <- "State"

write.csv(x1, "stringencyIndex.csv")


# Estimated Population in 2020 --------------------------------------------

# Original dataset from
#https://www.census.gov/data/tables/time-series/demo/popest/2010s-state-total.html
#Created an excel sheet with only the data from 2020 population



