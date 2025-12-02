# Loading the data
dataset = read.csv('Drug_Effectiveness.csv')

# Data visualization
plot(dataset$Dosage, dataset$Effectiveness,
     main = "Scatter Plot of Dosage vs. Drug Effectiveness",
     xlab = "Dosage",
     ylab = "Drug Effectiveness")

# Installing the necessary packages
# install.packages('rpart')
library(rpart)

# Building the model
regressor = rpart(formula = Effectiveness ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 7))

# Predicting new results with Decision Tree Regression
y_pred = predict(regressor, data.frame(Dosage = 27))
y_pred

# Tree visualization
library(ggplot2)
x_grid = seq(min(dataset$Dosage), max(dataset$Dosage), 0.01)
ggplot() +
  geom_point(aes(x = dataset$Dosage, y = dataset$Effectiveness),
             colour = 'red') +
  geom_line(aes(x = x_grid, y = predict(regressor, newdata = data.frame(Dosage = x_grid))),
            colour = 'blue') +
  ggtitle('Decision Tree Regression') +
  xlab('Dosage') +
  ylab('Effectiveness')

# install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(regressor) 
rpart.plot(regressor, type = 2, fallen.leaves = TRUE, tweak = 1.2) 



