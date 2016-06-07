### set the base image to Ubuntu
FROM ubuntu:16.04

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### update the repository source list and install dependent packages
RUN apt-get install -y git && \
    git clone https://github.com/jihoonkim/dockerhub-iadmix.git && \
    cd docker-hub-admix && \
    bash provision.sh 
