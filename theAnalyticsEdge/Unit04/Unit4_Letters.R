letters = read.csv("letters_ABPR.csv")
summary(letters)
str(letters)

#  Problem 1.1 - Predicting B or not B 
letters$isB = as.factor(letters$letter == "B")

library(caTools)
set.seed(1000)
split = sample.split(letters$isB, SplitRatio = 0.5)
train = subset(letters, split == TRUE)
test = subset(letters, split == FALSE)

table(train$isB)
table(test$isB)/nrow(test)

#  Problem 1.2 - Predicting B or not B 
library(rpart)
library(rpart.plot)
CARTb = rpart(isB ~ . - letter, data=train, method="class")

# CARTbPred = predict(CARTb, newdata = test) # this is not good for this question, because we need the predictions
CARTbPred = predict(CARTb, newdata = test, type="class")

CARTbPred
table(test$isB, CARTbPred)

(1118 + 340) / nrow(test)


# Problem 1.3 - Predicting B or Not B 
library(randomForest)


set.seed(1000)
#lettersForest = randomForest(isB ~ . - letter, data = train, ntree=200, nodesize=25 ) # use default, not need to specify tree number and nod size
lettersForest = randomForest(isB ~ . - letter, data = train)

# Make predictions
PredictForest = predict(lettersForest, newdata = test)
PredictForest
table(test$isB, PredictForest)
(1165+374)/nrow(test)

#  Problem 2.1 - Predicting the letters A, B, P, R 
letters$letter = as.factor(letters$letter) 
summary(letters)

set.seed(2000)
split = sample.split(letters$letter, SplitRatio = 0.5)
trainNew = subset(letters, split == TRUE)
testNew = subset(letters, split == FALSE)

summary(trainNew)
summary(testNew)

401/nrow(testNew)

# Problem 2.2 - Predicting the letters A, B, P, R 
CARTLetter = rpart(letter ~ . - isB, data=trainNew, method="class")
CARTbPred2 = predict(CARTLetter, newdata = testNew, type="class")
table(testNew$letter, CARTbPred2)
(348 + 318 + 363 + 340) / nrow(testNew)

# Problem 2.3 - Predicting the letters A, B, P, R 
set.seed(1000)
lettersForest2 = randomForest(letter ~ . - isB, data = trainNew)

# Make predictions
PredictForest2 = predict(lettersForest2, newdata = testNew)
PredictForest2
table(testNew$letter, PredictForest2)
(390 + 380 + 393 + 364)/nrow(testNew)
