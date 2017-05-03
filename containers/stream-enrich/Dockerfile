FROM openjdk:8

RUN wget http://dl.bintray.com/snowplow/snowplow-generic/snowplow_stream_enrich_0.10.0.zip && \
    unzip snowplow_stream_enrich_0.10.0.zip

COPY default.conf default.conf
COPY enrichments enrichments
COPY resolvers.json resolvers.json

CMD sed -i "s/__KAFKA_BROKERS__/${KAFKA_BROKERS}/g" default.conf && \
    sed -i "s/__TOPIC_INPUT__/${TOPIC_INPUT}/g" default.conf && \
    sed -i "s/__TOPIC_GOOD__/${TOPIC_GOOD}/g" default.conf && \
    sed -i "s/__TOPIC_BAD__/${TOPIC_BAD}/g" default.conf && \
    sed -i "s/__BUFFER_TIME_LIMIT__/${BUFFER_TIME_LIMIT}/g" default.conf && \
    sed -i "s/__IGLU_REPO__/${IGLUREPO_PORT_8020_TCP_ADDR}:8020/g" resolvers.json && \
    ./snowplow-stream-enrich-0.10.0 --config default.conf --resolver file:resolvers.json --enrichments file:enrichments

# docker build -t stream-enrich:v1 .
# docker run -it --rm --name=stream-enrich --link=iglurepo:iglurepo --env KAFKA_BROKERS=127.0.0.1:9092 --env TOPIC_INPUT=raw-events --env TOPIC_GOOD=enrich-good-events --env TOPIC_BAD=enrich-bad-events --env BUFFER_TIME_LIMIT=1000 stream-enrich:v1
