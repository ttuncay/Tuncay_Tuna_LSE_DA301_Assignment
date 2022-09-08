## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
##performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points (Week 1)
## - how useful are remuneration and spending scores data (Week 2)
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns (Week 3)
## - what is the impact on sales per product (Week 4)
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
##     (Week 5)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales (Week 6).

################################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, Year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 4. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
library(tidyverse)

# Check the working directory
getwd()

# Set the working directory where my files are
setwd(dir='/Users/tunatuncay/Documents/Personal/LSE Data Analytics/Module 3/Module 3 Assignment/LSE_DA301_assignment_files')

# Import the data set.
turtle_sales <- read.csv('turtle_sales.csv', header=T)

# Print the data frame.
turtle_sales
view(turtle_sales)

# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
turtle_sales2 <- select(turtle_sales, -Ranking, -Year, -Genre, -Publisher)

# View the data frame.
turtle_sales2

# View the descriptive statistics.
summary(turtle_sales2)

# Product column indicates product ID, should not be aggregated
# Convert it to factor variable
turtle_sales3 <- mutate(turtle_sales2, Product=as.factor(Product))

# View the descriptive statistics again to make sure Product column not aggregated.
glimpse(turtle_sales3)
summary(turtle_sales3)

################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots
# Create scatterplots.
qplot(NA_Sales, EU_Sales, data=turtle_sales3, geom=c('point', 'smooth'))
qplot(NA_Sales, Global_Sales, data=turtle_sales3, geom=c('point', 'smooth'))
qplot(Global_Sales, EU_Sales, data=turtle_sales3, geom=c('point', 'smooth'))

## 2b) Histograms
# Create histograms.
qplot(EU_Sales, bins=20, data=turtle_sales3)
qplot(NA_Sales, bins=20, data=turtle_sales3)
qplot(Global_Sales, bins=20, data=turtle_sales3)

## 2c) Boxplots
# Create boxplots.
qplot(EU_Sales, data=turtle_sales3, geom='boxplot')
qplot(Global_Sales, data=turtle_sales3, geom='boxplot')
qplot(NA_Sales, data=turtle_sales3, geom='boxplot')

# Histogram and boxplot does not give correct understanding due to recurring items. 
# Example: Products repeat itself in different columns due to sales in different platforms.
filter(turtle_sales3, Product==3645)

# Therefore better to group df in product, sum sales and create visuals once again.

###############################################################################

# 3. Determine the impact on sales per product_id.

## 3a) Use the group_by and aggregate functions.

# Import necessary library dplyr
library(dplyr)

# Group data based on Product and determine the sum per Product.
turtle_grp_product <- turtle_sales3 %>% group_by(Product) %>%
  summarise(count = n(),
            Total_EU_Sales = sum(EU_Sales),
            Total_NA_Sales = sum(NA_Sales),
            Total_Global_Sales = sum(Global_Sales),
            .groups = 'drop')

# View the data frame.
View(turtle_grp_product)

# Explore the data frame.
summary(turtle_grp_product)
view(turtle_grp_product)

## 3b) Determine which plot is the best to compare game sales.
# Create scatterplots.
qplot(Total_NA_Sales, Total_EU_Sales, data=turtle_grp_product)
qplot(Total_NA_Sales, Total_Global_Sales, data=turtle_grp_product)
qplot(Total_Global_Sales, Total_EU_Sales, data=turtle_grp_product)

# Create histograms.
qplot(Total_NA_Sales, data=turtle_grp_product, bins=20)
qplot(Total_EU_Sales, data=turtle_grp_product, bins=20)
qplot(Total_Global_Sales, data=turtle_grp_product, bins=20)

# Create boxplots.
qplot(Total_NA_Sales, data=turtle_grp_product, geom='boxplot') # Box plot suggests NA sales more than ~10 are outliers.
qplot(Total_EU_Sales, data=turtle_grp_product, geom='boxplot') # Box plot suggests EU sales more than ~7 are outliers.
qplot(Total_Global_Sales, data=turtle_grp_product, geom='boxplot') # Box plot suggests Global sales more than ~22 are outliers.

# Filter outliers and check what products they are
filter(turtle_grp_product, Total_NA_Sales > 10)
filter(turtle_grp_product, Total_EU_Sales > 7)
filter(turtle_grp_product, Total_Global_Sales > 22)
filter(turtle_grp_product, Total_NA_Sales > 10 & Total_Global_Sales > 22 & Total_EU_Sales > 7)


