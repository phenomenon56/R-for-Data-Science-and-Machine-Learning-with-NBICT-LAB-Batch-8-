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
  geom_smooth()

# Removing the confidence interval
# Changing the point color
# Changing the line type
# Changing the line color
# The loess method