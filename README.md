# dev-guide-sp-kafka-bq
code for talk developers guide for realtime pipeline with snowplow kafka and bigquery

# How to setup snowplow schemas

- setup schemas folder


# Setup cluster on GCP

### 1. Create a kubernetes cluster:

```
gcloud container clusters create clickstream-pipeline --num-nodes=2 --scopes bigquery
```

you only need bigquery for writing events
couple of nodes are recommended as kubernetes mast	er node has significant allocation of resources not leaving enough more than 1-2 deployments.

### 2. add volumes for kafka and zookeeper
```
gcloud compute disks create --size=50GB --zone=europe-west1-d zookeeper-volume
gcloud compute disks create --size=100GB --zone=europe-west1-d kafka-volume
```

### 3. create volumes and claims

```
kubectl create -f k8s/zookeeper/zookeeper-volume.yaml
kubectl create -f k8s/kafka/kafka-volume.yaml
kubectl create -f k8s/zookeeper/zookeeper-volume-claim.yaml
kubectl create -f k8s/kafka/kafka-volume-claim.yaml
```

### 4. create volumes and claims

# improvements
1. zookeeper and kafka multi instance clusters
2. processing custom contexts
3. adding endpoints for logs and monitoring
