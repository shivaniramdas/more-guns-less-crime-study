# Improting Libraries

library(margins)
library(esquisse)
library(tidyverse)
library(moments)
library(dplyr)
library(ggplot2)
library(corrplot)
library(ISLR)
library(car)
library(foreign)
library(ggthemes)
library(colorRamps)
library(foreign)
library(multcomp)
library(survey)
library(lmtest)
library(car)
library(estimatr)
library(gridExtra)
library(gplots)
library(plm)
library(estimatr)
library(lmtest)
source("https://www.r-statistics.com/wp-content/uploads/2010/07/coefplot.r.txt")
library(broom)
library(knitr)
library(sjPlot)
library(stargazer)
install.packages("jtools")
install.packages("devtools")
library(jtools)
library(devtools)
install.packages("huxtable")
library(huxtable)

# Improting the data set
?`estimatr-package`
guns_data<- read.dta("guns.dta")
View(guns_data)
attach(guns_data)
na.omit(guns_data)

# Summary Statistics
summary(guns_data)


# Data Exploration/Data Visualization

# Correlation Plot
cor(guns_data[,-15])
corrplot.mixed(cor(guns_data[,c(-(15:39))]))
corrplot(cor(guns_data[,c(-(15:39))]),method = "shade")

pairs(mur~year+incarc_rate+pb1064+pw1064+pm1029+pop+avginc+density)
pairs(rob~year+incarc_rate+pb1064+pw1064+pm1029+pop+avginc+density)
pairs(vio~year+incarc_rate+pb1064+pw1064+pm1029+pop+avginc+density)
pairs(all_crime~year+incarc_rate+pb1064+pw1064+pm1029+pop+avginc+density)

plot(vio,mur)
plot(vio,rob)
plot(rob,mur)


guns_data$all_crime<-vio+rob+mur
View(guns_data)
attach(guns_data)

stargazer(guns_data[c("vio","mur","rob","incarc_rate","pb1064","pw1064","pm1029","pop","avginc","density","all_crime")], type = "text", title="Descriptive statistics", digits=1, out="descriptive.dox")
names(guns_data)
library(ggplot2)


guns_data$factor_shall<- as.factor(shall)
attach(guns_data)


library(ggplot2)

ggplot(p_dat) +
 aes(x = incarc_rate, y = all_crime) +
 geom_point(size = 1L, colour = "#d8576b") +
 labs(x = "Incarceration Rate(per 100,000)", y = "Total Crime(all_crime)", title = "Scatter Plot Of Incarceration Rate Vs Total Crime") +
 theme_igray()

# Histogram for Vio,mur,rob, all_crime


library(ggplot2)

q<-ggplot(guns_data) +
 aes(x = mur) +
 geom_histogram(bins = 30L, fill = "#cf4446") +
 labs(x = "Murder Rate(Incidents per 100,000)", y = "Frequency", title = "Histogram Of Murder Rate", caption = "Positively Skewed Histogram") +
 theme_igray()

library(ggplot2)

y<-ggplot(guns_data) +
 aes(x = vio) +
 geom_histogram(bins = 30L, fill = "#cd4071") +
 labs(x = "Violent Crime Rate(Incidents per 100,000)", y = "Frequency", title = "Histogram Of Violent Crime Rate", caption = "Positively Skewed Histogram") +
 theme_igray()

library(ggplot2)

v<-ggplot(guns_data) +
 aes(x = rob) +
 geom_histogram(bins = 30L, fill = "#f1605d") +
 labs(x = "Robbery Rate(Incidents per 100,000)", y = "Frequency", title = "Histogram Of Robbery Rate", caption = "Positively Skewed Histogram") +
 theme_igray()


# Histograms For Density and Incarceration


library(ggplot2)

k1<-ggplot(p_dat) +
 aes(x = density) +
 geom_histogram(bins = 30L, fill = "#440154") +
 labs(x = "Density", y = "Frequency", title = "Histogram Of Density", caption = "Positively Skewed Histogram Of Density") +
 theme_igray()

library(ggplot2)

k2<-ggplot(p_dat) +
 aes(x = incarc_rate) +
 geom_histogram(bins = 30L, fill = "#617a89") +
 labs(x = "Incarceration Rate(per 100,000)", y = "Frequency", title = "Histogram Of Incarceration Rate", caption = "Positively Skewed Histogram For Incarceration Rate") +
 theme_igray()

