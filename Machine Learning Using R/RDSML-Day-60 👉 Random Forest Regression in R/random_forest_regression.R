# Random Forest Regression
# Installing necessary packages
# install.packages("randomForest")
library(randomForest)

# Importing the dataset
dataset = read.csv('Drug_Effectiveness.csv')


set.seed(1234)
regressor = randomForest(x = dataset[1],
                         y = dataset$Effectiveness,
                         ntree = 10)

# Predicting a new result with Random Forest Regression
y_pred = predict(regressor, data.frame(Dosage = 20))
y_pred

# Visualising the Random Forest Regression results (higher resolution)
# install.packages('ggplot2')
library(ggplot2)
x_grid = seq(min(dataset$Dosage), max(dataset$Dosage), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Dosage, y = dataset$Effectiveness),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Dosage = x_grid))),
            colour = 'blue') +
  ggtitle('Dosage VS Drug Effectivenes') +
  xlab('Dosage') +
  ylab('Drug Effectivenes')