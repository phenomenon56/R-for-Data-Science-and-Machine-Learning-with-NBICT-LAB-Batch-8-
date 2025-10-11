# Installing and loading ggplot2
# install.packages("ggplot2")
library(ggplot2)

# Loading a dataset
dataset = mtcars

# Generating a basic scatter plot
ggplot(dataset, aes(x = wt, y = mpg)) +
  geom_point()

# Changing the point size and shape
ggplot(dataset, aes(x = wt, y = mpg)) +
  geom_point(size =2, shape =18)

# Adding the regression line
ggplot(dataset, aes(x = wt, y = mpg)) +
  geom_point(size =2, shape =18) +
  geom_smooth(method = lm)

# Removing the confidence interval
ggplot(dataset, aes(x =wt, y=mpg)) +
  geom_point() +
  geom_smooth(method =  lm, se = FALSE)
# Changing the point color

# The loess method
ggplot(dataset, aes(x =wt, y=mpg)) +
  geom_point() +
  geom_smooth()

#  Changing the line type and the line color
ggplot(dataset, aes(x = wt, y = mpg)) +
  geom_point(size =2, shape =18) +
  geom_smooth(method = lm, linetype = "dotted",
              color = "darkblue")
# Changing the confidence interval color
ggplot(dataset, aes(x = wt, y = mpg)) +
  geom_point(size =2, shape =18, color = "green") +
  geom_smooth(method = lm, linetype = "dashed",
              color = "darkred", fill = "blue")

# Scatter plots with multiple groups


# Converting the cyl column from a numeric to factor variable
dataset$cyl = as.factor(dataset$cyl)

# Changing the point shapes by the levels of cyl
ggplot(dataset, aes(x = wt, y =mpg, shape = cyl)) +
  geom_point()

# Changing the point shapes and colors by the levels of cyl
ggplot(dataset, aes(x = wt, y =mpg, shape = cyl, color = cyl)) +
  geom_point()

# Changing point shapes, colors and sizes

ggplot(dataset, aes(x = wt, y =mpg, color = cyl, size = cyl)) +
  geom_point()