grid.arrange(k1,k2,nrow=1)
library(ggplot2)

k3<-ggplot(guns_data) +
 aes(x = all_crime) +
 geom_histogram(bins = 30L, fill = "#0d0887") +
 labs(x = "Combined Crime Rate(Incidents Per 100,000)", y = "Frequency", title = "Histogram Of Combined Crime Rates(all_crime)", caption = "Positively Skewed Histogram") +
 theme_igray()

# Plot of ALL SKEWED HISTOGRAMS
grid.arrange(q,y,v,k1,k2,k3,nrow=2)


library(ggplot2)

q1<-ggplot(p_dat) +
 aes(x = pm1029) +
 geom_histogram(bins = 30L, fill = "#2d543d") +
 labs(x = "Percentage Of Male Between The ages of 10-29", y = "Frequency", title = "Histogram Of pm1029", caption = "The Histogram Looks Fairly Symmetrical") +
 theme_igray()

library(ggplot2)

q2<-ggplot(p_dat) +
 aes(x = avginc) +
 geom_histogram(bins = 30L, fill = "#1f9e89") +
 labs(x = "Average Income", y = "Frequency", title = "Histogram Of Average Income", caption = "The histogram of Average Income looks fairly Symmetric") +
 theme_igray()

grid.arrange(q1,q2,nrow=1)

skewness(all_crime)

skewness(log_all_crime)
# Box-Plot
ggplot(guns_data) +
  aes(x = factor_shall, y = all_crime, fill = factor_shall) +
  geom_boxplot() +
  scale_fill_viridis_d(option = "magma") +
  labs(x = "Shall-Carry Law Effect", y = "Overall Crime Rate(per100,000)", fill = "Shall-Carry Effect") +
  theme_igray()

# Violence Histogram - Shall Law
ggplot(guns_data) +
 aes(x = vio) +
 geom_histogram(bins = 30L, fill = "#d8576b") +
 labs(x = "Violent crime rate(Incedents per 100,000)", y = "Frequency", title = "Histogram Of Violent Crime Rates Based on The Shall-Carry Law Effect", caption = "Sharp decline in Violent Crime rates for the cases wher Shall-Carry Law is in place") +
 theme_igray() +
 facet_wrap(vars(shall))

skewness(vio)



library(ggplot2)
# Murder Histogram - Shall Law
ggplot(guns_data) +
 aes(x = mur) +
 geom_histogram(bins = 30L, fill = "#cf4446") +
 labs(x = "Murder Rate(Incedents per 100,000)", y = "Frequency", title = "Murder Rate histogram as per Shall-Carry Law effect", caption = "Sharp Decline in the Murder Rate can be seen in case of Shall-Carry Law being in place") +
 theme_igray() +
 facet_wrap(vars(shall))

skewness(mur)

# Robbery Histogram - Shall Law


library(ggplot2)

ggplot(guns_data) +
 aes(x = rob) +
 geom_histogram(bins = 30L, fill = "#f1605d") +
 labs(x = "Robbery Rate(Incidents per 100,000)", y = "Frequency", title = "Histogram of Robbery Rate as per weather the Shall-Carry Law is in effect") +
 theme_igray() +
 facet_wrap(vars(shall))

skewness(rob)



library(ggplot2)
# Year Vs Violent Crime Rate based on Shall Carry Law
ggplot(guns_data) +
 aes(x = year, y = vio) +
 geom_point(size = 1L, colour = "#d8576b") +
 labs(x = "Year", y = "Violence Rate(Per 100,000)", title = "Year Vs Violent Crime Rate by Shall-Carry Law Effect", caption = "Shall-Carry Law had utility in reducing the Violent Crime Uptil 1989(Since Last decade the effect of Shall Carry Law is more or less similar to its counterpart)") +
 theme_igray() +
 facet_wrap(vars(shall))

cor(vio,year)
cor(new_data$vio,new_data$year)




library(ggplot2)
# Year Vs Murder Crime Rate based on Shall Carry Law
ggplot(guns_data) +
 aes(x = year, y = mur) +
 geom_point(size = 1L, colour = "#cf4446") +
 labs(x = "Year", y = "Murder Rate(Per 100,000)", title = "Year Vs Murder Rate Based on Shall-Carry Law Effect", caption = "Same pattern of increase in the murder rate after 1990 can be seen where the Shall Carry Law is in Effect") +
 theme_igray() +
 facet_wrap(vars(shall))

