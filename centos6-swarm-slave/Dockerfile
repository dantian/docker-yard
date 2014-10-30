FROM centos:centos6
MAINTAINER dan tian "dantian@gmail.com"  
    
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 
RUN yum -y update  
RUN yum -y install openssh-server  
RUN yum -y install supervisor  
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel  
RUN yum -y install git rpm-build 
RUN yum -y install sudo tar unzip bc which lsof
RUN yum -y install ccache gcc gcc-c++ perl perl-devel curl-devel 

# Install Apache Maven

RUN curl -Olv http://mirrors.ibiblio.org/apache/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
RUN tar -zvxf apache-maven-3.2.3-bin.tar.gz -C /usr/local 
RUN ln -sf /usr/local/apache-maven-3.2.3/bin/mvn /usr/local/bin/mvn


# Install Node.js (Ref: https://registry.hub.docker.com/u/dockerfile/nodejs/dockerfile/)

RUN \
  pushd /tmp && \
  curl -O http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  rm -rf node-v* && \
  echo '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc && \
  popd

RUN echo "root:password" | chpasswd  
RUN useradd jenkins  
RUN echo "jenkins:jenkins" | chpasswd  
      
RUN mkdir -p /var/run/sshd  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''  
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd  

      
RUN mkdir -p /var/run/supervisord -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf  

RUN groupadd docker || true
RUN gpasswd -a jenkins docker

# install swarm-client for jenkins swarm plugin https://wiki.jenkins-ci.org/display/JENKINS/Swarm+Plugin

RUN curl -L -o ~jenkins/swarm-client-jar-with-dependencies.jar http://maven.jenkins-ci.org/content/repositories/releases/org/jenkins-ci/plugins/swarm-client/1.20/swarm-client-1.20-jar-with-dependencies.jar

# The complete target Jenkins URL like 'http://server:8080/jenkins/'. If this option exist, auto-discovery will be skipped
# Overide the settings when starting a container with docker run --env JENKINS_MASTER_URL=<value>

ENV JENKINS_MASTER_URL http://server:8080/jenkins/

ADD run_slave.sh /usr/bin/run_slave.sh

RUN chmod +x /usr/bin/run_slave.sh

EXPOSE 22  
CMD ["/usr/bin/supervisord"]  
