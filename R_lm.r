dataset = read.csv('regrex1.csv')

model = lm(formula = y ~ x, data = dataset)

summary(model)

library(ggplot2)
ggplot() +
  geom_point(aes(x = dataset$x, y = dataset$y),
             colour = 'red') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')

library(ggplot2)
ggplot() +
  geom_line(aes(x = dataset$x, y = predict(model, newdata = dataset)),
            colour = 'blue') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')

library(ggplot2)
ggplot() + geom_point(aes(x = dataset$x, y = dataset$y),
             colour = 'red') +
  geom_line(aes(x = dataset$x, y = predict(model, newdata = dataset)),
            colour = 'blue') +
  ggtitle('x vs y') +
  xlab('x') +
  ylab('y')
