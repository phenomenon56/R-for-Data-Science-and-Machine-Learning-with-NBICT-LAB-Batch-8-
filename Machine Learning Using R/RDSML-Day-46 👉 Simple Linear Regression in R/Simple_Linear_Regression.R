# Importing the dataset
dataset = read.csv("Salary_Data.csv")

# Environment Preparation
# install.packages("caTools")
library(caTools)

# Splitting the dataset into the Training set and Test set
# Training set: Input the dataset through which machine is trained
# Splitting the training set into Two ways: 
# 1.Randomly
split = sample.split(dataset$Salary, SplitRatio = 2/3)
split

# 2.Particular data selection (123: particular data combination)
set.seed(123) #to avoid randomness
split = sample.split(dataset$Salary, SplitRatio = 2/3)
split

# Training set preparation
training_set <- subset(dataset, split == TRUE) #two equal means equal, one equal means assignment operator

# Test Set Preparation
test_set <- subset(dataset, split == FALSE)



# Fitting Simple Linear Regression to the Training set
regressor <- lm(formula = Salary ~ YearsExperience, 
                data = training_set)
