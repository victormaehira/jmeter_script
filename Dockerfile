FROM openjdk:8-jre-slim
ARG JMETER_VERSION

ENV JMETER_VERSION ${JMETER_VERSION:-5.4.1}
ENV JMETER_HOME /jmeter/apache-jmeter-$JMETER_VERSION/
ENV PATH $JMETER_HOME/bin:$PATH

ENV TARGET_URL=172.128.2.52
ENV TARGET_PORT=8080
ENV LOOPS=1
ENV NUM_THREADS=60
ENV RAMP_TIME=60

# INSTALL PRE-REQ
RUN apt-get update && \
    apt-get -y install \
    wget 

# INSTALL JMETER BASE 
RUN mkdir /jmeter
WORKDIR /jmeter
RUN wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-$JMETER_VERSION.tgz
RUN tar -xzf apache-jmeter-$JMETER_VERSION.tgz
RUN rm apache-jmeter-$JMETER_VERSION.tgz

WORKDIR $JMETER_HOME 
    
COPY ./json_file.txt /jmeter/apache-jmeter-$JMETER_VERSION/bin
COPY ./liveness2d.jmx /jmeter/apache-jmeter-$JMETER_VERSION/bin
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

WORKDIR $JMETER_HOME/bin

EXPOSE 60000 1099 50000
ENTRYPOINT ["/docker-entrypoint.sh"]