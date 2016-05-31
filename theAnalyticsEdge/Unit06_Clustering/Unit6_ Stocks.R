stocks = read.csv('StocksCluster.csv')
table(stocks$PositiveDec)/nrow(stocks)
stocks$PositiveDec = as.factor(stocks$PositiveDec)

cor(stocks)

summary(stocks)

library(caTools)
set.seed(144)
spl = sample.split(stocks$PositiveDec, SplitRatio = 0.7)

stocksTrain = subset(stocks, spl == TRUE)

stocksTest = subset(stocks, spl == FALSE)

StocksModel = glm(PositiveDec ~ ., data = stocksTrain, family = 'binomial')
trainpredicit = predict(StocksModel, type = 'response') # be careful, don't use class = 'response'

table(stocksTrain$PositiveDec, trainpredicit >= 0.5)
(990+3640)/nrow(stocksTrain)

testpredicit = predict(StocksModel, newdata = stocksTest, type = 'response')

table(stocksTest$PositiveDec, testpredicit>= 0.5)
(417+1553)/nrow(stocksTest)

table(stocksTest$PositiveDec)
1897/nrow(stocksTest)



limitedTrain = stocksTrain
limitedTrain$PositiveDec = NULL
limitedTest = stocksTest
limitedTest$PositiveDec = NULL


library(caret)
preproc = preProcess(limitedTrain)
normTrain = predict(preproc, limitedTrain)
normTest = predict(preproc, limitedTest)
summary(normTrain)
summary(normTest)


k = 3

# Run k-means
set.seed(144)
KMC_stocks = kmeans(normTrain, centers = k, iter.max = 1000)
str(KMC_stocks)

# Extract clusters
table(KMC_stocks$cluster)

library(flexclust)

KMC_stocks.kcca = as.kcca(KMC_stocks, normTrain)

clusterTrain = predict(KMC_stocks.kcca)

clusterTest = predict(KMC_stocks.kcca, newdata=normTest)
table(clusterTest)


stocksTrain1 = subset(stocksTrain, clusterTrain == 1)
stocksTrain2 = subset(stocksTrain, clusterTrain == 2)
stocksTrain3 = subset(stocksTrain, clusterTrain == 3)
table(stocksTrain1$PositiveDec)/nrow(stocksTrain1)
table(stocksTrain2$PositiveDec)/nrow(stocksTrain2)
table(stocksTrain3$PositiveDec)/nrow(stocksTrain3)


stocksTest1 = subset(stocksTest, clusterTest == 1)
stocksTest2 = subset(stocksTest, clusterTest == 2)
stocksTest3 = subset(stocksTest, clusterTest == 3)


StocksModel1 = glm(PositiveDec ~ ., data = stocksTrain1, family = 'binomial')
trainpredicit1 = predict(StocksModel1, type = 'response') # be careful, don't use class = 'response'
summary(StocksModel1)

StocksModel2 = glm(PositiveDec ~ ., data = stocksTrain2, family = 'binomial')
trainpredicit2 = predict(StocksModel2, type = 'response') # be careful, don't use class = 'response'
summary(StocksModel2)

StocksModel3 = glm(PositiveDec ~ ., data = stocksTrain3, family = 'binomial')
trainpredicit3 = predict(StocksModel3, type = 'response') # be careful, don't use class = 'response'
summary(StocksModel3)

testpredicit1 = predict(StocksModel1, newdata = stocksTest1, type = 'response')
table(stocksTest1$PositiveDec, testpredicit1>= 0.5)
(30+774)/nrow(stocksTest1)

testpredicit2 = predict(StocksModel2, newdata = stocksTest2, type = 'response')
table(stocksTest2$PositiveDec, testpredicit2>= 0.5)
(388+757)/nrow(stocksTest2)

testpredicit3 = predict(StocksModel3, newdata = stocksTest3, type = 'response')
table(stocksTest3$PositiveDec, testpredicit3>= 0.5)
(49+13)/nrow(stocksTest3)


AllPredictions = c(testpredicit1, testpredicit2, testpredicit3)

AllOutcomes = c(stocksTest1$PositiveDec, stocksTest2$PositiveDec, stocksTest3$PositiveDec)
table(AllOutcomes, AllPredictions>= 0.5)
(467+1544)/nrow(stocksTest)
