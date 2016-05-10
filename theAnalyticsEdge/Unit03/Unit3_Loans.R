loans = read.csv("loans.csv")

# problem 1.1
loansTable = table(loans$not.fully.paid)
prop.table(loansTable)

# problem 1.2
summary(loans)

sum(is.na(loans))
missing <- subset(loans, is.na(log.annual.inc) | is.na(days.with.cr.line) | is.na(revol.util) | 
                    is.na(inq.last.6mths) | is.na(delinq.2yrs) | is.na(pub.rec))
table(missing$not.fully.paid)
table(loans$not.fully.paid)
# Eliminate wrong answers


# problem 2.1
loans_imputed <- read.csv("loans_imputed.csv")
library(caTools)
set.seed(144)
split = sample.split(loans_imputed$not.fully.paid,  SplitRatio = 0.7)
train <- subset(loans_imputed, split == T)
test <- subset(loans_imputed, split == F)

loansLog1 = glm(not.fully.paid ~ ., data = train, family = "binomial")
summary(loansLog1)

# problem 2.3
loansPred1 = predict(loansLog1, newdata = test, type = "response")
test$predicted.risk = loansPred1
table(test$not.fully.paid, loansPred1 >= 0.5)

(2400 + 3) / (2400 + 3 + 13 + 457)
(2400 + 13) / (2400 + 3 + 13 + 457)

# problem 2.4
library(ROCR)
ROCRpred1 = prediction(loansPred1, test$not.fully.paid)
ROCRperf1 = performance(ROCRpred1, "tpr", "fpr")
auc = as.numeric(performance(ROCRpred1, "auc")@y.values)
auc
#?prediction
#?predict
plot(ROCRperf1)
plot(ROCRperf1, colorize = TRUE)
plot(ROCRperf1, colorize = TRUE, print.cutoffs.at = seq(0, 1, 0.1), text.adj = c(-0.2, 1.7))
summary(ROCRperf1)

# problem 3.2
loansLog2 = glm(not.fully.paid ~ int.rate, data = train, family = "binomial")
summary((loansLog2))
loansPred2 = predict(loansLog2, newdata = test, type = "response")
max(loansPred2)
table(test$not.fully.paid, loansPred2 >= 0.5)


# problem 3.3
ROCRpred2 = prediction(loansPred2, test$not.fully.paid)
ROCRperf2 = performance(ROCRpred2, "tpr", "fpr")
auc2 = as.numeric(performance(ROCRpred2, "auc")@y.values)
auc2

# problem 4.1
10 * exp(0.06*3)


# problem 5.1
test$profit = exp(test$int.rate*3) - 1
test$profit[test$not.fully.paid == 1] = -1
10 * max(test$profit)

# problem 6.1
highyield = subset(test, test$int.rate >= 0.15)
mean(highyield$profit)
prop.table(table(highyield$not.fully.paid))

# problem 6.2
cutoff = sort(highyield$predicted.risk, decreasing=FALSE)[100]
cutoff
choice = subset(highyield, highyield$predicted.risk <= 0.1763305)
sum(choice$profit)
table(choice$not.fully.paid)
