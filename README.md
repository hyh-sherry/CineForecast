# CineForecast

Team: Ge Gao, Hongyi Zhan, Yu Lu, Yanhuan Huang

<img src="plots/readme_png.png" width="1000">

## Overview

In the fast-paced, data-driven landscape of today, making accurate predictions based on past and present data is crucial. This necessity is particularly evident in industries such as entertainment, where a film's success can significantly impact financial and reputational outcomes. The primary objective was to leverage the knowledge acquired to build robust statistical models capable of addressing the diverse challenges inherent in this domain. 

## Data Description
The dataset comprises 1,930 primarily English-language movies, encompassing 16 categorical and 25 numerical independent variables, including 13 binary genre variables. IMDB scores, spanning 1.9 to 9.3, demonstrate a left-skewed distribution, highlighting movies scoring between 6 and 7. The independent variables were categorized into cast, film, and production characteristics for analysis.

## Data Preprocessing
Data preprocessing focused on genre and plot keyword extraction. Genres were comprehensively enumerated, and plot keywords were indexed and saved for detailed analysis. Latent Dirichlet Allocation (LDA) was utilized to identify eight distinct plot themes. The dataset was then refined by excluding irrelevant columns and creating binary indicators for plot themes. During regression analysis, heteroskedasticity was found in cast-related variables, non-linear patterns in film attributes, and six outliers in IMDB score and film characteristics. Notably, the outlier related to "Star Wars: Episode IV - A New Hope" was removed. These steps ensure a robust foundation for subsequent analyses, guaranteeing accurate model development and reliable results.

## Model Selection
#### Initial Dataset Refinement:
Essential variables were prioritized, removing genres and plot keywords to simplify the dataset and reduce noise and complexity.
#### Binary Transformation of Variables: 
Country, language, and release month were transformed into binary categories, highlighting geographical, linguistic, and seasonal influences on movie ratings.
#### Reclassification of Director and Actor Variables: 
Director and Leading Actor variables were reclassified based on frequency, enhancing their impact assessment on film characteristics.
#### Development of Linear Regression Models: 
Two primary linear regression models, BCS and LASSO, were created, integrating predictors like movie budget and release details, crucial for understanding audience ratings and film success.
#### Incorporation of Spline Transformations: 
Spline transformations captured non-linear relationships, enabling modeling of intricate patterns in variables like duration, movie budget, and release year.
#### Balancing Model Complexity: 
A backward stepwise selection method refined the model by emphasizing significant predictors, enhancing efficiency based on the Akaike Information Criterion.
#### Model Comparison Using ANOVA: 
ANOVA was utilized to compare models with and without the maturity rating variable, ensuring the final model's efficiency and effectiveness in explaining IMDB scores.

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

## Team contributions

- **Ge Gao**: Focused on data preprocessing and Latent Dirichlet Allocation (LDA). This involved cleaning and organizing the raw data to make it suitable for analysis and using LDA to uncover latent topics that might influence IMDb ratings.

- **Hongyi Zhan**: Concentrated on the modeling and testing phase. This included developing predictive models based on the preprocessed data and rigorously testing these models to ensure accuracy and reliability in predicting IMDb ratings.

- **Yu Lu**: Responsible for reporting. This role entailed documenting the methodologies, findings, and insights derived from the data analysis and modeling, and presenting them in a coherent and understandable manner.

- **Yanhuan Huang**: Focused on Exploratory Data Analysis (EDA) and visualization. This task involved exploring the data to find patterns, anomalies, trends, or relationships and using visual tools to illustrate these findings, which can provide intuitive insights into the data set.
  
