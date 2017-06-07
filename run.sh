#!/bin/bash -x

##################################################
#### ---- Mandatory: Change those ----
##################################################

PACKAGE=blazegraph
BLAZEGRAPH_HOME=/usr/blazegraph

docker_volume_data=/data
docker_volume_config=/config

docker_port1=9999
local_docker_port1=9999

local_dir=/mnt/data

version=

##################################################
#### ---- Mostly, you don't need change below ----
##################################################

echo "Usage: "
echo "  ${0} [<repo-name/repo-tag>] [<repo-version>]"
echo "e.g."
echo "  ${0} openkbs/${PACKAGE} 1.0.0"
echo "or"
echo "  ${0} openkbs/${PACKAGE}"

# Reference: https://docs.docker.com/engine/userguide/containers/dockerimages/
imageTag=${1:-openkbs/${PACKAGE}}
version=${2:-${version}}
if [ "$version" == "" ]; then
    imageTagString=$imageTag
else
    imageTagString=${imageTag}:${version}
fi

#instanceName=my-${2:-${imageTag%/*}}_$RANDOM
instanceName=my-${2:-${imageTag##*/}}

#### ---- instance local data on the host ----
local_docker_data=${local_dir}/data-docker/${PACKAGE}/data
mkdir -p ${local_docker_data}

#### ---- instance's local config on the host ---
local_docker_config=${local_dir}/data-docker/${PACKAGE}/config
mkdir -p ${local_docker_config}

MY_IP=`ip route get 1|awk '{print $NF;exit;}'`

#### ----- RUN -------
echo "To run: for example"
echo "docker run -d --name my-${imageTag##*/} -p ${local_docker_port1}:${docker_port1} -v ${local_docker_data}:${docker_volume_data} -v ${local_docker_config}:${docker_volume_config} ${imageTag}"
echo "---------------------------------------------"
echo "---- Starting a Container for ${imageTag}"
echo "---------------------------------------------"
#docker run --rm -P -d --name $instanceName $imageTag
docker run \
    --detach \
    --name=${instanceName} \
    --publish ${local_docker_port1}:${docker_port1} \
    --volume=${local_docker_data}:${docker_volume_data} \
    --volume=${local_docker_config}:${docker_volume_config} \
    ${imageTagString} 
    
# docker logs -f ${instanceName} &

if [ ! "$version" == "" ]; then
    #docker run --rm -P -d -t --name ${instanceName} -v ${local_docker_data}:${docker_volume_data} ${imageTag}:${version}
    echo "docker run --rm -P -d --name ${instanceName} -v ${local_docker_data}:${docker_volume_data} -v ${local_docker_config}:${docker_volume_config} ${imageTag}:${version}"
else
    #docker run --rm -P -d -t --name ${instanceName} -v ${local_docker_data}:${docker_volume_data} ${imageTag}
    echo "docker run --rm -P -d --name ${instanceName} -v ${local_docker_data}:${docker_volume_data} -v ${local_docker_config}:${docker_volume_config} ${imageTag}"
fi

echo "Web UI: http://${MY_IP}:${local_docker_port1}/"
echo "SPARQL UI: http://${MY_IP}:${local_docker_port1}/bigdata"

echo ">>> Docker Status"
docker ps -a | grep "${instanceName}"
echo "-----------------------------------------------"
echo ">>> Docker Shell into Container `docker ps -lqa`"


 
#docker exec -it ${instanceName} /bin/bash

