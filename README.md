# Introduction

This repository contains definitions for creating various docker container images.

## CentOS-6 Jenkins Slave Containers 

This is for the [Jenkins Docker plugin](https://wiki.jenkins-ci.org/display/JENKINS/Docker+Plugin). It allows a Jenkins build job running on a Docker cloud to execute build steps in a dynamically created Docker container. The files for creating the starting Docker container image is in the folder centos6-jenkins-slave.

## CentOS-6 Swarm Slave Containers

This is for the [Jenkins Swarm Plugin](https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin). It allows a Docker container running the Jenkins Swarm Plugin Client to automatically join a Jenkins build cluster as a Jenkins slave host, making the Jenkins cluster elastic with Docker containers as Jenkins slaves.
