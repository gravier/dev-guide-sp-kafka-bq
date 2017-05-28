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
kubectl create -f k8s/zookeeper-volume.yaml
kubectl create -f k8s/kafka-volume.yaml
kubectl create -f k8s/zookeeper-volume-claim.yaml
kubectl create -f k8s/kafka-volume-claim.yaml
```

### 4. create zookeeper and kafka service and pods

```
kubectl create -f k8s/zookeeper-service.yaml
kubectl create -f k8s/zookeeper.yaml
kubectl create -f k8s/kafka-service.yaml
kubectl create -f k8s/kafka.yaml
```

### 5. create iglu-repo for custom schemas

```
kubectl create -f iglu-repo-service.yaml
kubectl create -f iglu-repo.yaml
```

### 6. create stream collector and enrich

```
kubectl create -f snowplow-scala-stream-collector-service.yaml 
kubectl create -f snowplow-scala-stream-collector.yaml 
kubectl create -f snowplow-scala-stream-enrich.yaml 
```

### 7. add connector for pushing events to bq

```
kubectl create -f bq-connector.yaml
```

### 8. run the os-counter example app for counting events by OS

```
kubectl create -f os-counter-service.yaml
kubectl create -f os-counter.yaml
```

### 9. check IP of collector and os-counter

```
kubectl get svc
NAME                          CLUSTER-IP     EXTERNAL-IP      PORT(S) 
os-counter                    10.7.245.144   <external-ip>    80:31005/TCP
scala-stream-collector-node   10.7.252.185   <external-ip>    80:32222/TCP 
```

### 10. Change website/index.html with collector ip address

```
window.snowplow('newTracker', 'cf', '<collector-ip>', { // Initialise a tracker
  appId: 'dev-guide-tracker',
  cookieDomain: ''
});
```

# Testing pipeline
1. Open the os-counter website http://{os-counter-ip}
2. Open testing client website website/index.html
3. Check if os-counter events are coming in

# Improvements
1. zookeeper and kafka multi instance clusters
2. processing custom contexts
3. adding endpoints for logs and monitoring

# slides


# talk
https://www.youtube.com/watch?v=t3bISkp7zBw
