# Install packages
# install.packages('caret', dependencies=c("Depends", "Suggests"))
library(caret)
# -------------
# Load data
# attach iris dataset to this environment
data(iris)
dataset <- iris
# -------------
# Create a Validation Dataset
validation_index <- createDataPartition(dataset$Species, p=0.80, list=F)
# select 20% of the data for validation
validation <- dataset[-validation_index,]
# use the reamining 8-% of data to training and testing models
dataset <- dataset[validation_index,]
# -------------
# Summarize Dataset
# dimensions of dataset
dim(dataset)
# list types for each attribute
sapply(dataset, class)
# take a peak at the first 5 rows of the data
head(dataset)
# levels of the class
levels(dataset$Species)
# summarize class distribution
percentage <- prop.table(table(dataset$Species))*100
cbind(freq=table(dataset$Species), percentage=percentage)
# summarize attribute distributions
summary(dataset)
# -------------
# Visualize dataset
# split input and output
x <- dataset[,1:4]
y <- dataset[,5]
# boxplot for each attribute on one image
par(mfrow=c(1,4))
    for(i in 1:4) {
        boxplot(x[,i], main=names(iris[i]))
    }
# barplot for class breakdown
plot(y)
# scatterplot matrix
featurePlot(x=x, y=y, plot="ellipse")
# box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")
# density plots for each attribute by class value
scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", sclaes=scales)
# -------------
# Test Harness
# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"
# -------------
# Build models
# a) linear algorithms
set.seed(7)
fit.lda <- train(Species ~., data=dataset, method='lda', metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)
# -------------
# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)
# compare accuracy of models
dotplot(results)
# summarize best model
print(fit.lda)
# -------------
# Make predictions
# estimate skill of LDA on the validation dataset
predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)