###############################################################################

# 4. Observations and insights

# All sales data are right skewed, they do not show normal distribution.
# From the scatter plots, it seems like NA sales and Global sales & EU sales and Global sales are positively correlated. 
# Correlation between EU sales and NA sales is not that obvious.
# There are outliers in all sales regions. I checked the details in product breakdown.
# Same products are shown up in outlier section. It is possible that those products are high in price.
# I will check this with my previous analysis and see they are purchased by which customer group.

###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and maniulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 3. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 4. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4.
view(turtle_sales3)
head(turtle_sales3)
str(turtle_sales3)

# Check output: Determine the min, max, and mean values.
# NA_Sales
min(turtle_sales3$NA_Sales)
max(turtle_sales3$NA_Sales)
mean(turtle_sales3$NA_Sales)

# EU_Sales
min(turtle_sales3$EU_Sales)
max(turtle_sales3$EU_Sales)
mean(turtle_sales3$EU_Sales)

# Global_Sales
min(turtle_sales3$Global_Sales)
max(turtle_sales3$Global_Sales)
mean(turtle_sales3$Global_Sales)

# View the descriptive statistics.
summary(turtle_sales3)

###############################################################################

# 2. Determine the impact on sales or product_id
# Continued to work with df created in Week 4
# Created visuals using ggplot this time

# Recall the df grouped with product_id
head(turtle_grp_product)

# Create scatter plot
ggplot(turtle_grp_product, aes(x=Total_EU_Sales, y=Total_NA_Sales)) + geom_point()
ggplot(turtle_grp_product, aes(x=Total_EU_Sales, y=Total_Global_Sales)) + geom_point()
ggplot(turtle_grp_product, aes(x=Total_Global_Sales, y=Total_NA_Sales)) + geom_point()

# Create histograms
ggplot(turtle_grp_product, aes(x=Total_EU_Sales)) + geom_histogram()
ggplot(turtle_grp_product, aes(x=Total_NA_Sales)) + geom_histogram()
ggplot(turtle_grp_product, aes(x=Total_Global_Sales)) + geom_histogram()
# All sales data is right skewed and have outliers. Lets explore further with box plot.

# Create boxplots
ggplot(turtle_grp_product, aes(x=Total_EU_Sales)) + geom_boxplot()
ggplot(turtle_grp_product, aes(x=Total_NA_Sales)) + geom_boxplot()
ggplot(turtle_grp_product, aes(x=Total_Global_Sales)) + geom_boxplot()

###############################################################################

# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots
# Create Q-Q Plots.

# NA_Sales
qqnorm(turtle_grp_product$Total_NA_Sales)
qqline(turtle_grp_product$Total_NA_Sales)

# EU_Sales
qqnorm(turtle_grp_product$Total_EU_Sales)
qqline(turtle_grp_product$Total_EU_Sales)

# Global_Sales
qqnorm(turtle_grp_product$Total_Global_Sales)
qqline(turtle_grp_product$Total_Global_Sales)

## Q-Q plots suggests data is not normally distributed. 
## Let's explore further with Shapiro-Wilk test

## 2b) Perform Shapiro-Wilk test
# Install and import Moments.
library(moments)

# Perform Shapiro-Wilk test.
# Null hyptohesis: Data is normally distributed.
# Alternate hypothesis: Data is not normally distributed. 

# NA_Sales
shapiro.test(turtle_grp_product$Total_NA_Sales)
# p value (p-value < 2.2e-16) way lower than significance level.
# There is not enough evidence to disprove alternate hypothesis. 
# Null hypothesis can be rejected. Data is not normally distributed.

# EU_Sales
shapiro.test(turtle_grp_product$Total_EU_Sales)
# p value (p-value = 2.987e-16) way lower than significance level.
# There is not enough evidence to disprove alternate hypothesis. 
# Null hypothesis can be rejected. Data is not normally distributed.

# Global_Sales
shapiro.test(turtle_grp_product$Total_Global_Sales)
# p value (p-value < 2.2e-16) way lower than significance level.
# There is not enough evidence to disprove alternate hypothesis. 
# Null hypothesis can be rejected. Data is not normally distributed.


