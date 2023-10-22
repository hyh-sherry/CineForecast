# LDA for plot_keywords
library(topicmodels)
library(tidytext)
library(ggplot2)
library(dplyr)
library(tidyverse)

path_plot = "/Users/sunnygao/Desktop/midterm_project/preprocessing/pre_plot.csv"
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










