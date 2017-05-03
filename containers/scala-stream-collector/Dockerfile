FROM openjdk:8

RUN wget http://dl.bintray.com/snowplow/snowplow-generic/snowplow_scala_stream_collector_0.9.0.zip && \
    unzip snowplow_scala_stream_collector_0.9.0.zip

COPY default.conf default.conf

CMD sed -i "s/__BIND_TO__/${BIND_TO}/g" default.conf && \
    sed -i "s/__SINK__/${SINK}/g" default.conf && \
    sed -i "s/__TOPIC_GOOD__/${TOPIC_GOOD}/g" default.conf && \
    sed -i "s/__TOPIC_BAD__/${TOPIC_BAD}/g" default.conf && \
    ./snowplow-stream-collector-0.9.0 --config default.conf

EXPOSE 8080

# docker build -t scala-stream-collector:v1 .
# docker run -it --rm --name=scala-stream-collector -p 8080:8080 --env SINK=stdout scala-stream-collector:v1
# docker run -it --rm --name=scala-stream-collector -p 8080:8080 --env SINK=kafka --env BIND_TO=127.0.0.1:9092 --env TOPIC_GOOD=raw-events --env TOPIC_BAD=bad-events scala-stream-collector:v1
# curl http://localhost:8080/health