cor(mur,year)
cor(new_data$mur,new_data$year)



library(ggplot2)
# Year Vs Robbery Crime Rate based on Shall Carry Law
ggplot(guns_data) +
 aes(x = year, y = rob) +
 geom_point(size = 1L, colour = "#f1605d") +
 labs(x = "Year", y = "Robbery Rate(per 100,000)", title = "Year Vs Robbery Rate by Shall-Carry Law", caption = "Same Spike in the Robbery Rate can be seen after 1990 in the cases where the shell-Carry law is in effect") +
 theme_igray() +
 facet_wrap(vars(shall))

cor(rob,year)
cor(new_data$rob,new_data$year)



library(ggplot2)


guns_data$all_crime<-vio+rob+mur
View(guns_data)
attach(guns_data)



library(ggplot2)
# Over all Crime Rate Vs Year By shall-carry law effect
ggplot(guns_data) +
 aes(x = year, y = all_crime) +
 geom_point(size = 1L, colour = "#a52c60") +
 labs(x = "Year", y = "Overall Crime Rate(per 100,000)", title = "Year Vs Ovarall Crime Rate by Shall-Carry Law effect", caption = "Same Pattern Can be Observed") +
 theme_igray() +
 facet_wrap(vars(shall))

cor(all_crime,year)



library(ggplot2)
# Incar Crime
t1<-ggplot(guns_data) +
 aes(x = all_crime, y = incarc_rate, colour = shall) +
 geom_point(size = 1L) +
 scale_color_gradient() +
 labs(x = "Overall Crime Rate(per 100,000)", y = "Incarceration Rate(per 100,000)", caption = "If Shall Law Implemented More Incarceration?", color = "Shall Law Effect") +
 theme_igray()

t2<-ggplot(guns_data) +
  aes(x = factor_shall, y = incarc_rate, fill = factor_shall) +
  geom_boxplot() +
  scale_fill_brewer(palette = "Paired") +
  labs(x = "Shall Law Effect", y = "Incarceration Rate", title = "Shall Law Effect Vs Incarceration Rate", caption = "States Having Shall Law in Effect tend to have Higher Incarceraction Rates", fill = "Shall Law Effect") +
  theme_igray()

grid.arrange(t1,t2,nrow=1)

# pb,pw,pm Variables Vs Overall Crime Rates by Shall Law Effect

library(ggplot2)

ggplot(guns_data) +
 aes(x = pb1064, y = all_crime, colour = factor_shall) +
 geom_point(size = 1L) +
 scale_color_viridis_d(option = "plasma") +
 labs(x = "Percentage Of Blacks by State(age10-age64)", y = "Overall Crime Rate(per 100,000)", title = "Percentage Of Blacks by State Vs Overall Crime Rate By Shall Law Effect", caption = "Positive Correlation between percentage of blacks in the state and the overall Crime Rate for both the Shall Law cases") +
 theme_igray()






library(ggplot2)

ggplot(guns_data) +
 aes(x = pw1064, y = all_crime, colour = factor_shall) +
 geom_point(size = 1L) +
 scale_color_viridis_d(option = "magma") +
 labs(x = "Percentage Of Whites in states(age10-age64)", y = "Overall Crime Rate(per 100,000)", title = "Percentage Of Whites in states Vs Overall Crime Rate by Shall Law Effect", color = "Shall-Carry Law Effect",caption = "Negative Correlation between Percentage of whites in the state and overall Crime Rate in both the Shall Law Cases") +
 theme_igray()



library(ggplot2)

ggplot(guns_data) +
 aes(x = pm1029, y = all_crime, colour = factor_shall) +
 geom_point(size = 1L) +
 scale_color_viridis_d(option = "viridis") +
 labs(x = "Percentage Of Males in a State(age10-age29)", y = "Overall Crime Rate(per 100,000)", title = "Percentage Of Males in a State Vs Overall Crime Rate by Shall Law Effect", caption = "No correlation was found. For States Having Higher Percentag young male a Shall Law in effect leads to Less Overall Crime", color = "Shall-Carry Law Effect") +
  theme_igray()



