# Decision Tree Regression

# Importing the dataset
dataset = read.csv('Drug_Effectiveness.csv')

# Plotting the data
plot(dataset$Dosage, dataset$Effectiveness,
     main = "Scatter Plot of Dosage vs. Drug Effectiveness",
     xlab = "Dosage",
     ylab = "Drug Effectiveness")

# Fitting Decision Tree Regression to the dataset
# install.packages('rpart')
library(rpart)
regressor = rpart(formula = Effectiveness ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 7))

# Predicting a new result with Decision Tree Regression
y_pred = predict(regressor, data.frame(Dosage = 27))
y_pred

# Visualising the Decision Tree Regression results (higher resolution)
# install.packages('ggplot2')
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


