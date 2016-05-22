# problem 1.1

gerber = read.csv("gerber.csv")
str(gerber)
summary(gerber)

voting = table(gerber$voting)
prop.table(voting)

voting_civic = table(gerber$voting[gerber$civicduty == 1])
prop.table(voting_civic)

voting_hawthorne = table(gerber$voting[gerber$hawthorne == 1])
prop.table(voting_hawthorne)

voting_self = table(gerber$voting[gerber$self == 1])
prop.table(voting_self)

voting_neighbors = table(gerber$voting[gerber$neighbors == 1])
prop.table(voting_neighbors)

gerberLogit = glm(voting ~ civicduty + hawthorne + self + neighbors, data = gerber, family = "binomial")
#?glm
summary(gerberLogit)

gerberLogitPred = predict(gerberLogit, type = "response")
#?predict
table(gerber$voting, gerberLogitPred >= 0.3)
(134513 + 51966) / nrow(gerber)
table(gerber$voting, gerberLogitPred >= 0.5)
235388/nrow(gerber)

library(ROCR)

ROCRpred = prediction(gerberLogitPred, gerber$voting)
ROCRperf = performance(ROCRpred, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred, "auc")@y.values)
auc

library(rpart)
library(rpart.plot)
CARTmodel = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber)
prp(CARTmodel)
CARTmodel2 = rpart(voting ~ civicduty + hawthorne + self + neighbors, data=gerber, cp=0.0)
prp(CARTmodel2)

#problem 2.4
CARTmodel3 = rpart(voting ~ civicduty + hawthorne + self + neighbors + sex, data=gerber, cp=0.0)
prp(CARTmodel3)
table(gerber$voting[gerber$control == 1], gerber$sex[gerber$control == 1])


#problem 3.1
CARTmodel4 = rpart(voting ~ control, data=gerber, cp=0.0)
prp(CARTmodel4)
prediction.control = predict(CARTmodel4)
prediction.control

(mean(prediction.control[gerber$control>= 0.5]) - mean(prediction.control[gerber$control < 0.5]))

prp(CARTmodel4, digits=6)


# problem 3.2
# Now, using the second tree (with control and sex), 
# determine who is affected more by NOT being in the control group (being in any of the four treatment groups)
CARTmodel5 = rpart(voting ~ control + sex, data=gerber, cp=0.0)
prp(CARTmodel5, digits = 6)

# problem 3.2 - Interaction Terms
# Going back to logistic regression now, create a model using "sex" and "control". Interpret the coefficient for "sex"
gerberLogit.control.sex = glm(voting ~ control + sex, data = gerber, family = "binomial")
summary(gerberLogit.control.sex)

# problem 3.4 Interaction Terms 
Possibilities = data.frame(sex=c(0,0,1,1),control=c(0,1,0,1))
Possibilities
LogModelSex = glm(voting ~ sex + control, data = gerber, family = "binomial")
predict(LogModelSex, newdata=Possibilities, type="response")

# problem 3.5 - Interaction Terms 
LogModel2 = glm(voting ~ sex + control + sex:control, data=gerber, family="binomial")
summary(LogModel2)

# Problem 3.6 - Interaction Terms 
predict(LogModel2, newdata=Possibilities, type="response")
