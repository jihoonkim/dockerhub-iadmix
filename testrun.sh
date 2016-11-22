#!/bin/bash

#-----------------------------------------------------------------------------
#  File name : testrun.sh
#  Author    : Jihoon Kim
#  Last update : 11/22/2016
#  Description : A test run script for iAdmix docker 
#                 argument 1:  .vcf file
#                 argument 2:  HapMap population allele frequency file
#                 argument 3:  directory path to a main script, runancestry.py
#-----------------------------------------------------------------------------
bash workflow.sh /testrun/HG001_chr22.vcf /opt/ancestry/hapmap3.8populations.hg19 /opt/ancestry
