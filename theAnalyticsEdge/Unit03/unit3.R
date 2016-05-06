# install.packages("caTools")

quality = read.csv("quality.csv")

library(caTools)

set.seed(88)
split = sample.split(quality$PoorCare, SplitRatio = 0.75)
split

qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)
?subset

nrow(qualityTrain)
nrow(qualityTest)

#?glm
QualityLog = glm(PoorCare ~ OfficeVisits + Narcotics, data = qualityTrain, family = binomial)
summary(QualityLog)

predictTrain = predict(QualityLog, type = "response")
summary(predictTrain)

tapply(predictTrain, qualityTrain$PoorCare, mean)


str(quality)
#quiz
QualityLog2 = glm(PoorCare ~ StartedOnCombination + ProviderCount, data = qualityTrain, family = binomial)
summary(QualityLog2)

predictTrain2 = predict(QualityLog2, type = "response")
summary(predictTrain2)

tapply(predictTrain2, qualityTrain$PoorCare, mean)


#
?table
table(qualityTrain$PoorCare, predictTrain > 0.5)
table(qualityTrain$PoorCare, predictTrain > 0.7)
table(qualityTrain$PoorCare, predictTrain > 0.3)
table(qualityTrain$PoorCare, predictTrain > 0.2)

# ROC curve
# install.packages("ROCR")
library(ROCR)
ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
#?prediction
#?predict
plot(ROCRperf)
plot(ROCRperf, colorize = TRUE)
plot(ROCRperf, colorize = TRUE, print.cutoffs.at = seq(0, 1, 0.1), text.adj = c(-0.2, 1.7))


#quiz
predictTest = predict(QualityLog, type="response", newdata=qualityTest)

#You can compute the test set AUC by running the following two commands in R:
  
ROCRpredTest = prediction(predictTest, qualityTest$PoorCare)

auc = as.numeric(performance(ROCRpredTest, "auc")@y.values)

#What is the AUC of this model on the test set?
auc
