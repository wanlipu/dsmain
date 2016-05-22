# 1
climate = read.csv("climate_change.csv")
str(climate)

climate_train = climate[climate$Year <= 2006,]
climate_test = climate[climate$Year > 2006,]

climate_model1 = lm(Temp ~ MEI + CO2 + CH4 + N2O + CFC.11 + CFC.12 + TSI + Aerosols, data = climate_train)
summary(climate_model1)

cor(climate_train)

climate_model2 = lm(Temp ~ MEI + N2O + TSI + Aerosols, data = climate_train)
summary(climate_model2)

climate_model_new = step(climate_model1)
summary(climate_model_new)

climate_predict = predict(climate_model_new, newdata = climate_test)
SSE = sum((climate_predict - climate_test$Temp)^2)
SST = sum((mean(climate_train$Temp) - climate_test$Temp)^2)
R2 = 1 - SSE/SST
R2


# 2
ls()
dir()

pisa_train = read.csv("pisa2009train.csv")
pisa_test = read.csv("pisa2009test.csv")

tapply(pisa_train$readingScore, pisa_train$male, mean)
summary(pisa_train)
str(pisa_train)


pisa_train = na.omit(pisa_train)
pisa_test = na.omit(pisa_test)

summary(pisa_train)

pisa_train$raceeth = relevel(pisa_train$raceeth, "White")

pisa_test$raceeth = relevel(pisa_test$raceeth, "White")

pisaLR = lm(readingScore ~ ., data = pisa_train)
summary(pisaLR)
SSE = sum(pisaLR$residuals^2)
RMSE = sqrt(SSE/nrow(pisa_train))
RMSE

pisa_predict = predict(pisaLR, newdata = pisa_test)
summary(pisa_predict)
max(pisa_predict) - min(pisa_predict)
test_SSE = sum((pisa_test$readingScore - pisa_predict)^2)
test_SSE
test_RMSE = sqrt(test_SSE/nrow(pisa_test))
test_RMSE

mean(pisa_train$readingScore)
SST = sum((pisa_test$readingScore - mean(pisa_train$readingScore))^2)
SST

R_squared = 1 - test_SSE/SST
R_squared

# 3

flu = read.csv("FluTrain.csv")

flu[which(flu$ILI == max(flu$ILI)),]
flu[which(flu$Queries == max(flu$Queries)),]

hist(flu$ILI)
hist(log(flu$ILI))

plot(flu$Queries, log(flu$ILI))

fluLR = lm(log(ILI) ~ Queries, data = flu)
# fluLR = lm(log(flu$ILI) ~ flu$Queries) # why this one is not right????
summary(fluLR)

flutest = read.csv("FluTest.csv")
predtest1 = exp(predict(fluLR, newdata=flutest))
predtest1
predtest1[which(flutest$Week == "2012-03-11 - 2012-03-17")]
flutest$ILI[11]
(flutest$ILI[11] - predtest1[which(flutest$Week == "2012-03-11 - 2012-03-17")])/flutest$ILI[11]

SSE = sum((predtest1 - flutest$ILI)^2)
RMSE = sqrt(SSE/nrow(flutest))
RMSE

install.packages("zoo")
library(zoo)

ILILag2 = lag(zoo(flu$ILI), -2, na.pad=TRUE)
flu$ILILag2 = coredata(ILILag2)
summary(ILILag2)

plot(log(flu$ILI), log(ILILag2))

model2 = lm(log(ILI) ~ Queries + log(ILILag2), data = flu)
summary(model2)

ILILag2_test = lag(zoo(flutest$ILI), -2, na.pad=TRUE)
flutest$ILILag2 = coredata(ILILag2_test)
summary(ILILag2_test)
?coredata
