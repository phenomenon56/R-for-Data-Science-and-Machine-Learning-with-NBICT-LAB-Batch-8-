# Setup: packages and data loading
# install.packages("e1071")
# library(e1071)
# library(dplyr)
# library(ggplot2)

# Loading the dataset
dataset <- read.csv("day.csv")

# Basic cleaning and feature selection
bike <- dataset %>%
  select(cnt, temp, atemp, hum, windspeed, season, yr, mnth, 
         holiday,weekday,workingday,weathersit)
  
str(bike)

# Convert categorical variables to factors
bike <- bike %>%
  mutate(
    season = factor(season),
    yr = factor(yr),
    mnth = factor(mnth),
    holiday = factor(holiday),
    weekday = factor(weekday),
    workingday = factor(workingday),
    weathersit = factor(weathersit)
  )
str(bike)

# Train/test split
set.seed(123)
n <- nrow(bike)
indices <- seq_len(n)
train_idx <- sample(indices, size = 0.7*n)
train_set <- bike[train_idx, ]
test_set <- bike[-train_idx, ]