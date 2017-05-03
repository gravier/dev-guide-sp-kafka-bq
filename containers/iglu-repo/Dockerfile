FROM alpine:3.5

# https://hub.docker.com/r/frolvlad/alpine-python2/~/dockerfile/

RUN apk add --no-cache python && \
    python -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools && \
    rm -r /root/.cache

COPY schemas /opt/schemas

WORKDIR /opt

CMD python -m SimpleHTTPServer 8020

EXPOSE 8020


# docker build -t iglu-repo:v1 .
# docker run -it --rm -p 8020:8020 --name=iglurepo iglu-repo:v1
# curl $(docker-machine ip main):8020
