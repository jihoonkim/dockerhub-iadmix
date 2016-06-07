###---------------------------------------------------------------------------
#  Get the example input data (.vcf FORMAT)
#
#  FOR YOUR OWN ANALYSIS, REPLACE THE EXAMPLE INPUT WITH YOUR OWN .vcf FILE!
###---------------------------------------------------------------------------
# change a directory 
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

/bin/bash /mydata/workflow.sh /mydata/NA12878_GIAB