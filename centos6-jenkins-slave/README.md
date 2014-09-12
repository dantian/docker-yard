## Configure Docker Cloud for Jenkins Slaves

### Configure Docker Deamon

On the host running the Docker cloud, start the docker daemon to listen to the port 4243. 
The following is the content of the file /usr/lib/systemd/system/docker.service on a Fedora-20 cloud host.

```
[Unit]
Description=Docker Application Container Engine
Documentation=http://docs.docker.com
After=network.target docker.socket
Requires=docker.socket

[Service]
Type=notify
EnvironmentFile=-/etc/sysconfig/docker
ExecStart=/usr/bin/docker -d -H fd:// -H tcp://0.0.0.0:4243 $OPTIONS
LimitNOFILE=1048576
LimitNPROC=1048576

[Install]
Also=docker.socket
```

Verify the version of the docker is below 1.2, with the command "docker --version". At the time (Sept. 12, 2014) of this writing, 
there is a known integration issue for Jenkins Docker plugin to work with docker 1.2. 

### Create/download the docker image 

On the native host running the Docker cloud, create a docker image using the files in this folder (centos6-jenkins-slave). 
The following is the command sequence to check out the files and build the docker container image.

```
git clone https://github.com/dantian/docker-yard
cd docker-yard
docker build centos6-jenkins-slave/
```

Using this Docker image, make further updates (e.g., installing rpm packages, etc.) as necessary.

### Configure Docker cloud on Jenkins Master

Please follow the instructions in the [Docker Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin)
to set up a Docker cloud using this image on the Jenkins dashboard. 

### Create build jobs to run on Docker cloud

Users can set up build jobs on the Jenkins dashboard to run on the Docker cloud. 

When the build job runs, a new Docker container will run on the Docker host using the Docker image. 
The build steps will execute inside this new Docker container. The Docker container will exit once the build stops. 
Users can see the build log on the "console output" for the build job on Jenkins dashboard. 
The workspace for the build job is empty (cleaned up in the Docker container) by default.
