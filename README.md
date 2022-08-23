# Tuncay_Tuna_LSE_DA301_Assignment
LSE Data Analytics Career Accelerator Module 3 Assigment

Week 1:

Imported turtles_review csv file and check the data through. There were no missing values therefore cleaning was straightforward. Since I don’t want any aggregation on product code, I covert its type to object.

I exported and saved the new clean csv file for upcoming weeks analysis.

I created a simple linear regression model on 3 different independent variables (age, renumeration, spending) vs one dependent variable (loyalty). Below are my findings for each one of them:

spending vs loyalty:
•	R-squared value is 45.2% meaning dependent variable’s 45% can be explained by this independent variable if rest remain same. 
•	Coefficient value is 33.06, meaning that each additional spending increases loyalty by 33. 

renumeration vs loyalty:
•	R-squared value is 38% meaning dependent variable’s 38% can be explained by this independent variable if rest remain same. 
•	Coefficient value is 34.18, meaning that each additional spending increases loyalty by 34. 

age vs loyalty:
•	R-squared value is 0.2% meaning that dependent variable simply cannot be expolained by this independent variable. 
•	Coefficient value is -4.01, meaning that each additional age decreases loyalty by -4. 

Week 2:

Worked on clustering the data based on renumeration and spending score. For the sake of the model, reimported data as a new data frame and crosschecked the data. To determine the k-values, applied elbow and silhouette methods. 

Silhouette method clearly suggested k value as 5. Whereas elbow method made me think of values 5-7. 

When I visually inspect the data by eye, it is obvious there are 5 clusters. However, 2 outlier groups can also be considered as separate clusters. Therefore, I prefer to move forward with 7 clusters.

Week 3:

Worked on sentiment analysis using NLP capabilities of Python. Constructed word cloud to identify what people mention the most in their reviews and summaries. 

Summary:
•	Great, fun, five stars are the most visible ones in summary word cloud. Those can also be proof checked by word counter. Those words are in top 5 in terms of usage frequency in summary.
•	Polarity identified for each summary provided. Compound polarity is 0.22 which indicates sentiment is on positive side. This also sense checks the outcome of word cloud and frequently used words.

Review: 
•	Like summary, word cloud is created for reviews also. Game, play, great, like are most visible words. Word counter indicates similar results. 
•	Polarity for review is slightly lower than summary but it is still positive and 0.21.

To get better understanding and check how sentiment analysis working, I listed top 20 positive and negative sentiment for review and summary.

Review:
•	In general, negative sentiments for reviews indicates how hard to understand directions and somehow the game is boring. However, once the negative sentiment gets closer to neutral, I would say comments are rather positive than negative. I think there is still chance to improve the model. 
•	Positive sentiment reviews (I viewed only top 20, and all has perfect positive sentiment of 1) suggest the game is awesome, it is fun, best gift ever etc. It looks like positive sentiment analysis works better than negative sentiment analysis for reviews.

Summary: 
•	Negative sentiments focus on how boring the game is and how disappointed they are. Top 20 negative sentiment on summary all makes sense and model looks working well. In here, comments are usually single word comments therefore it is much easier for the model to apply sentiment analysis and it is much accurate.
•	Positive sentiments again like reviews are combination of comments with polarity 1.  short and concise comments enable model to identify positive sentiment with good accuracy.

Week 4:

Started exploring turtle_sales data using R. After importing the data as a dataframe sense check the data. There were no missing values. Product column was defined whereas it indicated product ID. Converted into factor to eliminate aggregation.

Experimented multiple plots to sense check the data. Original data is in Product code/ID level. Therefore, histogram and box plot did not make sense much due to duplicate sales of products. Scatter plot indicates there is a positive correlation between global sales with others as expected. 

Grouped the data on products to eliminate duplicated sales on products. Created a summary df with sum of sales in regions. Histogram and box plot helped to identify outliers in the data. However due to too many distinct products (169), grouping did not help much to summarize the data, I tried grouping by platform and at least by this way I managed to group sales in 22 categories.  