## 2c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.

# NA_Sales
skewness(turtle_grp_product$Total_NA_Sales)
kurtosis(turtle_grp_product$Total_NA_Sales)
# Skewness value (3.048198) greater than 1 indicates a highly skewed distribution
# Kurtosis value (15.6026) greater than 3 indicated leptokurtic (heavy tailed)

# EU_Sales
skewness(turtle_grp_product$Total_EU_Sales)
kurtosis(turtle_grp_product$Total_EU_Sales)
# Skewness value (2.886029) greater than 1 indicates a highly skewed distribution
# Kurtosis value (16.22554) greater than 3 indicated leptokurtic (heavy tailed)

# Global_Sales
skewness(turtle_grp_product$Total_Global_Sales)
kurtosis(turtle_grp_product$Total_Global_Sales)
# Skewness value (3.066769) greater than 1 indicates a highly skewed distribution
# Kurtosis value (17.79072) greater than 3 indicated leptokurtic (heavy tailed)

## 2d) Determine correlation
# Determine correlation.
# Data is not normally distributed. This is prerequisite for correlation check.
# However assumption of normality could be ignored given a large enough data sets because Central Limit Theorem.

# Create new df with only sales data (numeric variables)
cor_df <-select(turtle_grp_product, -Product, -count)
head(cor_df)

# Determine correlation among variable
cor(cor_df)

# Table suggest sales data between NA sales and Global sales & EU Sales and Global sales are highly correlated.
# Correlation between EU sales and NA sales is still positive but not as strong.
# This is inline which what is identified on scatter plots.
###############################################################################


# 3. Plot the data
# Create plots to gain insights into data.

ggplot(turtle_grp_product, aes(x=Total_EU_Sales, y=Total_Global_Sales)) +
  geom_point() +
  geom_smooth() +
  labs(title ='Correlation between EU Sales and Global Sales',
       subtitle = 'Scatter Plot for EU Sales vs Global Sales',
       x = 'EU Sales',
       y = 'Global Sales') +
  theme_minimal()

ggplot(turtle_grp_product, aes(x=Total_NA_Sales, y=Total_Global_Sales)) +
  geom_point() +
  geom_smooth() +
  labs(title ='Correlation between North America Sales and Global Sales',
       subtitle = 'Scatter Plot for North America Sales vs Global Sales',
       x = 'North America Sales',
       y = 'Global Sales') +
  theme_minimal()

ggplot(turtle_grp_product, aes(x=Total_NA_Sales, y=Total_EU_Sales)) +
  geom_point() +
  geom_smooth() +
  labs(title ='Correlation between North America Sales and EU Sales',
       subtitle = 'Scatter Plot for North America Sales vs EU Sales',
       x = 'North America Sales',
       y = 'EU Sales') +
  theme_minimal()
 
###############################################################################


# 4. Plot the data (ieth customer segments)
# Lets bring df created in python that enables me to group products in terms of customer groups.

# Import the data set.
customer_segments <- read.csv('review_df_final.csv', header=T)

# Print the data frame.
customer_segments
view(customer_segments)

# Merge this df with product sales df to bring customer segments in.
turtle_product_segment <- merge(x=turtle_grp_product, y=customer_segments, by='Product')

# View the data frame.
head(turtle_product_segment)

# Replot scatter plot with 3rd variable customer segments
ggplot(turtle_product_segment, aes(x=Total_NA_Sales, y=Total_Global_Sales, col=Customer_Segments)) +
  geom_point(alpha=1) +
  labs(title ='Correlation between North America Sales and Global Sales',
       subtitle = 'Scatter Plot for North America Sales vs Global Sales in Customer Segment Detail',
       x = 'North America Sales',
       y = 'Global Sales') +
  theme_minimal()

ggplot(turtle_product_segment, aes(x=Total_EU_Sales, y=Total_Global_Sales, col=Customer_Segments)) +
  geom_point(alpha=1) +
  labs(title ='Correlation between EU Sales and Global Sales',
       subtitle = 'Scatter Plot for EU Sales vs Global Sales in Customer Segment Detail',
       x = 'EU Sales',
       y = 'Global Sales') +
  theme_minimal()

###############################################################################