# Density
# Population






library(ggplot2)

p<-ggplot(guns_data) +
 aes(x = pop, y = all_crime, colour = factor_shall) +
 geom_point(size = 1L) +
 scale_color_brewer(palette = "Dark2") +
 labs(x = "Population(in Millions)", y = "Overall Crime Rate(per 100,000)", title = "Population Vs Overall Crime Rate by Shall Law Effect", caption = "Positive Correlation between Overall Crime and Population", color = "Shall Law Effect") +
 theme_igray()

guns_data <- guns_data %>%
 filter(density >= 0L & density <= 5L)
d<-ggplot(guns_data) +
 aes(x = density, y = all_crime, colour = factor_shall) +
 geom_point(size = 1L) +
 scale_color_hue() +
 labs(x = "Density", y = "Overall Crime Rate(Per 100,000)", caption = "Positive Correlation Between Population Density and Overall Crime Rate. Densely Populated States do Not have Shall Law in Effect. Afraid that More Density More Crime?", color = "Shall Law Effect") +
 theme_igray()

grid.arrange(p,d,nrow=1)





library(ggplot2)



library(ggplot2)

ggplot(guns_data) +
 aes(x = all_crime, y = incarc_rate, colour = factor_shall) +
 geom_point(size = 1L) +
 scale_color_brewer(palette = "Set1") +
 labs(x = "Overall Crime Rate(per 100,000)", y = "Incarceration Rate", title = "Overall Crime Rate Vs Incarceration Rate", subtitle = "Positive Correlation between Overall Crime Rate and Incarceration Rate", caption = "States with Shell Law in Place Have Higher Incarceration rates?", color = "Shall Law Effect") +
 theme_igray()



# avg Income Vs Overall Crime Rate by Shall Law Effect
ggplot(guns_data) +
  aes(x = avginc, y = all_crime, colour = factor_shall) +
  geom_point(size = 1L) +
  scale_color_brewer(palette = "Set3")  +
  labs(x = "Average Per-Capita Income Per State", y = "Overall Crime Rate(per 100,000)", title = "Average Per-Capita Income Per State VS Overall Crime Rate(per 100,000) By Shall Law Effect",caption = "Diminishing Effect?") +
  theme_igray()

# Incarceration

# Year Vs Incarceration Rate by Shall Law

ggplot(guns_data) +
  aes(x = year, y = incarc_rate) +
  geom_point(size = 1L, colour = "#000004") +
  labs(x = "Year", y = "Incarceration Rate", title = "Year Vs Incarceration Rate by Shall-Carry Law Effect", caption = "Same Pattern of the Incarceration Rate Spiking up in after 1990 where the Shall-Carry Law is in effect can be seen") +
  theme_igray() +
  facet_wrap(vars(shall))

# Incar Percentage of blacks and whites
ggplot(guns_data) +
  aes(x = pb1064, y = pw1064, colour = incarc_rate) +
  geom_point(size = 1L) +
  scale_color_distiller(palette = "BuPu",direction = 1) +
  labs(x = "Percentage Black Population In State(age10-age64)", y = "Percentage White Population In State(age10-age64)", title = "Percentage Black Population In State Vs Percentage White Population In State by Incarceration Rate", caption = "More Percentage of white in state-less Incarceration,More Percentage Of blacks in states more incarcerations", color = "Incarceration Rate") +
  theme_igray()



library(ggplot2)

w<-ggplot(guns_data) +
 aes(x = pw1064, y = all_crime, colour = incarc_rate) +
 geom_point(size = 1L) +
 scale_color_distiller(palette = "Blues",direction = 1) +
 labs(x = "Percentage of Whites In The State", y = "Overall Crime Rate(per 100,000)", title = "Percentage of Whites In The State Vs Overall Crime Rate By Incarceration Rate", caption = "More The White Population Less the Crime hence less the Incarceration Rate", color = "Incarceration Rate") +
 theme_igray()



library(ggplot2)

b<-ggplot(guns_data) +
 aes(x = pb1064, y = all_crime, colour = incarc_rate) +
 geom_point(size = 1L) +
 scale_color_distiller(palette = "BuGn",direction = 1) +
 labs(x = "Percentage Of Black Population in State", y = "Overall Crime Rate(per 100,000)", title = "Percentage Of Black Population in State Vs Overall Crime Rate", caption = "More Black population in state more crime and hence greater incarceration rate", color = "Incarceration Rate") +
 theme_igray()

