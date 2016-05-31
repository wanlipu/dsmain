airlines = read.csv('AirlinesCluster.csv')
summary(airlines)

install.packages("caret")

library(caret)

preproc = preProcess(airlines)

airlinesNorm = predict(preproc, airlines)
summary(airlinesNorm)

distances = dist(airlinesNorm, method = "euclidean")
clusterairlines = hclust(distances, method = "ward") 
plot(clusterairlines)


rect.hclust(clusterairlines, k = 5, border = "red")
airlinesClusters = cutree(clusterairlines, k = 5)
airlinesClusters

cluster1 <- subset(airlines, airlinesClusters==1)
cluster2 <- subset(airlines, airlinesClusters==2)
cluster3 <- subset(airlines, airlinesClusters==3)
cluster4 <- subset(airlines, airlinesClusters==4)
cluster5 <- subset(airlines, airlinesClusters==5)





table(airlinesClusters)

tapply(airlines$Balance, airlinesClusters, mean)
tapply(airlines$QualMiles, airlinesClusters, mean)
tapply(airlines$BonusMiles, airlinesClusters, mean)
tapply(airlines$BonusTrans, airlinesClusters, mean)
tapply(airlines$FlightMiles, airlinesClusters, mean)
tapply(airlines$FlightTrans, airlinesClusters, mean)
tapply(airlines$DaysSinceEnroll, airlinesClusters, mean)
tapply(airlines$Balance, airlinesClusters, mean)



k = 5

# Run k-means
set.seed(88)
KMC_airlines = kmeans(airlinesNorm, centers = k, iter.max = 1000)
str(KMC_airlines)

# Extract clusters
KMClusters = KMC_airlines$cluster

table(KMClusters)

