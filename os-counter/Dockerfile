FROM node:4.5
COPY index.html .
COPY package.json .
COPY public .

RUN npm install
CMD npm start

# docker build -t os-counter:v1 .
# docker run -it --rm --name=os-counter --link=kafka:kafka --env BIND_TO=$ZK_IP:2181 os-counter:v1