grid.arrange(b,w,nrow=1)



# Incar percentage of males
library(ggplot2)

ggplot(guns_data) +
 aes(x = pm1029, y = all_crime, colour = incarc_rate) +
 geom_point(size = 1L) +
 scale_color_distiller(palette = "YlOrRd",direction = 1) +
 labs(x = "Percentage Of Males in State between Ages of 10 and 29", y = "Overall Crime Rate(per 100,000)", title = "Percentage Of Males in State between Ages of 10 and 29 Vs Overall Crime Rate by Incarceration Rate", caption = "Sates Having less percentage of males between this age frame and Higher Crime Rate have Higher Incarceration Rates", color = "Incarceration Rate") +
 theme_igray()

# Incar Pop-dENSITY
library(ggplot2)

d2<-ggplot(guns_data) +
 aes(x = density, y = all_crime, colour = incarc_rate) +
 geom_point(size = 1L) +
 scale_color_distiller(palette = "Purples",direction = 1) +
 labs(x = "Density", y = "Overall Crime Rate(per 100,000)", title = "Density Vs Overall Crime Rate", caption = "More Density-More Crime Hence More Incarceration Rate", color = "Incarceration Rate") +
 theme_igray()



library(ggplot2)

p2<-ggplot(guns_data) +
 aes(x = pop, y = all_crime, colour = incarc_rate) +
 geom_point(size = 1L) +
 scale_color_distiller(palette = "OrRd",direction = 1) +
 labs(x = "Population", y = "Overall Crime Rate", title = "Population Vs Overall Crime Rate", caption = "States Hving Higher population have more overall crime and hence have Higher Incarceration Rates", color = "Incarceration Rates") +
 theme_igray()

grid.arrange(p2,d2,nrow=1)



library(ggplot2)

ggplot(guns_data) +
 aes(x = factor_shall, y = incarc_rate, fill = factor_shall) +
 geom_boxplot() +
 scale_fill_brewer(palette = "Paired") +
 labs(x = "Shall Law Effect", y = "Incarceration Rate", title = "Shall Law Effect Vs Incarceration Rate", caption = "States Having Shall Law in Effect tend to have Higher Incarceraction Rates", fill = "Shall Law Effect") +
 theme_igray()




library(ggplot2)
# Trend of Young Men In States
ggplot(guns_data) +
 aes(x = year, y = pm1029) +
 geom_point(size = 1L, colour = "#0b53c1") +
 labs(x = "Year", y = "Percentage Of Male Population In a State(age10-29)", title = "Trend Of Young Male Population In States", caption = "Decreasing Trend") +
 theme_igray()

library(ggplot2)
# Trend of Avg Income in states


library(ggplot2)

ggplot(guns_data) +
 aes(x = year, y = avginc) +
 geom_point(size = 1L, colour = "#26828e") +
 labs(x = "Year", y = "Average Per Capita Income In States", title = "Trend Of Per-Capita Income In States", caption = "Positive Trend") +
 theme_igray()

# Pm1029 Vs Incar


library(ggplot2)

ggplot(guns_data) +
 aes(x = pm1029, y = incarc_rate) +
 geom_point(size = 1L, colour = "#0c4c8a") +
 labs(x = "Percentage Of Males in State(10-29)", y = "Incarcercation Rate", title = "Percentage Of Males in State Vs incarcercation Rate", caption = "Negative Relationship") +
 theme_igray()

# Pm1029 Vs Avg Income


library(ggplot2)

ggplot(guns_data) +
 aes(x = pm1029, y = avginc) +
 geom_point(size = 1L, colour = "#35b779") +
 labs(x = "Percentage Of Males in State(10-29)", y = "Average Per Capita Income In State", title = "Percentage Of Males in State Vs Average Per Capita Income In State", caption = "Negative Trend") +
 theme_igray()

# Average Income Vs Density


library(ggplot2)

ggplot(guns_data) +
 aes(x = density, y = avginc) +
 geom_point(size = 1L, colour = "#617a89") +
 labs(x = "Density", y = "Average Per Capita Income", title = "Density Vs Average Per Capita Income", caption = "Positive Trend") +
 theme_igray()

