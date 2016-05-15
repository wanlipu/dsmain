census = read.csv("census.csv")

summary(census)


library(caTools)
set.seed(2000)
split = sample.split(census$over50k, SplitRatio = 0.6)
train = subset(census, split == TRUE)
test = subset(census, split == FALSE)

summary(train)

censusLogit = glm(over50k ~ ., data = train, family = "binomial")
summary(censusLogit)


LogitPred = predict(censusLogit, newdata = test, type = "response")

table(test$over50k, LogitPred >= 0.5)
(9051 + 1888)/nrow(test)

table(train$over50k)
table(test$over50k)/nrow(test)

#  Problem 1.4 - A Logistic Regression Model 
library(ROCR)
ROCRpred = prediction(LogitPred, test$over50k)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred, "auc")@y.values)
auc


plot(ROCRperf)
plot(ROCRperf, colorize = TRUE)
plot(ROCRperf, colorize = TRUE, print.cutoffs.at = seq(0, 1, 0.1), text.adj = c(-0.2, 1.7))
summary(ROCRperf)

# Problem 2.1 - A CART Model 
library(rpart)
library(rpart.plot)
CARTmodel = rpart(over50k ~ ., data=train, method="class")

rpart.plot(CARTmodel)
#prp(CARTmodel)
#plot(CARTmodel)

# CARTPred = predict(CARTb, newdata = test) # this is not good for this question, because we need the predictions
CARTPred = predict(CARTmodel, newdata = test, type="class")
CARTPred
#CARTbPred
table(test$over50k, CARTbPred)

(9243 + 1596) / nrow(test)

#  Problem 2.5 - A CART Model - ROC curve
# need to remove the type = "class"
CARTPred_ed = predict(CARTmodel, newdata = test)
CARTPred_ed
ROCRpredCART = prediction(CARTPred_ed[,2], test$over50k)
ROCRperfCART = performance(ROCRpredCART, "tpr", "fpr")
auc = as.numeric(performance(ROCRpredCART, "auc")@y.values)
auc

plot(ROCRperfCART)
plot(ROCRperfCART, colorize = TRUE)
plot(ROCRperfCART, colorize = TRUE, print.cutoffs.at = seq(0, 1, 0.1), text.adj = c(-0.2, 1.7))
summary(ROCRperfCART)

#  Problem 3.1 - A Random Forest Model 
set.seed(1)
trainSmall = train[sample(nrow(train), 2000), ]
library(randomForest)


set.seed(1)
censusForest = randomForest(over50k ~ ., data = trainSmall)

# Make predictions
PredictForest = predict(censusForest, newdata = test)
PredictForest
table(test$over50k, PredictForest)
(9614 + 1050) / nrow(test)

#  Problem 3.2 - A Random Forest Model 
vu = varUsed(censusForest, count=TRUE)
vusorted = sort(vu, decreasing = FALSE, index.return = TRUE)
dotchart(vusorted$x, names(censusForest$forest$xlevels[vusorted$ix]))

#  Problem 3.3 - A Random Forest Model 
varImpPlot(censusForest)

#  Problem 4.1 - Selecting cp by Cross-Validation 

set.seed(2)
# Load cross validation packages
library(caret)
library(e1071)
numFolds = trainControl(method = "cv", number = 10)
cartGrid = expand.grid( .cp = seq(0.002,0.1,0.002))
# Perform the cross validation
train(over50k ~., data = train, method = "rpart", trControl = numFolds, tuneGrid = cartGrid )
# Which value of cp does the train function recommend?
# Answer based on the above function
# Fit a CART model to the training data using this value of cp. What is the prediction 
# accuracy on the test set?
TreeModelnew <- rpart(over50k ~., data=train, cp=0.002, method="class")
TreePredictnew <- predict(TreeModelnew, newdata=test, type="class")
table(test$over50k, TreePredictnew)
(9178 + 1838) / nrow(test)
# Plot the CART tree for this model. How many splits are there?
prp(TreeModelnew)
summary(TreeModelnew)
