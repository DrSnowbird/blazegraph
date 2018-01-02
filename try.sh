#!/bin/bash -x


MY_IP=`ip route get 1|awk '{print$NF;exit;}'`

function displayPortainerURL() {
    port=${1}
    echo "... Go to: http://${MY_IP}:${port}"
    #firefox http://${MY_IP}:${port} &
    if [ "`which google-chrome`" != "" ]; then
        /usr/bin/google-chrome http://${MY_IP}:${port} &
    else
        firefox http://${MY_IP}:${port} &
    fi
}

displayPortainerURL 9999
