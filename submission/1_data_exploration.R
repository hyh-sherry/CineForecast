
## Read in CSV
imdb = read.csv("IMDB_data_fall_2023.csv")
attach(imdb)

summary(imdb)
sapply(imdb, class)
summary(imdb$imdb_score)

   
## Data Exploration
library(car)
library(ggplot2)
require(methods)

#### IMDb Score
png(file="plots/hist_imdb_score.png", width=1000, height=600)
hist(imdb_score, breaks = 100, col = "skyblue")

## Numerical Variables
#### Movie Budget
png(file="plots/hist_movie_budget.png", width=1000, height=600)
hist(movie_budget, breaks = 50, col = "skyblue")
table(movie_budget)

png(file="plots/imdb_vs_budget.png", width=800, height=450)
plot(movie_budget, imdb_score, col = "grey", main = "imdb_score VS budget", xlab = "movie_budget", ylab = "imdb_score")

reg1 = lm(imdb_score ~ movie_budget)
summary(reg1)

#### Duration
png(file="plots/hist_duration.png", width=1000, height=600)
hist(duration, breaks = 100, col = "skyblue")

png(file="plots/box_duration.png", width=800, height=500)
boxplot(duration, col = "orange", boxwex = 0.5)
title("Boxplot for duration Variable")

library(e1071)
skewness(duration)

png(file="plots/imdb_vs_duration.png", width=800, height=450)
plot(duration, imdb_score, col = "grey", main = "imdb_score VS duration", xlab = "duration", ylab = "imdb_score")
imdb[imdb$duration > 300, ]

reg2 = lm(imdb_score ~ duration)
summary(reg2)
qqPlot(reg2, envelope=list(style="none"))

outlierTest(reg2)
imdb[c(395, 191, 1806),]

#### Release Year
png(file="plots/hist_release_year.png", width=1000, height=600)
hist(release_year, breaks = 100, col = "skyblue")

png(file="plots/imdb_vs_release_year.png", width=800, height=450)
plot(release_year, imdb_score, col = "grey", main = "score VS release_year", xlab = "release_year", ylab = "imdb_score")

reg3 = lm(imdb_score ~ release_year)
summary(reg3)

#### Release Day
png(file="plots/hist_release_day.png", width=1000, height=600)
hist(release_day, breaks = 30, col = "skyblue")

png(file="plots/imdb_vs_release_day.png", width=800, height=450)
plot(release_day, imdb_score, col = "grey", main = "score VS release_day", xlab = "release_day", ylab = "imdb_score")

reg4 = lm(imdb_score ~ release_day)
summary(reg4)

#### Aspect Ratio
png(file="plots/box_aspect_ratio.png", width=800, height=500)
boxplot(aspect_ratio, col = "orange", boxwex = 0.5)
title("Boxplot for aspect_ratio Variable")

png(file="plots/imdb_vs_aspect_ratio.png", width=800, height=450)
plot(aspect_ratio, imdb_score, col = "grey", main = "score VS aspect_ratio", xlab = "aspect_ratio", ylab = "imdb_score")
table(aspect_ratio)

reg5 = lm(imdb_score ~ aspect_ratio)
summary(reg5)

png(file="plots/release_year_vs_aspect_ratio.png", width=800, height=450)
plot(aspect_ratio, release_year, col = "grey", main = "release_year VS aspect_ratio", xlab = "aspect_ratio", ylab = "release_year")

#### Number of faces
png(file="plots/box_nbfaces.png", width=800, height=500)
boxplot(nb_faces, col = "orange", boxwex = 0.5)
title("Boxplot for nb_faces Variable")
table(nb_faces)
summary(nb_faces)

png(file="plots/imdb_vs_nbfaces.png", width=800, height=450)
plot(nb_faces, imdb_score, col = "grey", main = "score VS nb_faces", xlab = "nb_faces", ylab = "imdb_score")
imdb[imdb$nb_faces > 30, ]
  
reg6 = lm(imdb_score ~ nb_faces)
summary(reg6)
qqPlot(reg6, envelope=list(style="none"))

#### Number of news articles
png(file="plots/box_nbarticles.png", width=800, height=500)
boxplot(nb_news_articles, col = "orange", boxwex = 0.5)
title("Boxplot for nb_news_articles Variable")

