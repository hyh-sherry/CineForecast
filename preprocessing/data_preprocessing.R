# Data preprocessing
library(car)
path = "/Users/sunnygao/Desktop/midterm_project/preprocessing/imdb_first_step_cleaning.csv"
imdb <- read.csv(path)
imdb <- subset(imdb, select = -c(genres, plot_keywords))

# reg1 <- lm(imdb_score ~ movie_budget + release_day + as.factor(release_month) +
#              release_year + duration + as.factor(language) + as.factor(country) +
#              as.factor(maturity_rating) + aspect_ratio + as.factor(distributor) +
#              nb_news_articles + as.factor(director) + as.factor(actor1) +
#              actor1_star_meter + as.factor(actor2) + actor2_star_meter +
#              as.factor(actor3) + actor3_star_meter + as.factor(colour_film) +
#              nb_faces + action + adventure + scifi + thriller + musical + romance +
#              western + sport + horror + drama + war + animation + crime + 
#              movie_meter_IMDBpro + as.factor(cinematographer) + 
#              as.factor(production_company) + biography + comedy + music + 
#              fantasy + history + mystery + family + documentary + plot_topic1 +
#              plot_topic2 + plot_topic3 + plot_topic4 + plot_topic5 + plot_topic6 +
#              plot_topic7 + plot_topic8, data = imdb)

##### Prevent from overflowing, I run the regression based on the 
##### variables category given in the data dictionary

# Film characteristics
reg1 <- lm(imdb_score ~ movie_budget + release_day + as.factor(release_month) +
             release_year + duration + as.factor(language) + as.factor(country) +
             as.factor(maturity_rating) + aspect_ratio +
             nb_news_articles + as.factor(colour_film) +
             nb_faces + action + adventure + scifi + thriller + musical + romance +
             western + sport + horror + drama + war + animation + crime +
             movie_meter_IMDBpro + biography + comedy + music +
             fantasy + history + mystery + family + documentary + plot_topic1 +
             plot_topic2 + plot_topic3 + plot_topic4 + plot_topic5 + plot_topic6 +
             plot_topic7 + plot_topic8, data = imdb)

# Cast characteristics
reg2 <- lm(imdb_score ~ as.factor(actor1) +
             actor1_star_meter + as.factor(actor2) + actor2_star_meter +
             as.factor(actor3) + actor3_star_meter, data = imdb)

# Production characteristics
reg3 <- lm(imdb_score ~ as.factor(distributor) + as.factor(director) + 
             as.factor(cinematographer) + as.factor(production_company), data = imdb)

##### The contents follow the steps in the PDF

# Step 2: EXPLORE THE VARIABLES INDIVIDUALLY
## Corrlation matrix
require('psych')
quantvars=imdb[, c(1, 2, 3, 5, 6, 10, 12, 15, 
                   17, 19, 21, 35)] # choose only quantity column
corr_matrix=cor(quantvars)
round(corr_matrix,3)

## Collinearity
reg4 <- lm(imdb_score ~ movie_budget + release_day + release_year + duration +
             aspect_ratio + nb_news_articles + actor1_star_meter + actor2_star_meter +
             actor3_star_meter + nb_faces + movie_meter_IMDBpro, data = imdb)
vif(reg4) # result shows that no collinearity issue with the selected features

## Outlier
### Film characteristics
qqPlot(reg1, envelope=list(style="none"))
outlierTest(reg1)

### Cast characteristics
qqPlot(reg2, envelope=list(style="none"))
outlierTest(reg2)

### Production characteristics
qqPlot(reg3, envelope=list(style="none"))
outlierTest(reg3)

# Step 3: EXPLORE VARIABLE RELATIONSHIPS
## Correlation coefficient between y and each x
y <- imdb$imdb_score
corr_val <- c()
x_labels <- c()
for (i in 2:ncol(imdb)) {
  x_name = colnames(imdb)[i]
  x <- imdb[,i]
  if (is.numeric(x)) { # can only compute the corr between numerical values
    correlation = cor(x, y)
    x_labels<- c(x_labels, x_name)
    corr_val<- c(corr_val, correlation)
  }
}
correlation_df <- data.frame(x_labels, corr_val)

## Heteroskedasticity
ncvTest(reg1)
ncvTest(reg2)
ncvTest(reg3)

require(lmtest)
require(plm)
coeftest(reg1, vcov=vcovHC(reg1, type="HC1"))
coeftest(reg2, vcov=vcovHC(reg2, type="HC1"))
coeftest(reg3, vcov=vcovHC(reg3, type="HC1"))

# The p-values and the r-squared of each regression
## Film characteristics
summary(reg1) # could be used for feature selection
## Cast characteristics
summary(reg2) # could be used for feature selection
## Production characteristics
summary(reg3) # could be used for feature selection


# Step 4: Non-linearity
## Film characteristics
summary(reg1) # could be used for feature selection
residualPlot(reg1) # non linear as the test shown
residualPlots(reg1)

## Cast characteristics
summary(reg2) # could be used for feature selection
residualPlot(reg2) # linear as the test shown
residualPlots(reg2)

## Production characteristics
summary(reg3) # could be used for feature selection
residualPlot(reg3) # linear as the test shown
residualPlots(reg3)

