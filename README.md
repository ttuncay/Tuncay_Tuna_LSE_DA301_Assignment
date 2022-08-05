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