# 4. Observations and insights
# Data is not normally distributed. That was something already identified in week 4.This is prerequisite for correlation check.
# However assumption of normality could be ignored given a large enough data sets because Central Limit Theorem.
# Correlation between EU sales and Global Sales & NA sales and Global Sales is highly positively correlated.
# Finally I combined the dataframe I created withg python includes customer clusters with products.
# Then recreated the scatter plots to see correlation between sales in customer segments detail.

###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
##  - NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
##  - NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
##  - NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
##  - NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explore the data
# View data frame created in Week 5.
view(turtle_grp_product)
view(turtle_sales3)

# Determine a summary of the data frame.
summary(turtle_sales3)
summary(turtle_grp_product)

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns
cor(select(turtle_sales3, -Product, -Platform))

# EU_Sales vs NA_Sales
# Create a linear regression model on the original data.
model_eu_na <- lm(EU_Sales~NA_Sales, data=turtle_sales3)
summary(model_eu_na)

# Checking linear relationship
plot(model_eu_na,1) 
# Ideally we want horizontal line around 0. Our is not due to outliers.

## 2b) Create a plot (simple linear regression)
# Basic visualisation.
plot(turtle_sales3$NA_Sales, turtle_sales3$EU_Sales)
abline(coefficients(model_eu_na))

# Calculate the sum of squares error (SSE) to determine strength.
SSE_eu_na = sum(model_eu_na$residuals^2)

# View the result.
SSE_eu_na
# Very  high SSE (723.4159). SSE_eu_na is a poor fit.

# EU_Sales vs Global_Sales
# Create a linear regression model on the original data.
model_global_eu <- lm(Global_Sales~EU_Sales, data=turtle_sales3)
summary(model_global_eu)

# Checking linear relationship
plot(model_global_eu,1) 
# Ideally we want horizontal line around 0. Our is not.

## 2b) Create a plot (simple linear regression)
# Basic visualisation.
plot(turtle_sales3$EU_Sales, turtle_sales3$Global_Sales)
abline(coefficients(model_global_eu))

# Calculate the sum of squares error (SSE) to determine strength.
SSE_global_eu = sum(model_global_eu$residuals^2)

# View the result.
SSE_global_eu
# Very  high SSE (3167.155). SSE_global_eu even worse. Poor fit.

# NA_Sales vs Global_Sales
# Create a linear regression model on the original data.
model_global_na <- lm(Global_Sales~NA_Sales, data=turtle_sales3)
summary(model_global_na)

# Checking linear relationship
plot(model_global_na,1) 
# Ideally we want horizontal line around 0. Our is not.
# It is the worst of all.

## 2b) Create a plot (simple linear regression)
# Basic visualisation.
plot(turtle_sales3$NA_Sales, turtle_sales3$Global_Sales)
abline(coefficients(model_global_na))

# Calculate the sum of squares error (SSE) to determine strength.
SSE_global_na = sum(model_global_na$residuals^2)

# View the result.
SSE_global_na
# High SSE (1734.163). Better fit than Global_Sales ~ EU_Sales
# This model (Global vs NA sales) has the highest R-squared. 


###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
turtle_sales4 <- select(turtle_sales3, -Product, -Platform)
view(turtle_sales4)

# Multiple linear regression model.
model_multiple <- lm(Global_Sales ~ EU_Sales + NA_Sales, data=turtle_sales4)
summary(model_multiple)
# Very high R-squared value. Suggest model will be a good fit to predict global sales.

# Checking linear relationship
plot(model_multiple,1) 
# Ideally we want horizontal line around 0. Our is not.

# Calculater the sum of squares error (SSE) to determine strength.
SSE_multiple = sum(model_multiple$residuals^2)

# View the result.
SSE_multiple
# High SSE (431.3706). Better fit than simple linear regression models.
# Closer to 0 is best fit for model.

###############################################################################

# 4. Predictions based on given values
# Create a new df with provided values
predict_df <- data.frame(NA_Sales=c(34.02,3.93,2.73,2.26,22.08), EU_Sales=c(23.80, 1.56, 0.65, 0.97, 0.52))

# View df to check values
predict_df

# Predict values for provided sales values 
predict(model_multiple, newdata = predict_df)

# Add predictions to df
predict_df$Predict_Global_Sales <- predict(model_multiple, newdata = predict_df)

# View df to check values
predict_df

# Compare with observed values for a number of records.

