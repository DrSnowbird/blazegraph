
[![](https://imagelayers.io/badge/openkbs/blazegraph:1.0.0.svg)](https://imagelayers.io/?images=openkbs/blazegraph:1.0.0 'Get your own badge on imagelayers.io')

Components:

* BlazeGraph 2.1.4 service at http://<server_ip:9999>/

* Oracle Java "1.8.0_112" JRE Runtime Environment for Server
* Apache Maven 3.3.9
* Python 2.7.11
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

## Pull the image from Docker Repository

```bash
docker pull openkbs/blazegraph
```

## Base the image to build add-on components

```Dockerfile
FROM openkbs/blazegraph
```

## Run the image

Then, you're ready to run :
Make sure you create your work directory, e.g., /data

```bash
mkdir ./data
docker run -d --name my-blazegraph -v $PWD/data:/data -i -t openkbs/blazegraph
```

## Build and Run your own image

Say, you will build the image "my/blazegraph".

```bash
docker build -t my/blazegraph .
```

To run your own image, say, with some-blazegraph:

```bash
mkdir ./data
docker run -d --name some-blazegraph -v $PWD/data:/data -i -t my/blazegraph
```

## Shell into the Docker instance
```bash
docker exec -it some-blazegraph /bin/bash
```
## Run Blazegraph web, sparql, REST
For more information, please visit: https://wiki.blazegraph.com/wiki/index.php/NanoSparqlServer 

Web UI:
```http
Web UI: http://<ip_address>:9999/
```

For SPARQL Endpoint, see more at https://wiki.blazegraph.com/wiki/index.php/REST_API#SPARQL_End_Point
```http
SPARQL UI: http://<ip_address>:9999/bigdata
```

## Run Python code
To run Python code 

```bash
docker run --rm openkbs/blazegraph python -c 'print("Hello World")'
```

or,

```bash
mkdir ./data
echo "print('Hello World')" > ./data/myPyScript.py
docker run -it --rm --name some-blazegraph -v "$PWD"/data:/data openkbs/blazegraph python myPyScript.py
```

or,

```bash
alias dpy='docker run --rm openkbs/blazegraph python'
dpy -c 'print("Hello World")'
```

