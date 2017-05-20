FROM node:4.5
COPY index.js .
COPY package.json .
COPY public public

RUN npm install
CMD npm start

EXPOSE 3000

# docker build -t os-counter:v1 .
# docker run -it --rm --name=os-counter --link=kafka:kafka --env BIND_TO=$ZK_IP:2181 os-counter:v1
