# more-guns-less-crime

> This project was undertaken as academic study to understand and apply the concepts of Econometrics and time series analysis.

## Introduction

The impact of guns on crime in America has triggered a lot of public debate. Many strongly believe that state laws enabling citizens to carry concealed handguns had reduced crime. According to this view, gun control laws take away guns from law-abiding citizens, while would-be criminals ignore those leaving potential victims defenseless.Following this view, The National Rifle Association (NRA) and many politicians across the country advance the cause of greater freedom to carry guns.

As a result, many states in the United States have passed right-to-carry laws (also known as a shall-issue laws). A Shall-issue law is one that requires that governments issue concealed carry handgun permits to any applicant who meets the necessary criteria. These criteria are: the applicant must be an adult, have no significant criminal record, and no history of mental illness and successfully complete a course in firearms safety training (if required by law). If these criteria are met, the granting authority has no discretion in the awarding of the licenses, and there is no requirement of the applicant to demonstrate "good cause". 

Here we are analyzing the historical data on crime in the U.S to answer the question “Does shall-issues law reduce crime-or not?”

## About the data

Guns is a balanced panel of data on 50 US states, plus the District of Columbia (for a total of 51 states), by year for 1977 – 1999. Each observation is a given state in a given year. There are a total of 51 states × 23 years = 1173 observations

Variable Definitions

* vio           - violent crime rate (incidents per 100,000 members of the population)
* rob	          - robbery rate (incidents per 100,000)
* mur	          - murder rate (incidents per 100,000)
* shall	= 1     if the state has a shall-carry law in effect in that year
        = 0     otherwise
* incarc_rate	  - incarceration rate in the state in the previous year (sentenced prisoners per 100,000 residents; value for the previous year)
* density	      - population per square mile of land area, divided by 1000
* avginc	      - real per capita personal income in the state, in thousands of dollars
* pop	          - state population, in millions of people
* pm1029	      - percent of state population that is male, ages 10 to 29
* pw1064	      - percent of state population that is white, ages 10 to 64
* pb1064	      - percent of state population that is black, ages 10 to 64
* stateid	      - ID number of states (Alabama = 1, Alaska = 2, etc.)
* year	        - Year (1977-1999)