# Filter actual global sales value from dataframe
filter(turtle_sales4, NA_Sales == 34.02, EU_Sales==23.80)
filter(turtle_sales4, NA_Sales == 3.93, EU_Sales==1.56)
filter(turtle_sales4, NA_Sales == 2.73, EU_Sales==0.65)
filter(turtle_sales4, NA_Sales == 2.26, EU_Sales==0.97)
filter(turtle_sales4, NA_Sales == 22.08, EU_Sales==0.52)

# Put them as a seperate column in predictions df
predict_df$Actual_Global_Sales <- c((select(filter(turtle_sales4, NA_Sales == 34.02, EU_Sales==23.80), -NA_Sales, -EU_Sales)),
                                    (select(filter(turtle_sales4, NA_Sales == 3.93, EU_Sales==1.56), -NA_Sales, -EU_Sales)),
                                    (select(filter(turtle_sales4, NA_Sales == 2.73, EU_Sales==0.65), -NA_Sales, -EU_Sales)),
                                    (select(filter(turtle_sales4, NA_Sales == 2.26, EU_Sales==0.97), -NA_Sales, -EU_Sales)),
                                    (select(filter(turtle_sales4, NA_Sales == 22.08, EU_Sales==0.52), -NA_Sales, -EU_Sales)))
                                    # This creates a list in data frame. Does not allow me to make further calculation

# Convert list of Global Actual Sales to Dataframe
# Install necessary library plyr
library(plyr)
df_temp <- ldply(predict_df$Actual_Global_Sales, data.frame)

# View the temproray dataframe
df_temp

# Put column from temproray df with values to Actual Global Sales
predict_df$Actual_Global_Sales <-df_temp$X..i..

# View df and check structure again
predict_df
str(predict_df)

# Import library forecast to use accuracy function
library(forecast)

# Check for Accuracy of the model
accuracy(predict_df$Predict_Global_Sales,predict_df$Actual_Global_Sales)
# MAPE is 10.30286. This is a very good value.
# As rule of thumb MAPE <10% is excellent, <20% is good. 
# This is close to excellent.

# Calculating the diversion of Prediction from Actual
predict_df$Diversion <- round((predict_df$Predict_Global_Sales-predict_df$Actual_Global_Sales),2)

# View dataframe for evaluation of prediction
predict_df

# Lets predict all Global Sales with all data in the dataframe to see how successful is the model
predictall_df <- turtle_sales4

# Predict values for provided sales values 
predict(model_multiple, newdata = predictall_df)

# Add predictions to df
predictall_df$Predict_Global_Sales <- predict(model_multiple, newdata = predictall_df)

# Change Global Sales column name into Actual_Global_Sales to avoid confusion
colnames(predictall_df)[3] <- 'Actual_Global_Sales'

# View df to check values
head(predictall_df)

# Check for Accuracy of the model
accuracy(predictall_df$Predict_Global_Sales,predictall_df$Actual_Global_Sales)
# MAPE is 46.33867.
# As rule of thumb MAPE <10% is excellent, <20% is good. 
# Once we feed all values to model, the prediction accuracy dropped significantly. 
# The reason behind may be my data is not linear. I may need to convert my data to linear.

# Calculating the diversion of Prediction from Actual
predictall_df$Diversion <- round((predictall_df$Predict_Global_Sales-predictall_df$Actual_Global_Sales),2)

# View dataframe for evaluation of prediction
head(predictall_df)

# Check the range for diversion with summary function
summary(predictall_df$Diversion)

# Check values for min and max values
# It seems like high diversion occors where EU / NA sales are close to 0.
# Max value
filter(predictall_df, Diversion==3.620000)

# Min value
filter(predictall_df, Diversion==-7.460000)

# Create an interactive scatter plot to better understand actual vs prediction with diversion
# Import necessary libraries
library(plotly)

# Create the interactive visual
plot <- ggplot(predictall_df,aes(x=Actual_Global_Sales, y=Predict_Global_Sales, col=Diversion))+geom_point()
ggplotly(plot)

################################################################################

# 5. Observations and insights
# High R squared in multiple linear regression model suggests a good fit.
# Checking multiple values suggested around 10% MAPE value which is close to excellent.
# However once I predicted values for all eu and na sales, MAPE increases to 40.
# Data may need further work as to convert it to linear.

###############################################################################
###############################################################################