# Part 2

# Creating Time Dummies

guns_data$y77<- ifelse(guns_data$year==77,1,0)
guns_data$y78<- ifelse(guns_data$year==78,1,0)
guns_data$y79<- ifelse(guns_data$year==79,1,0)

guns_data$y80<- ifelse(guns_data$year==80,1,0)
guns_data$y81<- ifelse(guns_data$year==81,1,0)
guns_data$y82<- ifelse(guns_data$year==82,1,0)
guns_data$y83<- ifelse(guns_data$year==83,1,0)
guns_data$y84<- ifelse(guns_data$year==84,1,0)
guns_data$y85<- ifelse(guns_data$year==85,1,0)
guns_data$y86<- ifelse(guns_data$year==86,1,0)
guns_data$y87<- ifelse(guns_data$year==87,1,0)
guns_data$y88<- ifelse(guns_data$year==88,1,0)
guns_data$y89<- ifelse(guns_data$year==89,1,0)

guns_data$y90<- ifelse(guns_data$year==90,1,0)
guns_data$y91<- ifelse(guns_data$year==91,1,0)
guns_data$y92<- ifelse(guns_data$year==92,1,0)
guns_data$y93<- ifelse(guns_data$year==93,1,0)
guns_data$y94<- ifelse(guns_data$year==94,1,0)
guns_data$y95<- ifelse(guns_data$year==95,1,0)
guns_data$y96<- ifelse(guns_data$year==96,1,0)
guns_data$y97<- ifelse(guns_data$year==97,1,0)
guns_data$y98<- ifelse(guns_data$year==98,1,0)
guns_data$y99<- ifelse(guns_data$year==99,1,0)

#Heteroginity across year
View(guns_data)
plotmeans(all_crime~year,xlab = "Year",ylab = "Overall Crime Rate(all_crime)")
lin_model1<-lm(all_crime~year)
summary(lin_model1)
m<-resid(lin_model1)
plot(year,m)
#heteroginity across states
num_stateid<-as.numeric(stateid)
attach(guns_data)
l<- filter(guns_data,num_stateid<=51)
lin_model2<-lm(all_crime~num_stateid,data = l)
summary(lin_model2)
k<-resid(lin_model2)
plot(num_stateid,k)
attach(l)
plotmeans(all_crime~stateid,xlab = "State-id",ylab = "Overall Crime Rate(all_crime)")
attach(p_dat)
attach(guns_data)
guns_data$factor_year<-as.factor(year)

# Pooled OLS Model
ols_model<-lm(all_crime~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+density+factor_shall+y77+y78+y79+y80+y81+y82+y83+y84+y85+y86+y87+y88+y89+y90+y91+y92+y93+y94+y95+y96+y97+y98+y99,data = guns_data)
summary(ols_model)


# Diminishing effect of Average Income
na.omit(panel)

p_dat<-pdata.frame(guns_data,index = c("stateid","year"))
dim(p_dat)
ols_model2<-plm(all_crime~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+I(avginc^2)+density+factor_shall+factor_year,data = p_dat,model = "pooling")
summary(ols_model2)
coefplot(ols_model2)

x<-fitted(ols_model2)
r<- resid(ols_model2)

hist(x)

hist(r)

ggplot(mapping=aes(x=x,y=r))+geom_point(color="navyBlue")+geom_abline(slope = 0,intercept = 0,color="red",size=1)+xlab("Fitted Values of y (y-hat)")+ylab("Residuals")+theme_igray()+ggtitle("Informal Residual Plot To Check Heteroskedasticity")
ols_m_2<- tidy(ols_model2)
ols_m_2

View(ols_m_2)

ols_model2_vio<-plm(vio~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+I(avginc^2)+density+factor_shall+factor_year,data = p_dat,model = "pooling")
ols_model2_mur<-plm(mur~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+I(avginc^2)+density+factor_shall+factor_year,data = p_dat,model = "pooling")
ols_model2_rob<-plm(log_rob~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+I(avginc^2)+density+factor_shall+factor_year,data = p_dat,model = "pooling")

ols_model3<-plm(all_crime~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+I(avginc^2)+density+factor_shall+factor_year,data = p_dat,model = "pooling")
summary(ols_model3)


