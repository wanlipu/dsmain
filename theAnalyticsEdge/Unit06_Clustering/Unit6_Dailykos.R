dailykos = read.csv('dailykos.csv')
summary(dailykos)
distances = dist(dailykos, method = "euclidean")

# Hierarchical clustering
clusterdailykos = hclust(distances, method = "ward") 

# Plot the dendrogram
plot(clusterdailykos)


rect.hclust(clusterdailykos, k = 7, border = "red")
dailykosClusters = cutree(clusterdailykos, k = 7)
dailykosClusters

table(dailykosClusters)


clusters <- cutree(clusterdailykos, k=7)
dailykos$hcuster = clusters
cluster1 <- subset(dailykos, clusters==1)
cluster2 <- subset(dailykos, clusters==2)
cluster3 <- subset(dailykos, clusters==3)
cluster4 <- subset(dailykos, clusters==4)
cluster5 <- subset(dailykos, clusters==5)
cluster6 <- subset(dailykos, clusters==6)
cluster7 <- subset(dailykos, clusters==7)
table(clusters)

tail(sort(colMeans(cluster1)))
tail(sort(colMeans(cluster2)))
tail(sort(colMeans(cluster3)))
tail(sort(colMeans(cluster4)))
tail(sort(colMeans(cluster5)))
tail(sort(colMeans(cluster6)))
tail(sort(colMeans(cluster7)))


# Specify number of clusters
k = 7

# Run k-means
set.seed(1000)
KMC_kos = kmeans(dailykos, centers = k, iter.max = 1000)
str(KMC_kos)

# Extract clusters
KMClusters = KMC_kos$cluster
dailykos$KMC = KMClusters

table(KMClusters)

cluster1 <- subset(dailykos, KMClusters==1)
cluster2 <- subset(dailykos, KMClusters==2)
cluster3 <- subset(dailykos, KMClusters==3)
cluster4 <- subset(dailykos, KMClusters==4)
cluster5 <- subset(dailykos, KMClusters==5)
cluster6 <- subset(dailykos, KMClusters==6)
cluster7 <- subset(dailykos, KMClusters==7)

tail(sort(colMeans(cluster1)))
tail(sort(colMeans(cluster2)))
tail(sort(colMeans(cluster3)))
tail(sort(colMeans(cluster4)))
tail(sort(colMeans(cluster5)))
tail(sort(colMeans(cluster6)))
tail(sort(colMeans(cluster7)))

table(dailykos$KMC, dailykos$hcuster)
