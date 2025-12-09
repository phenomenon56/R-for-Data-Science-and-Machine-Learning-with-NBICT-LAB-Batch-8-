# Random Forest Classification

# Importing the dataset
dataset <- read.csv('Social_Network_Ads.csv')
dataset <- dataset[3:5]

# Encoding the target variable as factor
dataset$Purchased <- factor(dataset$Purchased,
                            levels = c(0, 1))

# Implementing k-fold cross validation
# install.packages('caret')
library(caret)

set.seed(123)

folds = createFolds(dataset$Purchased, k = 10)

cv = lapply(folds, function(x){
  training_fold = dataset[-x, ]
  test_fold = dataset[x, ]
  classifier = glm(formula = Purchased ~ .,
                   family = binomial,
                   data = training_fold)
  prob_pred = predict(classifier, type = 'response', newdata = test_fold[-3])
  y_pred = ifelse(prob_pred > 0.5, 1, 0)
  cm = table(test_fold[, 3], y_pred)
  accuracy = (cm[1,1] + cm[2,2]) / (cm[1,1] + cm[2,2] + cm[1,2] + cm[2,1])
  return(accuracy)
})

accuracy = mean(as.numeric(cv))
