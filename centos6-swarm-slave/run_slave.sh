#!/bin/bash

# Place to store your builds
BUILDS_HOME=/home/jenkins

# Run the slave
launch_slave() {
   pkill -f swarm-client-jar-with-dependencies.jar
   cd $BUILDS_HOME && java -jar ${BUILDS_HOME}/swarm-client-jar-with-dependencies.jar -master $JENKINS_MASTER_URL
   echo Slave started as process $$
}

# Get the necessary application and run the slave
main() {
   launch_slave
}

main
