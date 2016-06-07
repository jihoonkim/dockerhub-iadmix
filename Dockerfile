### set the base image to Ubuntu
FROM ubuntu:16.04

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### update the repository source list and install dependent packages
RUN apt-get update -y  && apt-get install -y git &&  cd /opt \
    git clone https://github.com/jihoonkim/dockerhub-iadmix.git && \
    cd dockerhub-iadmix && \
    bash provision.sh 
