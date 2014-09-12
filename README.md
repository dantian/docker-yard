# Introduction

This repository contains definitions for creating various docker container images.

## CentOS-6 Jenkins Slave Containers 

This container is for the [Jenkins Docker plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin). 

First create a docker image using the Dockerfile on a host for running the containers as Jenkins slaves. 
Then follow the instructions in the Docker Plugin to set up a Docker cloud using this image on the Jenkins dashboard. 
Afterwards, users can set up build jobs on the Jenkins dashboard to run on the Docker cloud. 
When the build job runs, a new Docker container will run on the Docker host using the Docker image. The build steps will execute inside this new Docker container. 
The Docker container will exit once the build stops. Users can see the build log on the "console output" for the build job on Jenkins dashboard. 
The workspace for the build job is empty (cleaned up in the Docker container) by default.

