# CineForecast

Team: Ge Gao, Hongyi Zhan, Yu Lu, Yanhuan Huang

## Overview

In the fast-paced, data-driven landscape of today, making accurate predictions based on past and present data is crucial. This necessity is particularly evident in industries such as entertainment, where a film's success can significantly impact financial and reputational outcomes. The primary objective was to leverage the knowledge acquired to build robust statistical models capable of addressing the diverse challenges inherent in this domain. 

## Data Description
The dataset comprises 1,930 primarily English-language movies, encompassing 16 categorical and 25 numerical independent variables, including 13 binary genre variables. IMDB scores, spanning 1.9 to 9.3, demonstrate a left-skewed distribution, highlighting movies scoring between 6 and 7. The independent variables were categorized into cast, film, and production characteristics for analysis.

## Data Preprocessing
Data preprocessing focused on genre and plot keyword extraction. Genres were comprehensively enumerated, and plot keywords were indexed and saved for detailed analysis. Latent Dirichlet Allocation (LDA) was utilized to identify eight distinct plot themes. The dataset was then refined by excluding irrelevant columns and creating binary indicators for plot themes. During regression analysis, heteroskedasticity was found in cast-related variables, non-linear patterns in film attributes, and six outliers in IMDB score and film characteristics. Notably, the outlier related to "Star Wars: Episode IV - A New Hope" was removed. These steps ensure a robust foundation for subsequent analyses, guaranteeing accurate model development and reliable results.

## Model Selection
In model selection process, the initial step involved refining the IMDB dataset by excluding variables like genres and plot keywords to minimize complexity and noise. Essential transformations were applied, converting country, language, and release month into binary categories, emphasizing geographical, linguistic, and seasonal influences. Director and Leading Actor variables were reclassified based on frequency, enhancing their impact assessment. BCS and LASSO were developed to incorporate crucial predictors such as movie budget and release details, essential for understanding audience ratings and film success. Spline transformations were introduced to capture non-linear relationships in variables like duration, movie budget, and release year, allowing the modeling of intricate patterns. A backward stepwise selection method balanced model complexity by refining it to include only significant predictors, guided by the Akaike Information Criterion (AIC). Finally, ANOVA was utilized to compare models with and without the maturity rating variable, ensuring the final model's efficiency and effectiveness in explaining IMDB scores.

## Results
In predictive performance, the model achieved an R-squared value of 0.4191, explaining 41.91% of IMDB score variability. The adjusted R-squared, accounting for model complexity, was 0.4105. The final linear regression model, showed moderate predictive accuracy with a Mean Absolute Error (MAE) of approximately 0.61 and a Mean Squared Error (MSE) of around 0.70. Several significant predictors are as follows:
- Movie Budget
- Release Year
- Duration
- Country
- Maturity Rating
- Number of News Articles
- Number of Faces in Poster
- Genre
- 2023 IMDB Movie Rating
- Director and Leading Actor

## Libraries Used
#### Preprocessing
- **topicmodels**
- **stringr**
#### Modelling
- **rpart**
- **boot**
- **caret**
- **car**
- **glmnet**
- **splines**
- **Pandas**
- **numpy**

  