# POOLED OLS FINAL REGRESSION(FOR REPORT)
attach(p_dat)

ols_model_log_all_crime<- plm(log_all_crime~log_incarc+pb1064+pw1064+pm1029+pop+avginc+log_density+factor_shall,data = p_dat,model = "pooling")
summary(ols_model_log_all_crime)
kable(tidy(ols_model_log_all_crime))
coefplot(ols_model_log_all_crime)


install.packages("officer")
library(officer)
install.packages("huxtable",dependencies = T)
install.packages("uuid")

export_summs(ols_model_log_all_crime, scale = TRUE, transform.response = TRUE,model.names = "Pooled Ols Model",to.file = "xlsx",file.name = "pooled_ols_table.xlsx")
?export_summs
tidy(ols_model_log_all_crime)

a<-resid(ols_model_log_all_crime)
b<-fitted(ols_model_log_all_crime)

# Residual PLOT PROOF FOR HETEROSKEDASTICITY INFORMAL WAY
ggplot(mapping=aes(x=b,y=a))+geom_point(color="navyBlue")+geom_abline(slope = 0,intercept = 0,color="red",size=1)+xlab("Fitted Values of ln_allcrime (y-hat)")+ylab("Residuals")+theme_igray()+ggtitle("Informal Residual Plot To Check Heteroskedasticity")

ggplot(mapping=aes(x=year,y=a))+geom_point(color="black")+geom_abline(slope = 0,intercept = 0,color="red",size=1)+xlab("Fitted Values of y (y-hat)")+ylab("Residuals")+theme_igray()+ggtitle("Informal Residual Plot To Check Heteroskedasticity")

ggplot(mapping=aes(x=stateid,y=a))+geom_point(color="darkgreen")+geom_abline(slope = 0,intercept = 0,color="red",size=1)+xlab("State-ID")+ylab("Residuals")+theme_igray()+ggtitle("Informal Residual Plot across entities To Check Heteroskedasticity across entities")





# Confirmimg if there is hetreoskedasticity on whites test

library("sandwich")

# Whites Test For Heteroskedasticity
kable(tidy(bptest(ols_model_log_all_crime,~log_incarc+pb1064+pw1064+pm1029+pop+avginc+log_density+factor_shall,data = p_dat)))
# P-vale practically 0.009737 hence we reject the null hypothesis and conclude that there is indeed heteroskedasticity

# R
# There is presence of heteroskedasticity hence we will use cluster robust standard errors
x1<-coeftest(ols_model_log_all_crime, vcov=vcovHC(ols_model_log_all_crime, cluster="group"))  

kable(tidy(x1))


stargazer(x1,title = "Pooled Ols Model With Cluster Robust Standard Errors",out = "zzzz.docx")
# SE Different hence presence of seriel correlation and heteroskedasticity



# Time-Fixed Effect Model testing
attach(p_dat)
fixed_time_entity_model<-plm(log_all_crime~log_incarc+pb1064+pw1064+pm1029+pop+avginc+log_density+factor_shall+factor_year,data = p_dat,model = "within")
summary(fixed_time_entity_model)
coefplot(fixed_time_entity_model)
export_summs(fixed_time_entity_model, scale = TRUE, transform.response = TRUE,model.names = "Time and Entity Fixed Model",to.file = "xlsx",file.name = "Time and Entity Fixed_table.xlsx")



fixed_entity_model<-plm(log_all_crime~log_incarc+pb1064+pw1064+pm1029+pop+avginc+log_density+factor_shall,data = p_dat,model = "within")
summary(fixed_entity_model)
coefplot(fixed_entity_model)

entity_fixed_resid<- resid(fixed_entity_model)
entity_fixed_fitted<- fitted(fixed_entity_model)

ggplot(mapping=aes(x=entity_fixed_fitted,y=entity_fixed_resid))+geom_point(color="maroon")+geom_abline(slope = 0,intercept = 0,color="navyblue",size=1)+xlab("Fitted Values of ln_allcrime (y-hat)")+ylab("Residuals")+theme_igray()+ggtitle("Informal Residual Plot To Check Heteroskedasticity")



residual_fixed<- resid(fixed_time_entity_model)
fitted_fixed<- fitted(fixed_time_entity_model)

