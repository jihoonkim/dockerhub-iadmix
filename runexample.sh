#-----------------------------------------------------------------------------
#  File name : runexample.sh
#  Author    : Jihoon Kim
#  Last update : 06/15/2016
#  Description : Runs a workflow script for iAdmix docker
#                        (https://hub.docker.com/r/j5kim/iadmix)
#                to calculate population allele frequency for an input .vcf.
#                Downloads a real, example .vcf data from NCBI and calls a
#                workflow script, already preloaded in the iadmix docker 
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
#                  /mydata/runinput/run.cfg 
#-----------------------------------------------------------------------------
# make a /mydata directory if not exists.
mkdir -p /mydata

# make two subdirectories, runinput and runoutput, under /mydata
mkdir -p /mydata/runinput
mkdir -p /mydata/runoutput


# download input data, if not exist, for a test run
cd /mydata/runinput
if [ !  -f /mydata/runinput/NA12878_GIAB.vcf ]; then
   # download an example input file (.vcf) from NCBI
   wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/NISTv3.2/supplementaryfiles/NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_all.vcf.gz

   # extract the compressed file 
   gunzip NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_all.vcf.gz

   # change the input file name (just make it short!)
   mv NA12878_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-Solid_ALLCHROM_v3.2_all.vcf NA12878_GIAB.vcf
fi

# create a configuration file for a run
echo -e "export RUN_INPUT_DIR=/mydata/runinput"   >  /mydata/runinput/run.cfg
echo -e "export RUN_OUTPUT_DIR=/mydata/runoutput" >> /mydata/runinput/run.cfg


# run the workflow with the preloaded workflow.sh script
# input is the configuration file for a run
bash /opt/workflow.sh /mydata/runinput/run.cfg

