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

# Predicting the Test set results
y_pred <- predict(regressor, test_set)
y_pred

# Stepwise Backward Elimination (removing non-significant independent variable sequentially)
regressor <- lm(formula = Profit~ R.D.Spend + Administration + Marketing.Spend, data = training_set)
summary(regressor)

regressor <- lm(formula = Profit~ R.D.Spend + Marketing.Spend, data = training_set)
summary(regressor)

# Automated Stepwise Backward Elimination
full_model <- lm(Profit ~., data = training_set)
summary(full_model)

final_model <- step(full_model, direction = "backward")
summary(final_model)

# Assumptions testing (Pearson corelation)
# Pearson corelation (linearity testing by Pearson)
cor(training_set$R.D.Spend, training_set$Profit, method = "pearson")
cor.test(training_set$R.D.Spend, training_set$Profit, method = "pearson")
cor.test(training_set$Marketing.Spend, training_set$Profit, method = "pearson")
library(ggplot2)
plot(training_set$R.D.Spend, training_set$Profit)

# Assumptions testing (Linearity testing by model)
plot(final_model)

# Checking for the independence of errors/observation/residuals
# install.packages("lmtest")
library(lmtest)
dwtest(final_model)

# Normality of residuals
shapiro.test(rstandard(final_model))
qqnorm(rstandard(final_model)) # visual/plot is better than shapiro test
qqline(rstandard(final_model))

# Multi co-linearity testing (checking if there relation between independent vairbale)
library(car)
vif(final_model)

#Homoscedasticity Assumption
plot(final_model$fitted.values, rstandard(final_model))
abline(h =0, col="red")
bptest(final_model)

