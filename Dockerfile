### set the base image to Ubuntu
FROM ubuntu:16.04

### File author / maintainer
MAINTAINER Jihoon Kim "j5kim@ucsd.edu"

### update the repository source list and install dependent packages
RUN apt-get update -y && apt-get install -y  autoconf build-essential git \
  g++ libncurses5-dev libssl-dev make pkg-config software-properties-common \
  python wget zip zlibc zlib1g zlib1g-dev && mkdir /mydata

### install vcftools to convert .vcf to PLINK format file
RUN wget https://github.com/vcftools/vcftools/tarball/master &&  \
    git clone https://github.com/vcftools/vcftools.git &&        \
    cd vcftools &&  ./autogen.sh && ./configure  && make && make install

### install iADMIX to compute population allele frequencies
RUN cd /opt && \
wget https://sites.google.com/site/vibansal/software/iAdmix/iADMIX-v0.2.zip && \
unzip iADMIX-v0.2.zip && cd /opt/iADMIX-v0.2 && \
wget https://sites.google.com/site/vibansal/software/iAdmix/hapmap3.8populations.hg19.zip && \
unzip hapmap3.8populations.hg19.zip && rm hapmap3.8populations.hg19.zip