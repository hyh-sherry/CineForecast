# LDA for plot_keywords
library(topicmodels)
library(tidytext)
library(ggplot2)
library(dplyr)
library(tidyverse)

path_plot = "pre_plot.csv"
plot <- read.csv(path_plot) 
plot <- subset(plot, select = -c(X))

plot <- tibble(plot)

plot <- plot %>% count(movie, word, sort = TRUE)

plot_dtm <- plot %>% cast_dtm(movie, word, n)

# Tune k (# of topics) if necessary
plot_lda <- LDA(plot_dtm, k = 8, control = list(seed = 661))
plot_lda

plot_topics <- tidy(plot_lda, matrix = "beta")
plot_topics

# Tune n (number of top words in each topic) if necessary
plot_terms <- plot_topics %>% 
  group_by(topic) %>%
  slice_max(beta, n = 30) %>% 
  ungroup() %>% 
  arrange(topic, -beta)

plot_terms


# Data pre-processing Part I
library(dplyr)
library(stringr)
library(tidyverse)
library(data.table)

path = "IMDB_data_Fall_2023.csv"
imdb <- read.csv(path)

path_plot = "pre_plot.csv"
plot <- read.csv(path_plot)
plot <- subset(plot, select = -c(X))

# 1. Remove irrelevant column
movie_title <- imdb$movie_title
movie_id <- imdb$movie_id
imdb_link <- imdb$imdb_link

imdb_1 <- subset(imdb, select = -c(movie_title, movie_id, imdb_link))


# 2. genres reclassification
genres <- imdb_1$genres

## find the non included genres
not_include = c('Biography', 'Comedy', 'Music', 'Fantasy', 'History', 
                'Mystery', 'Family', 'Documentary')

biography = rep(0, nrow(imdb))
comedy = rep(0, nrow(imdb))
music = rep(0, nrow(imdb))
fantasy = rep(0, nrow(imdb))
history = rep(0, nrow(imdb))
mystery = rep(0, nrow(imdb))
family = rep(0, nrow(imdb))
documentary = rep(0, nrow(imdb))

var_lst = list(biography, comedy, music, fantasy, history, mystery, family, documentary)

for (i in 1:nrow(imdb)) {
  for (j in 1:length(not_include)) {
    if (str_detect(genres[i], not_include[j])) {
      var_lst[[j]][i] = 1
    }
  }
}

biography = var_lst[[1]]
comedy = var_lst[[2]]
music = var_lst[[3]]
fantasy = var_lst[[4]]
history = var_lst[[5]]
mystery = var_lst[[6]]
family = var_lst[[7]]
documentary = var_lst[[8]]

## adding the genres col
imdb_2 = imdb_1
imdb_2$biography = biography
imdb_2$comedy = comedy
imdb_2$music = music
imdb_2$fantasy = fantasy
imdb_2$history = history
imdb_2$mystery = mystery
imdb_2$family = family
imdb_2$documentary = documentary

# 3. plot classification
topic1 = rep(0, nrow(imdb))
topic2 = rep(0, nrow(imdb))
topic3 = rep(0, nrow(imdb))
topic4 = rep(0, nrow(imdb))
topic5 = rep(0, nrow(imdb))
topic6 = rep(0, nrow(imdb))
topic7 = rep(0, nrow(imdb))
topic8 = rep(0, nrow(imdb))

plot_terms <- as.data.frame(plot_terms)

for (i in 1:nrow(plot)) {
  movie <- plot[i, 1]
  word <- plot[i, 2]
  
  # Find the topic using match or which
  matching_topics <- plot_terms[plot_terms[, 2] == word, 1]
  
  if (length(matching_topics) > 0) {
    for (j in 1:length(matching_topics)) {
      topic = matching_topics[j]
      if (topic == 1) {
        topic1[movie] = 1
      }
      
      if (topic == 2) {
        topic2[movie] = 1
      }
      
      if (topic == 3) {
        topic3[movie] = 1
      }
      
      if (topic == 4) {
        topic4[movie] = 1
      }
      
      if (topic == 5) {
        topic5[movie] = 1
      }
      
      if (topic == 6) {
        topic6[movie] = 1
      }
      
      if (topic == 7) {
        topic7[movie] = 1
      }
      
      if (topic == 8) {
        topic8[movie] = 1
      }
    }
  }
  
  print(paste("Complete iteration ", as.character(i)))
}


## adding the topic col
imdb_3 = imdb_2
imdb_3$plot_topic1 = topic1
imdb_3$plot_topic2 = topic2
imdb_3$plot_topic3 = topic3
imdb_3$plot_topic4 = topic4
imdb_3$plot_topic5 = topic5
imdb_3$plot_topic6 = topic6
imdb_3$plot_topic7 = topic7
imdb_3$plot_topic8 = topic8

path_output = "imdb_first_step_cleaning.csv"
write.csv(imdb_3, file = path_output, row.names = FALSE)


# Data preprocessing Part II
library(car)
path = "imdb_first_step_cleaning.csv"
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


### Check for multicollinearity for plot_keywords and genres
slice_plot_gen <- imdb[, c(22:34, 38:45, 46:53)]
corr_plot_gen <- cor(slice_plot_gen)
round(corr_plot_gen, 3)
# not include the variable music since singularities
reg5 <- lm(imdb_score ~ action + adventure + scifi + thriller + musical + romance +
             western + sport + horror + drama + war + animation + crime + biography + comedy +
             fantasy + history + mystery + family + documentary + plot_topic1 +
             plot_topic2 + plot_topic3 + plot_topic4 + plot_topic5 + plot_topic6 +
             plot_topic7 + plot_topic8, data = imdb)
vif(reg5)

## Outlier
### Film characteristics
qqPlot(reg1, envelope=list(style="none"))
plot(reg1) # normal q-q plot show that point 492 seems to be an outlier.
outlierTest(reg1)

### Cast characteristics
qqPlot(reg2, envelope=list(style="none"))
plot(reg2)
outlierTest(reg2)

### Production characteristics
qqPlot(reg3, envelope=list(style="none"))
plot(reg3)
outlierTest(reg3)


### remove the outlier and rerun reg1, reg2, reg3
imdb_alt <- imdb[-c(492), ]
reg1.1 <- lm(imdb_score ~ movie_budget + release_day + as.factor(release_month) +
               release_year + duration + as.factor(language) + as.factor(country) +
               as.factor(maturity_rating) + aspect_ratio +
               nb_news_articles + as.factor(colour_film) +
               nb_faces + action + adventure + scifi + thriller + musical + romance +
               western + sport + horror + drama + war + animation + crime +
               movie_meter_IMDBpro + biography + comedy + music +
               fantasy + history + mystery + family + documentary + plot_topic1 +
               plot_topic2 + plot_topic3 + plot_topic4 + plot_topic5 + plot_topic6 +
               plot_topic7 + plot_topic8, data = imdb_alt)
summary(reg1.1) # R^2 improved by 0.02 compared with reg1

reg2.1 <- lm(imdb_score ~ as.factor(actor1) +
               actor1_star_meter + as.factor(actor2) + actor2_star_meter +
               as.factor(actor3) + actor3_star_meter, data = imdb_alt)
summary(reg2.1) # No significant change compared with reg2

reg3.1 <- lm(imdb_score ~ as.factor(distributor) + as.factor(director) + 
               as.factor(cinematographer) + as.factor(production_company), data = imdb_alt)
summary(reg3.1) # No significant change compared with reg3

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

# Output the dataset without outlier
path_output = "imdb_without_outlier.csv"
write.csv(imdb_alt, file = path_output, row.names = FALSE)


































