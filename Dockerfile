FROM node:10-alpine

LABEL maintainer="Richard Szolár (RS Labs) <hello@rs-labs.io>"

COPY . /etc/node-bridge

#ADD ./bridge /etc/node-bridge

# Create app directory
WORKDIR /etc/node-bridge/bridge

RUN apk update && \
    apk add nginx --no-cache && \
    cp /etc/node-bridge/nginx/conf.d/rest-web.conf /etc/nginx/conf.d/rest-web.conf && \
    mkdir /run/nginx -p && \
    nginx -t && \
    nginx -g  "daemon on;" && \
    cd /etc/node-bridge/bridge &&\
    yarn install && \
    yarn start

EXPOSE 8080