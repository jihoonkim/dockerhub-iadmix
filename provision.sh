#!/bin/bash

#-----------------------------------------------------------------------------
#  File name : provision.sh
#  Author    : Jihoon Kim
#  Last update : 06/07/2016
#  Description : Proviosions iAdmix docker
#                        (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency for an input .vcf.
# 
#-----------------------------------------------------------------------------


### update the repository source list 
apt-get update -y 

### install dependent packages
apt-get install -y  autoconf build-essential git g++ libncurses5-dev \
 libssl-dev make pkg-config software-properties-common python wget zip zlibc \
 zlib1g zlib1g-dev 

### install vcftools to convert .vcf to PLINK format file
cd /opt
git clone https://github.com/vcftools/vcftools.git 
cd vcftools
./autogen.sh 
./configure 
make 
make install


### install iADMIX to compute population allele frequencies
cd /opt 
wget https://sites.google.com/site/vibansal/software/iAdmix/iADMIX-v0.2.zip 
unzip iADMIX-v0.2.zip 
cd /opt/iADMIX-v0.2
wget https://sites.google.com/site/vibansal/software/iAdmix/hapmap3.8populations.hg19.zip 
unzip hapmap3.8populations.hg19.zip
rm hapmap3.8populations.hg19.zip


### make a directory for user data
mkdir -p /mydata 

### CLEAN-UP
###    move workflow.sh and runexample.sh to /opt directory
mv /opt/dockerhub-iadmix/runexample.sh /opt
mv /opt/dockerhub-iadmix/workflow.sh /opt

### CLEAN-UP
###    remove docker files
rm /opt/dockerhub-iadmix/Dockerfile