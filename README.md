# dockerhub-iadmix
Docker container for iadmix 

### build a docker container from the latest Dockerfile in Git Hub
docker build -t j5kim/iadmix:latest github.com/jihoonkim/dockerhub-iadmix

### push the built Docker image to Docker Hub
docker login
docker push  j5kim/iadmix:latest 

### test run docker with an example input
docker run -t -i j5kim/iadmix:latest /bin/bash /testrun/testrun.sh

### How to create the example .vcf file for a test run (individual NA12878) 
wget ftp://ftp-trace.ncbi.nlm.nih.gov/giab/ftp/release/NA12878_HG001/NISTv3.3.1/GRCh37/HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.1_highconf_phased.vcf.gz

gunzip HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.1_highconf_phased.vcf.gz

mv HG001_GRCh37_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.1_highconf_phased.vcf HG001.vcf

vcftools --vcf HG001.vcf --chr 22 --recode --out /testrun/HG001_chr22.vcf

### Test run is success if the last line of final ouput, /testrun/HG001_chr22.vcf.INTEGRATION.input.ancestry, has the following allele frequencies
MKK:0.1887 CEU:0.8113 FINAL_NZ_PROPS

### run with a user's own input .vcf data 
docker run -t -i -m 4g -v /Users/JohnDoe/mylocaldirectory:/mydata j5kim/iadmix:latest /bin/bash /workflow/workflow.sh /mydata/my.vcf
