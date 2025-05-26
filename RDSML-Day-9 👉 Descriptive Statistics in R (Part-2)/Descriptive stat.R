
# Introducing column function

colnames(demo) = c ('a', 'b', 'c')
demo

# Introducing hist() function
dep_delay
hist(dep_delay)

# How to group descriptive statistics

head(nycflights13::flights)
summary(carrier)
carrierfact = factor(carrier)
summary(carrierfact)

describeBy(distance, group = carrier)

# Two levels of aggregation
aggregate(distance, by = list(carrier, month), FUN = mean, na.rm = TRUE)
aggregate(distance, by = list(carrier, month), FUN = sd, na.rm = TRUE)
