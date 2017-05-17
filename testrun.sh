#!/bin/bash

#-----------------------------------------------------------------------------
#  File name : testrun.sh
#  Author    : Jihoon Kim
#  Description : A test run script for iAdmix docker 
#                 argument 1:  .vcf file
#-----------------------------------------------------------------------------
PLINK_PREFIX=HG001_chr22

#convert .vcf to PLINK format (.ped and .map)
vcftools --vcf ${PLINK_PREFIX}.vcf --plink  --out ${PLINK_PREFIX}

# call workflow with an example test input
bash /workflow/workflow.sh ${PLINK_PREFIX}

# an output from the test run
TESTRUN_OUTPUT=${PLINK_PREFIX}.INTEGRATION.input.ancestry 

# "Gold Standard" desired output
DESIRED_OUTPUT="MKK:0.1887 CEU:0.8113 FINAL_NZ_PROPS"

# return 0 if the test run output is equal to the desired output
#        non-zero otherwise
FOUND=`tail -n 1 ${TESTRUN_OUTPUT} | grep -c "${DESIRED_OUTPUT}"`
EXITCODE=$((1 - $FOUND))
exit $EXITCODE