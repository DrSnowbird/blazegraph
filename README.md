# BlazeGraph 2.1.4 + Java 8 (1.8.0_191) JDK + Maven 3.5 + Python 3.5
[![](https://images.microbadger.com/badges/image/openkbs/blazegraph.svg)](https://microbadger.com/images/openkbs/blazegraph "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/openkbs/blazegraph.svg)](https://microbadger.com/images/openkbs/blazegraph "Get your own version badge on microbadger.com")

# License Agreement
By using this image, you agree the [Oracle Java JDK License](http://www.oracle.com/technetwork/java/javase/terms/license/index.html).
This image contains [Oracle JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html). You must accept the [Oracle Binary Code License Agreement for Java SE](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) to use this image.

# Components:
* [BlazeGraph](https://www.blazegraph.com/) 2.1.4 service will be running at http://<server_ip:9999>/
* java version "1.8.0_191"
  Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
  Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
* Apache Maven 3.5.3
* Python 3.5.2
* Gradle 4.9
* Other tools: git wget unzip vim python python-setuptools python-dev python-numpy 

# Run (recommended for easy-start)
Image is pulling from openkbs/netbeans
```
./run.sh
```
A successfully starting of BlazeGraph will have the following message displayed (IP address below will be different):
```
Welcome to the Blazegraph(tm) Database.
Go to http://172.17.0.3:9999/blazegraph/ to get started.
```
# Build
You can build your own image locally.
```
./build.sh
```

# Build / Run your own image

Say, you will build the image "my/blazegraph".

```bash
docker build -t my/blazegraph .
```

To run your own image, say, with some-blazegraph:

```bash
mkdir ./data
docker run -d --name some-blazegraph -v $PWD/data:/data -i -t my/blazegraph
```

# Shell into the Docker instance
```bash
docker exec -it some-blazegraph /bin/bash
```
# Run Blazegraph web, sparql, REST
For more information, please visit: https://wiki.blazegraph.com/wiki/index.php/NanoSparqlServer 

Web UI:
```http
Web UI: http://<ip_address>:9999/
```

For SPARQL Endpoint, see more at https://wiki.blazegraph.com/wiki/index.php/REST_API#SPARQL_End_Point
```http
SPARQL UI: http://<ip_address>:9999/bigdata
```

# (Optional Use) Run Python code
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
# (Optional Use) Compile or Run java while no local installation needed
Remember, the default working directory, /data, inside the docker container -- treat is as "/".
So, if you create subdirectory, "./data/workspace", in the host machine and
the docker container will have it as "/data/workspace".

```java
#!/bin/bash -x
mkdir ./data
cat >./data/HelloWorld.java <<-EOF
public class HelloWorld {
   public static void main(String[] args) {
      System.out.println("Hello, World");
   }
}
EOF
cat ./data/HelloWorld.java
alias djavac='docker run -it --rm --name some-jre-mvn-py3 -v '$PWD'/data:/data openkbs/jre-mvn-py3 javac'
alias djava='docker run -it --rm --name some-jre-mvn-py3 -v '$PWD'/data:/data openkbs/jre-mvn-py3 java'

djavac HelloWorld.java
djava HelloWorld
```
And, the output:
```
Hello, World
```
Hence, the alias above, "djavac" and "djava" is your docker-based "javac" and "java" commands and
it will work the same way as your local installed Java's "javac" and "java" commands.


# Reference
* [BlazeGraph](https://www.blazegraph.com/)

# Releases Information
```
JAVA_HOME=/usr/jdk1.8.0_191
java version "1.8.0_191"
Java(TM) SE Runtime Environment (build 1.8.0_191-b12)
Java HotSpot(TM) 64-Bit Server VM (build 25.191-b12, mixed mode)
Apache Maven 3.5.4 (1edded0938998edf8bf061f1ceb3cfdeccf443fe; 2018-06-17T18:33:14Z)
Maven home: /usr/apache-maven-3.5.4
Java version: 1.8.0_191, vendor: Oracle Corporation, runtime: /usr/jdk1.8.0_191/jre
Default locale: en_US, platform encoding: ANSI_X3.4-1968
OS name: "linux", version: "4.15.0-39-generic", arch: "amd64", family: "unix"
Python 3.5.2
Python 3.5.2
pip 18.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)
pip 18.1 from /usr/local/lib/python3.5/dist-packages/pip (python 3.5)

Welcome to Gradle 4.9!

Here are the highlights of this release:
 - Experimental APIs for creating and configuring tasks lazily
 - Pass arguments to JavaExec via CLI
 - Auxiliary publication dependency support for multi-project builds
 - Improved dependency insight report

For more details see https://docs.gradle.org/4.9/release-notes.html


------------------------------------------------------------
Gradle 4.9
------------------------------------------------------------

Build time:   2018-07-16 08:14:03 UTC
Revision:     efcf8c1cf533b03c70f394f270f46a174c738efc

Kotlin DSL:   0.18.4
Kotlin:       1.2.41
Groovy:       2.4.12
Ant:          Apache Ant(TM) version 1.9.11 compiled on March 23 2018
JVM:          1.8.0_191 (Oracle Corporation 25.191-b12)
OS:           Linux 4.15.0-39-generic amd64

DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=16.04
DISTRIB_CODENAME=xenial
DISTRIB_DESCRIPTION="Ubuntu 16.04.4 LTS"
NAME="Ubuntu"
VERSION="16.04.4 LTS (Xenial Xerus)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 16.04.4 LTS"
VERSION_ID="16.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
VERSION_CODENAME=xenial
UBUNTU_CODENAME=xenial
```
