# Importing the dataset
dataset <- read.csv("50_Startups.csv")

# Encoding categorical data (here State is the Categorical Data)
dataset$State <- factor(dataset$State,
                        levels = c("New York", "California", "Florida"),
                        labels = c(1,2,3))

# Splitting the dataset into the Training set and Test Set
library(caTools)
set.seed(123)
split <- sample.split(dataset$Profit, SplitRatio = 0.8)
training_set <- subset(dataset, split == T)
test_set <- subset(dataset, split == F)

# Fitting Multiple Linear Regression to the Training Set/Model preparation
regressor <- lm(formula = Profit~ R.D.Spend + Administration + Marketing.Spend + State, data = training_set)

# Checking the summary of the model
summary(regressor)

