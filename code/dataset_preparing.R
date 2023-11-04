# Data pre-processing
# Note: please run LDA_preprocessing.R before running this script
library(dplyr)
library(stringr)
library(tidyverse)
library(data.table)

path = "/Users/sunnygao/Desktop/midterm_project/IMDB_data_Fall_2023.csv"
imdb <- read.csv(path)

path_plot = "/Users/sunnygao/Desktop/midterm_project/preprocessing/pre_plot.csv"
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

path_output = "/Users/sunnygao/Desktop/midterm_project/preprocessing/imdb_first_step_cleaning.csv"
write.csv(imdb_3, file = path_output, row.names = FALSE)




















