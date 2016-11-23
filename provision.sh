#!/bin/bash

#-----------------------------------------------------------------------------
#  File name : provision.sh
#  Author    : Jihoon Kim
#  Last update : 11/22/2016
#  Description : Proviosions iAdmix docker
#                        (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency for an input .vcf.
#-----------------------------------------------------------------------------
### update the repository source list 
apt-get update -y 

### install dependent packages
apt-get install -y  autoconf build-essential git g++ libncurses5-dev \
 libssl-dev make pkg-config software-properties-common python vim \
 wget zip zlibc zlib1g zlib1g-dev 

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
git clone https://github.com/vibansal/ancestry.git
cd ancestry
make all


### download resource data, the population allele frequencies for common SNPs
###  from the International HapMap project (ftp://ftp.ncbi.nlm.nih.gov/hapmap)
cd /opt/ancestry
wget https://sites.google.com/site/vibansal/software/iAdmix/hapmap3.8populations.hg19.zip 
unzip hapmap3.8populations.hg19.zip
rm hapmap3.8populations.hg19.zip


### make a directory for workflow and download a workflow script
mkdir -p /workflow 
cd /workflow
wget https://raw.githubusercontent.com/jihoonkim/dockerhub-iadmix/master/workflow.sh
chmod a+x workflow.sh

### make a directory for a test run
mkdir -p /testrun 
cd /testrun
# download a subset, chr22 only, of a public whole genome sequencing file
# How the subset file was created using vcftools (https://vcftools.github.io)  
# wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/NISTv3.3.1/GRCh37/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.1_highconf_phased.vcf.gz
# gunzip HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.1_highconf_phased.vcf.gz
# mv HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.1_highconf_phased.vcf HG001.vcf
# vcftools --vcf HG001.vcf --chr 22 --recode --out HG001_chr22.vcf
wget https://raw.githubusercontent.com/jihoonkim/dockerhub-iadmix/master/HG001_chr22.vcf.gz
gunzip HG001_chr22.vcf.gz
wget https://raw.githubusercontent.com/jihoonkim/dockerhub-iadmix/master/testrun.sh
chmod a+x testrun.sh

### make a directory for a user run
mkdir -p /mydata 