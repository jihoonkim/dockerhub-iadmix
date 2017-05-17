#!/bin/bash 

#-----------------------------------------------------------------------------
#  File name : workflow.sh
#  Author    : Jihoon Kim
#  Description : A workflow script for iAdmix docker 
#                    (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency on input .vcf file.
#                 argument 1:  .vcf file
#-----------------------------------------------------------------------------
export PLINK_PREFIX=$1

# HapMap population allele frequency file
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/hapmap3.8populations.hg19 

### compute population allele frequencies 
python    ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} \
  --path=${iADMIX_DIR} --plink=${PLINK_PREFIX}                  \
  --out=${PLINK_PREFIX} 