ggplot(mapping=aes(x=fitted_fixed,y=residual_fixed))+geom_point(color="black")+geom_abline(slope = 0,intercept = 0,color="red",size=1)+xlab("Fitted Values of ln_allcrime (y-hat)")+ylab("Residuals")+theme_igray()+ggtitle("Informal Residual Plot To Check Heteroskedasticity")


export_summs(fixed_entity_model, scale = TRUE, transform.response = TRUE,model.names = "Entity Fixed Model",to.file = "xlsx",file.name = "Entity_Fixed_Model_table.xlsx")

# ENTITY-FIXED VS TIME & ENTITY FIXED
null2<-c("factor_year78=0","factor_year79=0","factor_year80=0","factor_year81=0","factor_year82=0","factor_year83=0","factor_year84=0","factor_year85=0","factor_year86=0","factor_year87=0","factor_year88=0","factor_year89=0","factor_year90=0","factor_year91=0","factor_year92=0","factor_year93=0","factor_year94=0","factor_year95=0","factor_year96=0","factor_year97=0","factor_year98=0","factor_year99=0")

linearHypothesis(fixed_time_entity_model,null2)
kable(linearHypothesis(fixed_time_entity_model,null2))
pFtest(fixed_time_entity_model,fixed_entity_model)

# Time Fixed Effects are needed (factor year is needed)
coefplot(fixed_time_model)
incar
# Choosing between entity and time Fixed Effect and OLS Pooling Model

#Null Hypothesis: Ols Model Better than entity and timeFixed effect Model(B1,1=B1,2=B1,3=....=B1,90)
#Alternative Hypothesis: entity and time Fixed effect Model is better than Ols Model(NOT ALL THE INTERCEPTS ARE EQUAL)

pFtest(fixed_time_entity_model,ols_model_log_all_crime)

# We Reject the null hypothesis and conclude that the entity and time fixed effect model is indeed better than the ols pooling model

# Comparing Between Fixed Effects and Pooled OLS Estimator

kable(tidy(pFtest(fixed_time_entity_model,ols_model_log_all_crime))) 

fixef(fixed_time_entity_model)
kable(fixef(fixed_entity_model))

# The Entity and Time fixed Effects model with cluster robust standard errors
coeftest(fixed_time_model, vcov=vcovHC(fixed_time_model, cluster="group"))  




# Random Effects Model:
random_model<-plm(all_crime~incarc_rate+pb1064+pw1064+pm1029+pop+avginc+I(avginc^2)+density+factor_shall+factor_year,data = p_dat,model = "random")
summary(random_model)
coefplot(random_model)

# Compare between Fixed effects and random effects Model
# Null: RANDOM EFFECTS IS BETTER
# ALTERNATIVE: FIXED EFFECTS IS BETTER
phtest(random_model,fixed_time_model)


#Random Effects Vs Pooling Ols

plmtest(ols_model2,type = c("bp"))
# Here we reject the null hypotheisis and conclude there is a panel effect, Significant differene across states

#TO DO 
# 
#
#
#


hist(vio)
hist(all_crime)
hist(rob)
hist(mur)
skewness(all_crime)
skewness(vio)
skewness(rob)
skewness(mur)

guns_data$log_vio<- log(vio)
guns_data$log_mur<- log(mur)
guns_data$log_all_crime<- log(all_crime)
guns_data$log_rob<- log(rob)

View(guns_data)

attach(guns_data)

hist(log_all_crime)
skewness(log_all_crime)

hist(log_mur)
skewness(log_mur)
hist(log_vio)
skewness(log_vio)
skewness(log_rob)
hist(log_rob)

View(p_dat)
names(guns_data)

p_dat$log_incarc<- log(incarc_rate)

p_dat$log_all_crime<- log(all_crime)
p_dat$log_vio<- log(vio)
p_dat$log_mur<- log(mur)
p_dat$log_rob<- log(rob)
p_dat$log_density<- log(density)
View(p_dat)

stargazer(ols_model_log_all_crime,fixed_entity_model,fixed_time_entity_model, column.labels=c("POOLED OLS","ENTITY FIXED","TIME AND ENTITY FIXED EFFECTS"),
          type="text",align = TRUE,title="Comparing Models", digits = 1, out="Comparing.docx")

# Logarithm should be only applied for the robbery variable


