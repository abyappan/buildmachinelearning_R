# Set file name variable
dataset = read.csv('regrex1.csv')

# Linear model and summary
model = lm(formula = y ~ x, data = dataset)

summary(model)

# Plot scatter plot of original data
library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$x, y = dataset$y),
             colour = 'red') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')

# Plot linear regression mode
library(ggplot2)
ggplot() +
  geom_line(aes(x = dataset$x, y = predict(model, newdata = dataset)),
            colour = 'blue') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')

# Plot linear regression model with original data
library(ggplot2)
ggplot() + geom_point(aes(x = dataset$x, y = dataset$y),
             colour = 'red') +
  geom_line(aes(x = dataset$x, y = predict(model, newdata = dataset)),
            colour = 'blue') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')
