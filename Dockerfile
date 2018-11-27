FROM openkbs/jdk-mvn-py3

MAINTAINER OpenKBS <DrSnowbird@openkbs.org>

################################
#### ---- Environment Vars ----
################################
ARG BLAZEGRAPH_VERSION=${BLAZEGRAPH_VERSION:-2.1.4}
ENV BLAZEGRAPH_VERSION=${BLAZEGRAPH_VERSION}

ARG BLAZEGRAPH_PORT=${BLAZEGRAPH_PORT:-9999}
ENV BLAZEGRAPH_PORT=${BLAZEGRAPH_PORT}

################################
#### ---- user: developer  ----
################################
## ---- user: developer ----
ENV USER_NAME=developer
ENV HOME=/home/${USER_NAME}

ARG USER_ID=${USER_ID:-1000}
ENV USER_ID=${USER_ID}

ARG GROUP_ID=${GROUP_ID:-1000}
ENV GROUP_ID=${GROUP_ID}

RUN groupadd -g ${GROUP_ID} ${USER_NAME} && \
    useradd -r -u ${USER_ID} -g ${USER_NAME} ${USER_NAME} && \
    export uid=${USER_ID} gid=${GROUP_ID} && \
    mkdir -p ${HOME} && \
    mkdir -p /etc/sudoers.d && \
    echo "${USER_NAME}:x:${USER_ID}:${GROUP_ID}:${USER_NAME},,,:${HOME}:/bin/bash" >> /etc/passwd && \
    echo "${USER_NAME}:x:${USER_ID}:" >> /etc/group && \
    echo "${USER_NAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USER_NAME} && \
    chmod 0440 /etc/sudoers.d/${USER_NAME} && \
    apt-get clean all 

################################################
#### ---- User's Data and Workspace folders ----
################################################
ARG DATA_DIR=${DATA_DIR:-${HOME}/data}
ENV DATA_DIR=${DATA_DIR}

################################
#### ---- BlazeGraph Server ----
################################
ARG BLAZEGRAPH_HOME=${BLAZEGRAPH_HOME:-${HOME}/blazegraph}
ENV BLAZEGRAPH_HOME=${BLAZEGRAPH_HOME}

## (blazegraph option) -v $PWD/conf:/conf
ARG BLAZEGRAPH_CONF_DIR=${BLAZEGRAPH_CONF_DIR:-${BLAZEGRAPH_HOME}/conf}

## (blazegraph option): -Dbigdata.propertyFile=/usr/blazegraph/conf/RWStore.properties 
ENV BIGDATA_PROPERTY=${BLAZEGRAPH_HOME}/conf/RWStore.properties

## (blazegraph option): -Djetty.overrideWebXml=/path/to/override.xml
#ENV JETTY_OVERRIDEWEBXML=${BLAZEGRAPH_HOME}/conf/web.xml

################################
#### ---- Setup Folders ----
################################
WORKDIR ${BLAZEGRAPH_HOME}

## -- ref: https://sourceforge.net/projects/bigdata/files
ENV BLAZEGRAPH_URL=https://sourceforge.net/projects/bigdata/files/bigdata/${BLAZEGRAPH_VERSION}/blazegraph.jar

RUN set -x && \
    mkdir -p ${HOME}/data && \
    mkdir -p ${BLAZEGRAPH_HOME} && \
    mkdir -p ${BLAZEGRAPH_CONF_DIR} && \
    chown ${USER_NAME}:${USER_NAME} -R ${HOME} ${BLAZEGRAPH_HOME} ${BLAZEGRAPH_CONF_DIR}
    
#################################
#### ---- Blazegraph install ----
#################################

USER ${USER_NAME}

## -- (opt-1.) Copy from local directory: --
#COPY ./blazegraph.jar $BLAZEGRAPH_HOME/

## -- (opt-2.) Download from Internet: --
RUN set -x && \
    wget -c ${BLAZEGRAPH_URL}

################################
#### ---- Blazegraph config ----
################################
COPY ./RWStore.properties ${BLAZEGRAPH_CONF_DIR}/
COPY ./printVersions.sh ${HOME}/

#####################
#### ---- Volume ----
#####################
VOLUME ${DATA_DIR}
VOLUME ${BLAZEGRAPH_CONF_DIR}

EXPOSE ${BLAZEGRAPH_PORT}

################################
#### ---- Entrypoint & CMD  ----
################################

WORKDIR ${HOME}
USER ${USER_NAME}

CMD java -server -Xmx4g -jar -Dbigdata.propertyFile=${BIGDATA_PROPERTY} ${BLAZEGRAPH_HOME}/blazegraph.jar 
#CMD ["java", "-server", "-Xmx4g", "-jar", "${BLAZEGRAPH_HOME}/$(basename ${BLAZEGRAPH_URL})"]
#CMD ["java", "-server", "-Xmx4g", "-jar", "${BLAZEGRAPH_HOME}/blazegraph.jar"]

