#!/bin/bash

#-----------------------------------------------------------------------------
#  File name : testrun.sh
#  Author    : Jihoon Kim
#  Last update : 11/22/2016
#  Description : A test run script for iAdmix docker 
#                 argument 1:  .vcf file
#                 argument 2:  HapMap population allele frequency file
#-----------------------------------------------------------------------------
# call workflow with an example test input
bash /workflow/workflow.sh /testrun/HG001_chr22.vcf /opt/ancestry/hapmap3.8populations.hg19 

# an output from the test run
TESTRUN_OUTPUT=${OUTPUT_PREFIX}.INTEGRATION.input.ancestry 

# "Gold Standard" desired output
DESIRED_OUTPUT="MKK:0.1887 CEU:0.8113 FINAL_NZ_PROPS"

# return 0 if the test run output is equal to the desired output
#        non-zero otherwise
FOUND=`tail -n 1 ${TESTRUN_OUTPUT} | grep -c "${DESIRED_OUTPUT}"`
EXITCODE=$((1 - $FOUND))
exit $EXITCODE