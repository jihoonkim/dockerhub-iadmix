#-----------------------------------------------------------------------------
#  File name : runexample.sh
#  Author    : Jihoon Kim
#  Last update : 06/15/2016
#  Description : A workflow script for iAdmix docker 
#                    (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency on input .vcf file.
#                /opt     --> a directory for workflow.sh
#                /mydata  --> a directory for a configuration file for a run,
#                             which sets directories for input and output
#-----------------------------------------------------------------------------
### take the run-time configuration file, run.cfg
source $1
shift


export iADMIX_DIR=/opt/iADMIX-v0.2

### for each input .vcf file
for INPUT_VCF in ${RUN_INPUT_DIR}/*.vcf 
do
    # remove both path and file extension, '.vcf'
	INPUT_PREFIX=${INPUT_VCF##*/}
	INPUT_PREFIX=${INPUT_PREFIX%.*}
	OUTPUT_PREFIX=${RUN_OUTPUT_DIR}/${INPUT_PREFIX}

	### If either of PLINK format files, .ped and .map, does NOT exist, 
	###  run vctools to create conversion files from .vcf
	if [ ! -f ${OUTPUT_PREFIX}.ped ] && [ ! -f ${OUTPUT_PREFIX}.map ]; then
	   ### convert vcf to PLINK format (.ped and .map)
	   vcftools --vcf ${INPUT_VCF} --plink  --out ${OUTPUT_PREFIX}
	fi

	### compute population allele frequencies 
	python ${iADMIX_DIR}/runancestry.py               \
	  --freq  ${iADMIX_DIR}/hapmap3.8populations.hg19 \
	  --path=${iADMIX_DIR}                            \
	  --plink ${OUTPUT_PREFIX}       \
	  --out   ${OUTPUT_PREFIX}   

done