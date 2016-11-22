#!/bin/bash 

#-----------------------------------------------------------------------------
#  File name : workflow.sh
#  Author    : Jihoon Kim
#  Last update : 11/22/2016
#  Description : A workflow script for iAdmix docker 
#                    (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency on input .vcf file.
#-----------------------------------------------------------------------------
export INPUT_VCF=$1
export RESOURCE_DATA=$2
export iADMIX_DIR=$3

export OUTPUT_PREFIX=${INPUT_VCF}

### convert .vcf to PLINK format (.ped and .map)
vcftools --vcf ${INPUT_VCF} --plink  --out ${OUTPUT_PREFIX}

### compute population allele frequencies 
python    ${iADMIX_DIR}/runancestry.py  --freq  ${RESOURCE_DATA} \
  --path=${iADMIX_DIR} --plink ${OUTPUT_PREFIX} --out ${OUTPUT_PREFIX} 
