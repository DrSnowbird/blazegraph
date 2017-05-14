FROM openkbs/jre-mvn-py3

MAINTAINER OpenKBS 

ENV SERVERS_HOME=/usr

ENV DATA_DIR /data
VOLUME $DATA_DIR

ENV BLAZEGRAPH_HOME $SERVERS_HOME/blazegraph

################################
#### ---- BlazeGraph Server ----
################################
## -- ref: https://sourceforge.net/projects/bigdata/files
ENV BLAZEGRAPH_URL https://sourceforge.net/projects/bigdata/files/bigdata/2.1.4/blazegraph.jar

## (blazegraph option) -v $PWD/config:/config
ENV CONFIG_DIR ${BLAZEGRAPH_HOME}/config
VOLUME $CONFIG_DIR

## (blazegraph option): -Dbigdata.propertyFile=/etc/blazegraph/RWStore.properties 
ENV BIGDATA_PROPERTY ${BLAZEGRAPH_HOME}/config/RWStore.properties
COPY RWStore.properties ${BLAZEGRAPH_HOME}/config/RWStore.properties

## (blazegraph option): -Djetty.overrideWebXml=/path/to/override.xml
ENV JETTY_OVERRIDEWEBXML ${BLAZEGRAPH_HOME}/config/web.xml

RUN set -x \
    && mkdir -p $BLAZEGRAPH_HOME \
    && mkdir -p ${BLAZEGRAPH_HOME}/config

EXPOSE 9999
    
WORKDIR $BLAZEGRAPH_HOME

## -- (opt-1.) Copy from local directory: --
#COPY ./blazegraph.jar $BLAZEGRAPH_HOME/

## -- (opt-2.) Download from Internet: --
RUN set -x && \
    wget -c $BLAZEGRAPH_URL && \
    ls -al $BLAZEGRAPH_HOME/*

CMD java -server -Xmx4g -jar $BLAZEGRAPH_HOME/blazegraph.jar
#CMD ["java", "-server", "-Xmx4g", "-jar", "$BLAZEGRAPH_HOME/$(basename $BLAZEGRAPH_URL)"]
#CMD ["java", "-server", "-Xmx4g", "-jar", "$BLAZEGRAPH_HOME/blazegraph.jar"]

################################
#### ---- Entrypoint ----
################################

WORKDIR $DATA_DIR
#ENTRYPOINT ["/bin/bash"] 



