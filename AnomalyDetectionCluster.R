cat("#ANOMALY DETECTION BASED ON CLUSTERING STARTED#\n")
vessel_data2clust<-vessel_data
featuresToCluster<-c("bimac","density","density_freq","bathymetry_prob")
vessel_data2clust<-vessel_data[,featuresToCluster]
vessel_data2clust_scaled<-scale(vessel_data2clust)
vessel_data2clust_scaled<-as.data.frame(vessel_data2clust_scaled)

cat("clustering\n")
#vessels have low mutual distance and distance from ports
# Perform k-means clustering with 3 clusters
kmeans_result_anom <- kmeans(vessel_data2clust_scaled, centers = 4)

# View clustering results
print(kmeans_result_anom)
plot(kmeans_result_anom$cluster)

ordered_centroids<-order(rowSums(kmeans_result_anom$centers))
centroids_good<-c(ordered_centroids[4],ordered_centroids[3],ordered_centroids[2])

clusterization_of_vectors<-as.numeric(kmeans_result_anom$cluster)
index_good<-which(clusterization_of_vectors%in%centroids_good)
vae_classification<-vessel_data
vae_classification$fishing<-F
vae_classification$fishing[index_good]<-T


cat("#ANOMALY DETECTION BASED ON CLUSTERING FINISHED#\n")