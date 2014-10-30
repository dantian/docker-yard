## Elastic Jenkins build cluster using Jenkins Swarm Plugin

The [Jenkins Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin) enables Jenkins slaves to auto-discover nearby Jenkins master and join it automatically, thereby forming an elastic Jenkins build cluster.

The files here are for creating CentOS-6 docker containers as Jenkins slaves to join a Jenkins build cluster using the Jenkins Swarm Plugin. 

### Create/download the docker image 

On the native host running Docker, create a docker image using the files in this folder (centos6-swarm-slave). 
The following is the command sequence to check out the files and build the docker container image.

```
git clone https://github.com/dantian/docker-yard
cd docker-yard
docker build centos6-swarm-slave/
```

Using this Docker image, make further updates (e.g., installing rpm packages, etc.) as necessary.

### Install the Jenkins Swarm Plugin on the Jenkins Master

Please follow the instructions in the [Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin)
to install the Jenkins Swarm Plugin on the Jenkins master host.

### Start a Jenkins slave in a Docker container using the newly built Docker image 

Assume that the Jenkins master host url is http://ci.xyz.com:8080/, and the id for the Docker image created in the previous step is 4b810e583d82, start a Jenkins slave in a Docker container using the following command

```
docker run -d -h centos6-swarm-slave -P --env JENKINS_MASTER_URL="http://ci.xyz.com:8080/" 4b810e583d82
```

On the Jenkins master dashboard, there should be a new Jenkins slave with the label centos6-swarm-slave.

### Create build jobs to run on the newly added Jenkins build slave in a Docker container

Users can set up build jobs on the Jenkins dashboard to run on the Jenkins slave in the Docker container. 

