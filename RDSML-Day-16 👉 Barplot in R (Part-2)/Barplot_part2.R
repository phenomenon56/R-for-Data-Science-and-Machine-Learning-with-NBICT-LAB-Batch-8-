# Creating a data frame
dataset = data.frame(dose = c("D0.5", "D1", "D2"), 
                     len = c(4.2, 10, 29.5))

library(ggplot2)

# Basic barplot
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity")

# Horizontal barplot
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity") +
  coord_flip()

# Changing the width of bars
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity", width = .5)

# Changing colors
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity", color = "blue", fill = "white", width = .5)

# Minimal theme with blue fill color
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity", fill = "steelblue") +
  theme_minimal()

# Barplot with labels
# Outeside bars
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = len), vjust = -0.5, size = 3, color = "#9F9F9F") +
  theme_minimal()

# Inside bars
ggplot(data = dataset, aes(x = dose, y = len)) + 
  geom_bar(stat = "identity", fill = "steelblue") +
  geom_text(aes(label = len), vjust = 1.6, size = 3, color = "white") +
  theme_minimal()

myCarData = mtcars
# Barplot of counts
# To make a barplot of counts, we will use mtcars dataset

ggplot(data = myCarData, aes(x = factor(cyl))) +
  geom_bar(stat = "count", width = 0.7, fill = "steelblue") +
  theme_minimal()


# Changing barplot line colors by groups
print(dataset)
ggplot(dataset, aes(x = dose, y = len, color = dose)) +
  geom_bar(stat = "identity", fill = "white")

# Using custom color palettes
ggplot(dataset, aes(x = dose, y = len, color = dose)) +
  geom_bar(stat = "identity", fill = "white") +
  scale_color_manual(values = c("blue", "red", "green"))

# Using brewer color palettes
ggplot(dataset, aes(x = dose, y = len, color = dose)) +
  geom_bar(stat = "identity", fill = "white") +
  scale_color_brewer(palette = "Dark2" )

# Using a grey scale
ggplot(dataset, aes(x = dose, y = len, color = dose)) +
  geom_bar(stat = "identity", fill = "white") +
  scale_color_grey() +
  theme_classic()

# Changing barplot fill colors by groups
p = ggplot(dataset, aes(x = dose, y = len, fill = dose)) +
  geom_bar(stat = "identity") +
  theme_minimal()

p + scale_fill_manual(values = c("blue", "red", "green"))

# Using custom color palettes
p + scale_fill_manual(values = c("blue", "red", "green"))

# Using brewer color palettes
p + scale_fill_brewer(palette = "Dark2" )

# Using a grey scale
p + scale_fill_grey()

# Using a black outline color
ggplot(dataset, aes(x = dose, y = len, fill = dose)) +
  geom_bar(stat = "identity", color = "black") +
  scale_color_manual(values = c("#85713a", "#c72ce6", "#f00a24")) +
  
# Changing the legend position
ggplot(dataset, aes(x = dose, y = len, fill = dose)) +
  geom_bar(stat = "identity", color = "black") +
  scale_color_manual(values = c("#85713a", "#c72ce6", "#f00a24")) +
  theme(legend.position = "none")

