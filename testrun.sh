#!/bin/bash

#-----------------------------------------------------------------------------
#  File name : testrun.sh
#  Author    : Jihoon Kim
#  Description : A test run script for iAdmix docker 
#                 argument 1:  .vcf file
#-----------------------------------------------------------------------------
### convert .vcf to PLINK format (.ped and .map)
vcftools --vcf /testrun/HG001_chr22.vcf  --plink  --out HG001_chr22

# call workflow with an example test input
bash /workflow/workflow.sh HG001_chr22.vcf 

# an output from the test run
TESTRUN_OUTPUT=/testrun/HG001_chr22.vcf.INTEGRATION.input.ancestry 

# "Gold Standard" desired output
DESIRED_OUTPUT="MKK:0.1887 CEU:0.8113 FINAL_NZ_PROPS"

# return 0 if the test run output is equal to the desired output
#        non-zero otherwise
FOUND=`tail -n 1 ${TESTRUN_OUTPUT} | grep -c "${DESIRED_OUTPUT}"`
EXITCODE=$((1 - $FOUND))
exit $EXITCODE