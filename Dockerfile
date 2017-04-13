FROM docker.io/node:0.10.48

WORKDIR /usr/src/app
RUN git clone https://github.com/CartoDB/Windshaft-cartodb.git -b 2.5.0 .
COPY npm-shrinkwrap.json /usr/src/app/
COPY development.js /usr/src/app/config/environments/
RUN apt-get update && apt-get install -y libpango1.0-dev socat && apt-get clean
RUN curl -sL https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz | tar xzv -C /
RUN npm install
COPY services.d/ /etc/services.d/

EXPOSE 8181
CMD /init
