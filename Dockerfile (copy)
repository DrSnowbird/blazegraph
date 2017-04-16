FROM openkbs/jre-mvn-py

MAINTAINER OpenKBS 

ENV SERVERS_HOME=/usr

ENV DATA_DIR /data
VOLUME $DATA_DIR

################################
#### ---- BlazeGraph Server ----
################################
## -- ref: https://sourceforge.net/projects/bigdata/files
ENV BLAZEGRAPH_URL https://sourceforge.net/projects/bigdata/files/bigdata/2.1.4/blazegraph.jar

## (blazegraph option) -v $PWD/config:/config
ENV CONFIG_DIR /config

## (blazegraph option): -Dbigdata.propertyFile=/etc/blazegraph/RWStore.properties 
ENV BIGDATA_PROPERTY /config/RWStore.properties

## (blazegraph option): -Djetty.overrideWebXml=/path/to/override.xml
ENV JETTY_OVERRIDEWEBXML /config/web.xml

ENV BLAZEGRAPH_HOME $SERVERS_HOME/blazegraph

RUN set -x \
    && mkdir -p $BLAZEGRAPH_HOME 

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



