parole = read.csv("parole.csv")
parole2 = read.csv("parole.csv")

# problem 1.1

str(parole)
summary(parole)

# problem 1.2
sum(parole$violator == 1)

# problem 2.1
summary(parole)
table(parole$male)
table(parole$race)
table(parole$age)
table(parole$state)
table(parole$multiple.offenses)
table(parole$crime)

table(parole)

# problem 2.2
parole2$statefactor = as.factor(parole2$state)
summary(parole2)

parole$state = as.factor(parole$state)
parole$crime = as.factor(parole$crime)
summary(parole)

# problem 3.1
set.seed(144)
library(caTools)
split = sample.split(parole$violator, SplitRatio = 0.7)
train = subset(parole, split == TRUE)
test = subset(parole, split == FALSE)
nrow(train)
nrow(test)

# problem 4.1
paroleLog1 = glm(violator ~ ., data = train, family = "binomial")
summary(paroleLog1)
exp(1.6119919)

test2 = read.csv("test2.csv")
test2$state = as.factor(test2$state)
test2$crime = as.factor(test2$crime)
summary(test2)


predict(paroleLog1, newdata = test2, type = "response")
0.154383/(1-0.154383)

# problem 5.1
testPred1 = predict(paroleLog1, newdata = test, type = "response")
max(testPred1)

# problem 5.2
table(test$violator, testPred1 > 0.5)
12/(11 + 12)
167/(167+12)
(12+167)/202
(167+12)/202
table(test$violator, testPred1 > 0.1)

# problem 5.6
library(ROCR)
ROCRpred1 = prediction(testPred1, test$violator)
ROCRperf1 = performance(ROCRpred1, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred1, "auc")@y.values)
auc
#?prediction
#?predict
plot(ROCRperf1)
plot(ROCRperf1, colorize = TRUE)
plot(ROCRperf1, colorize = TRUE, print.cutoffs.at = seq(0, 1, 0.1), text.adj = c(-0.2, 1.7))
summary(ROCRperf1)
