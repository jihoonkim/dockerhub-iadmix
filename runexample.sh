#-----------------------------------------------------------------------------
#  File name : runexample.sh
#  Author    : Jihoon Kim
#  Last update : 06/07/2016
#  Description : Runs a workflow script for iAdmix docker
#                        (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency for an input .vcf.
#                Downloads a real, example .vcf data from NCBI and calls a
#                workflow script, already preloaded in the idadmix docker 
#                above.
# 
#  Note:  FOR YOUR OWN ANALYSIS, REPLACE THE EXAMPLE INPUT WITH YOUR OWN 
#         .vcf FILE!
#
#  Input data: Put the user input in a local host computer directory and
#              mount it during docker run. The workflow is already loaded in
#              the docker at /opt directory. For example, in a host computer,
#              run as
#              $ docker run -t -i -v /Users/JohnDoe/MyDockers/iAdmix:/mydata \
#                  j5kim/iadmix:latest /bin/bash /opt/workflow.sh  \
#                  /mydata/NA12878_GIAB
#-----------------------------------------------------------------------------
# make a /mydata directory if not exists.change a directory 
mkdir -p /mydata

# change a current directory to /mydata
cd /mydata

# download input data for a test run
if [ !  -f /mydata/NA12878_GIAB.vcf ]; then
   # download input data
   curl -O ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/latest/supplementaryfiles/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_all.vcf.gz

   # extract the compressed file 
   gunzip NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_all.vcf.gz

   # change the input file name (just make it short!)
   mv NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_all.vcf NA12878_GIAB.vcf
fi

# run the workflow with the preloaded workflow.sh script
# input is the prefix of the .vcf file without file extension
bash /opt/workflow.sh /mydata/NA12878_GIAB