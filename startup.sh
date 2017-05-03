docker run -d --rm --name zookeeper jplock/zookeeper:3.4.6
ZK_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' zookeeper)
echo "zooKeeperIp:" $ZK_IP 
docker run -d --rm --name kafka --link zookeeper:zookeeper ches/kafka
KAFKA_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' kafka)
echo "kafkaIp:" $KAFKA_IP 
docker run --rm ches/kafka kafka-topics.sh --create --topic raw-events --replication-factor 1 --partitions 1 --zookeeper $ZK_IP:2181
docker run --rm ches/kafka kafka-topics.sh --create --topic bad-events --replication-factor 1 --partitions 1 --zookeeper $ZK_IP:2181
docker run --rm ches/kafka kafka-topics.sh --create --topic enrich-good-events --replication-factor 1 --partitions 1 --zookeeper $ZK_IP:2181
docker run --rm ches/kafka kafka-topics.sh --create --topic enrich-bad-events --replication-factor 1 --partitions 1 --zookeeper $ZK_IP:2181
echo "created topics:"
docker run --rm ches/kafka kafka-topics.sh --list --zookeeper $ZK_IP:2181

docker run -it -d --rm --name=scala-stream-collector --link kafka:kafka -p 8080:8080 --env SINK=kafka --env BIND_TO=$KAFKA_IP:9092 --env TOPIC_GOOD=raw-events --env TOPIC_BAD=bad-events scala-stream-collector:v1
docker run -it --rm -d -p 8020:8020 --name=iglurepo iglu-repo:v1
docker run -it --rm -d --name=stream-enrich --link=iglurepo:iglurepo --link=kafka:kafka --env KAFKA_BROKERS=$KAFKA_IP:9092 --env TOPIC_INPUT=raw-events --env TOPIC_GOOD=enrich-good-events --env TOPIC_BAD=enrich-bad-events --env BUFFER_TIME_LIMIT=1000 stream-enrich:v1

#docker run -it --rm -d --name=kafka-consumer --link=kafka:kafka --env BIND_TO=$ZK_IP:2181 kafka-consumer:v1