summary(nb_news_articles)

png(file="plots/imdb_vs_nbarticles.png", width=800, height=450)
plot(nb_news_articles, imdb_score, col = "grey", main = "score VS nb_news_articles", xlab = "nb_news_articles", ylab = "imdb_score")
imdb[imdb$nb_news_articles > 60000, ]

reg10 = lm(imdb_score ~ nb_news_articles)
summary(reg10)
qqPlot(reg10, envelope=list(style="none"))

#### Actor Star Meter
png(file="plots/box_actor1_star_meter.png", width=800, height=500)
boxplot(actor1_star_meter, col = "orange", boxwex = 0.5)
title("Boxplot for actor1_star_meter Variable")

summary(actor1_star_meter)
imdb[imdb$actor1_star_meter == 8342201, ]

png(file="plots/imdb_vs_actor1_star_meter.png", width=800, height=450)
plot(actor1_star_meter, imdb_score, col = "grey", main = "score VS actor1_star_meter", xlab = "actor1_star_meter", ylab = "imdb_score")

reg7 = lm(imdb_score ~ actor1_star_meter)
summary(reg7)

png(file="plots/box_actor2_star_meter.png", width=800, height=500)
boxplot(actor2_star_meter, col = "orange", boxwex = 0.5)
title("Boxplot for actor2_star_meter Variable")

png(file="plots/imdb_vs_actor2_star_meter.png", width=800, height=450)
plot(actor2_star_meter, imdb_score, col = "grey", main = "score VS actor2_star_meter", xlab = "actor2_star_meter", ylab = "imdb_score")

reg8 = lm(imdb_score ~ actor2_star_meter)
summary(reg8)

png(file="plots/box_actor3_star_meter.png", width=800, height=500)
boxplot(actor3_star_meter, col = "orange", boxwex = 0.5)
title("Boxplot for actor3_star_meter Variable")

png(file="plots/imdb_vs_actor3_star_meter.png", width=800, height=450)
plot(actor3_star_meter, imdb_score, col = "grey", main = "score VS actor3_star_meter", xlab = "actor3_star_meter", ylab = "imdb_score")

reg8 = lm(imdb_score ~ actor3_star_meter)
summary(reg8)

#### Movie Meter
png(file="plots/hist_movie_meter.png", width=1000, height=600)
hist(movie_meter_IMDBpro, breaks = 50, col = "skyblue")

png(file="plots/imdb_vs_movie_meter.png", width=800, height=450)
plot(movie_meter_IMDBpro, imdb_score, col = "grey", main = "score VS movie_meter_IMDBpro", xlab = "movie_meter_IMDBpro", ylab = "imdb_score")
summary(movie_meter_IMDBpro)

reg9 = lm(imdb_score ~ movie_meter_IMDBpro)
summary(reg9)

## Categorical Variables
#### Release Month
barplot(table(imdb$release_month), names.arg = unique(release_month), 
        xlab = "release_month", ylab = "Frequency", main = "Release Month Distribution")
reg11 = lm(imdb_score ~ release_month)
summary(reg11)

#### Language
barplot(table(language), names.arg = unique(language), 
        xlab = "language", ylab = "Frequency", main = "Language Distribution")
table(language)
reg12 = lm(imdb_score ~ language)
summary(reg12)

#### Country
barplot(table(country), names.arg = unique(country), 
        xlab = "country", ylab = "Frequency", main = "Country Distribution")
table(country)
reg13 = lm(imdb_score ~ country)
summary(reg13)

#### Maturity Rating
barplot(table(maturity_rating), names.arg = unique(maturity_rating), 
        xlab = "maturity_rating", ylab = "Frequency", main = "Maturity Rating Distribution")
table(maturity_rating)
reg14 = lm(imdb_score ~ maturity_rating)
summary(reg14)

#### Production Company
barplot(table(production_company), names.arg = unique(production_company), 
        xlab = "production_company", ylab = "Frequency", main = "Production Company Distribution")
production_freq = table(production_company)
production_freq[production_freq > 80]
reg15 = lm(imdb_score ~ production_company)
summary(reg15)







   
   
