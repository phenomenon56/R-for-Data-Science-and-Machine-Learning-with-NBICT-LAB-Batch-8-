# Importing the dataset
dataset = read.csv("Salary_Data.csv")

# Environment Preparation
# install.packages("caTools")
library(caTools)

# Splitting the dataset into the Training set and Test set
# Training set: Input the dataset through which machine is trained (Model)
# Test Set:  Input the dataset which is tested on basis of model
# Splitting the training set into Two ways: 
# 1.Randomly
split = sample.split(dataset$Salary, SplitRatio = 2/3)
split

# 2.Particular data selection (123: particular data combination)
set.seed(123) #to avoid randomness
split = sample.split(dataset$Salary, SplitRatio = 2/3)
split

# Training set preparation (Model)
training_set <- subset(dataset, split == TRUE) #two equal means equal, one equal means assignment operator

# Test Set Preparation
test_set <- subset(dataset, split == FALSE)


# Fitting Simple Linear Regression to the Training set
regressor <- lm(formula = Salary ~ YearsExperience, 
                data = training_set)

# Checking the summary of the model
summary(regressor)

# Predicting the training set results
y_pred = predict(regressor, newdata = training_set)

# Predicting the test set results
y_pred = predict(regressor, newdata = test_set)

# Visualizing the Training set results
library(ggplot2)
ggplot() + 
  geom_point(aes(x=training_set$YearsExperience, y=training_set$Salary),
             colour='red') +
  geom_line(aes(x=training_set$YearsExperience, y=y_pred),
            colour='blue') +
  ggtitle("Salary vs Experience") +
  xlab('Years of experience') +
  ylab('Salary')


# Visualizing the Test set results
library(ggplot2)
ggplot() + 
  geom_point(aes(x=test_set$YearsExperience, y=test_set$Salary),
             colour='red') +
  geom_line(aes(x=test_set$YearsExperience, y=predict(regressor, newdata = test_set)),
            colour='blue') +
  ggtitle("Salary vs Experience (Test Set)") +
  xlab('Years of experience') +
  ylab('Salary')

