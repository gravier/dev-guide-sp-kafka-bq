FROM node:4.5
COPY app.js .
COPY package.json .
RUN npm install
CMD npm start

# docker build -t bq-connector:v1 .
# docker run -it --rm --name=bq-connector --link=kafka:kafka --env BIND_TO=$ZK_IP:2181 --env BQ_PROJECT=yourproject_id-1234 --env BQ_DATASET=test --env BQ_TABLE=cs_pipe  bq-connector:v1
