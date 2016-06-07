#-----------------------------------------------------------------------------
#  File name : runexample.sh
#  Author    : Jihoon Kim
#  Last update : 06/07/2016
#  Description : A workflow script for iAdmix docker 
#                    (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency on input .vcf file.
#                /opt     --> a directory for workflow.sh
#                /mydata  --> a directory for user data   
#-----------------------------------------------------------------------------
### create an environment variable for sample .vcf file to shorten the input file
export INPUT_PREFIX=$1
export iADMIX_DIR=/opt/iADMIX-v0.2

### convert vcf to PLINK format (.ped and .map)
if [ !  -f ${INPUT_PREFIX}.ped ] && [ ! f ${INPUT_PREFIX}.map ]; then
   vcftools --vcf ${INPUT_PREFIX}.vcf --plink --out ${INPUT_PREFIX}
fi

### compute population allele frequencies 
python ${iADMIX_DIR}/runancestry.py               \
  --freq  ${iADMIX_DIR}/hapmap3.8populations.hg19 \
  --path=${iADMIX_DIR}                            \
  --plink ${INPUT_PREFIX}                         \
  --out   ${INPUT_PREFIX}    