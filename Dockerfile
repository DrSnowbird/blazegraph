FROM openkbs/jdk-mvn-py3

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

################################
#### ---- Environment Vars ----
################################
ARG BLAZEGRAPH_VERSION=${BLAZEGRAPH_VERSION:-2.1.4}
ENV BLAZEGRAPH_VERSION=${BLAZEGRAPH_VERSION}

ARG BLAZEGRAPH_PORT=${BLAZEGRAPH_PORT:-9999}
ENV BLAZEGRAPH_PORT=${BLAZEGRAPH_PORT}

ARG BLAZEGRAPH_HOME=${BLAZEGRAPH_HOME:-/usr/blazegraph}
ENV BLAZEGRAPH_HOME=${BLAZEGRAPH_HOME}

ENV DATA_DIR=/data

################################
#### ---- BlazeGraph Server ----
################################
## -- ref: https://sourceforge.net/projects/bigdata/files
ENV BLAZEGRAPH_URL=https://sourceforge.net/projects/bigdata/files/bigdata/${BLAZEGRAPH_VERSION}/blazegraph.jar

RUN set -x \
    && mkdir -p $BLAZEGRAPH_HOME \
    && mkdir -p ${BLAZEGRAPH_HOME}/conf

## (blazegraph option) -v $PWD/conf:/conf
ENV conf_DIR=${BLAZEGRAPH_HOME}/conf
VOLUME ${conf_DIR}

## (blazegraph option): -Dbigdata.propertyFile=/usr/blazegraph/conf/RWStore.properties 
ENV BIGDATA_PROPERTY=${BLAZEGRAPH_HOME}/conf/RWStore.properties

## (blazegraph option): -Djetty.overrideWebXml=/path/to/override.xml
#ENV JETTY_OVERRIDEWEBXML=${BLAZEGRAPH_HOME}/conf/web.xml

################################
#### ---- Volume ----
################################
VOLUME ${DATA_DIR}

EXPOSE ${BLAZEGRAPH_PORT}

WORKDIR ${BLAZEGRAPH_HOME}

## -- (opt-1.) Copy from local directory: --
#COPY ./blazegraph.jar $BLAZEGRAPH_HOME/

## -- (opt-2.) Download from Internet: --
RUN set -x && \
    wget -c ${BLAZEGRAPH_URL} && \
    ls -al ${BLAZEGRAPH_HOME}/*
    
COPY RWStore.properties ${BLAZEGRAPH_HOME}/conf/RWStore.properties

################################
#### ---- Entrypoint & CMD  ----
################################
CMD java -server -Xmx4g -jar -Dbigdata.propertyFile=${BIGDATA_PROPERTY} ${BLAZEGRAPH_HOME}/blazegraph.jar 
#CMD ["java", "-server", "-Xmx4g", "-jar", "${BLAZEGRAPH_HOME}/$(basename ${BLAZEGRAPH_URL})"]
#CMD ["java", "-server", "-Xmx4g", "-jar", "${BLAZEGRAPH_HOME}/blazegraph.jar"]

USER ${USER_ID}
WORKDIR ${DATA_DIR}
#ENTRYPOINT ["/bin/bash"] 



