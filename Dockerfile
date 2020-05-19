FROM node:10-alpine

LABEL maintainer="Richard Szolár (RS Labs) <hello@rs-labs.io>"

# Create app directory
RUN mkdir /etc/node-bridge -p

COPY ./run-app.sh /usr/local/run-app.sh
RUN chmod +x /usr/local/run-app.sh

WORKDIR /etc/node-bridge/bridge

RUN wget https://github.com/0x111/node-exec/archive/master.tar.gz -O /tmp/master.tar.gz && \
    tar --strip-components=1 -xzf /tmp/master.tar.gz -C /etc/node-bridge && \
    rm /tmp/master.tar.gz && \
    cd /etc/node-bridge/bridge && \
    yarn cache clean && \
    yarn install

EXPOSE 8001

STOPSIGNAL SIGTERM

CMD ["yarn", "start"]