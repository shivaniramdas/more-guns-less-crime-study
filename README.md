# more-guns-less-crime-study

> This project was undertaken as a group academic study to understand and apply the concepts of Econometrics and time series analysis.

## Introduction

The impact of guns on crime in America has triggered a lot of public debate. Many strongly believe that state laws enabling citizens to carry concealed handguns had reduced crime. According to this view, gun control laws take away guns from law-abiding citizens, while would-be criminals ignore those leaving potential victims defenseless.Following this view, The National Rifle Association (NRA) and many politicians across the country advance the cause of greater freedom to carry guns.

As a result, many states in the United States have passed right-to-carry laws (also known as a shall-issue laws). A Shall-issue law is one that requires that governments issue concealed carry handgun permits to any applicant who meets the necessary criteria. These criteria are: the applicant must be an adult, have no significant criminal record, and no history of mental illness and successfully complete a course in firearms safety training (if required by law). If these criteria are met, the granting authority has no discretion in the awarding of the licenses, and there is no requirement of the applicant to demonstrate "good cause". 

Here we are analyzing the historical data on crime in the U.S to answer the question “Does shall-issues law reduce crime-or not?”

## About the data

Guns is a balanced panel of data on 50 US states, plus the District of Columbia (for a total of 51 states), by year for 1977 – 1999. Each observation is a given state in a given year. There are a total of 51 states × 23 years = 1173 observations

variable | definition
------------ | -------------
vio | violent crime rate (incidents per 100,000 members of the population)
rob | robbery rate (incidents per 100,000)
mur | murder rate (incidents per 100,000)
shall = 1 | if the state has a shall-carry law in effect in that year = 0 otherwise
incarc_rate | incarceration rate in the state in the previous year (sentenced prisoners per 100,000 residents; value for the previous year)
density | population per square mile of land area, divided by 1000
avginc | real per capita personal income in the state, in thousands of dollars
pop | state population, in millions of people
pm1029 | percent of state population that is male, ages 10 to 29
pw1064 | percent of state population that is white, ages 10 to 64
pb1064 | percent of state population that is black, ages 10 to 64
stateid | ID number of states (Alabama = 1, Alaska = 2, etc.)
year | Year (1977-1999)


## Models

The goal is to understand the effect of shall Carry law on the overall crime rate in the US, understand how the incarceration rate affects the overall crime rate in the US and finally which of the control variables have a significant part in affecting the overall crime rate of the US

To help us carry out the above goals we run 3 models to estimate the relationship between the shall carry law, incarceration rate together with other control variables as explanatory variables with the dependent variable overall crime rate.

1. Pooled OLS Model
2. Entity Fixed Effects Model
3. Time and Entity Fixed Model

We then compared the Time and Entity Fixed Model with the other two using the Chi-squared tests to only conclude that Time and Entity Fixed Model was the best choice. 



## Insights drawn

 Shall law effect is insignificant or it does not have any effect on the overall crime rate, Though its coefficient is negative we never found enough evidence to show that it was significantly different than 0. However we might think that there could be other variables which could affect the overall crime rate like cultural attitudes of different states etc

 Incarceration rate however, was found to be extremely significant in our analysis meaning that it significantly affected the overall crime rate. It had a negative relationship with the overall crime rate which gives us an insight that by tightening the laws and improving the policing can reduce the overall crime rate. Fast track courts and strict federal laws and more intensive policing would be our advice to reduce the overall crime rate.

 Percentage of young male in the states between the ages of 10-29 was highly significant or had an huge effect on the overall crime rate. With higher percentage of young males in the states between the ages of 10-29 the overall crime rate increased.

 A general trend of increase in the overall crime rate was found from the year 1977- year 1995 but a slight decline in the overall crime rates were observed for the later years from 1996-1999.

