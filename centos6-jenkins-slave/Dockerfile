FROM centos:centos6
MAINTAINER dan tian "dantian@gmail.com"  
    
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm 
RUN yum -y update  
RUN yum -y install openssh-server supervisor
RUN yum -y install java-1.7.0-openjdk java-1.7.0-openjdk-devel  
RUN export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.65.x86_64 && export PATH=$JAVA_HOME/bin:$PATH

RUN yum -y install sudo git tar unzip bc which lsof
RUN curl -Olv http://mirrors.ibiblio.org/apache/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz
RUN tar -zvxf apache-maven-3.2.3-bin.tar.gz -C /usr/local 
RUN ln -sf /usr/local/apache-maven-3.2.3/bin/mvn /usr/local/bin/mvn

RUN echo "root:password" | chpasswd  
RUN useradd jenkins  
RUN echo "jenkins:jenkins" | chpasswd  
      
RUN mkdir -p /var/run/sshd  
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''  
RUN sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd  
      
RUN mkdir -p /var/run/supervisord -p /var/log/supervisor
ADD supervisord.conf /etc/supervisord.conf  

# Skipped: Add user jenkins ssh key files in ~/jenkins/.ssh 

EXPOSE 22  
CMD ["/usr/bin/supervisord"]  

