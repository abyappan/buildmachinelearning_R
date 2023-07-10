print("Running linear model: R script")

# Locate arguments
args = commandArgs()
# print(args)

# Set file name variable
dataset = read.csv(args[6])
print(paste("Your file is ", args[6]))

# Linear model and summary
model = lm(formula = y ~ x, data = dataset)
print("Linear model summary:")

summary(model)

# Plot scatter plot of original data
library(ggplot2)
r_orig <- ggplot() +
  geom_point(aes(x = dataset$x, y = dataset$y),
             colour = 'red') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')
ggsave('r_orig.png', r_orig, 'png', width = 4, height = 4)

# Plot linear regression model
library(ggplot2)
ggplot() +
  geom_line(aes(x = dataset$x, y = predict(model, newdata = dataset)),
            colour = 'blue') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')

# Plot linear regression model with original data
library(ggplot2)
r_lm <- ggplot() + geom_point(aes(x = dataset$x, y = dataset$y),
             colour = 'red') +
  geom_line(aes(x = dataset$x, y = predict(model, newdata = dataset)),
            colour = 'blue') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')
ggsave('r_lm.png', r_lm, 'png', width = 4, height = 4)
