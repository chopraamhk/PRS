Pipeline: https://2cjenn.github.io/PRS_Pipeline/
Paper: https://www.frontiersin.org/journals/genetics/articles/10.3389/fgene.2022.818574/full
# PRS
The following code is to find the Polygenic risk score in UKB. 

File Requirements:
1. ukb info+maf file
   https://biobank.ctsu.ox.ac.uk/crystal/label.cgi?id=263
   https://biobank.ctsu.ox.ac.uk/crystal/refer.cgi?id=1967
Can be freely downloaded using:  wget  -nd  biobank.ctsu.ox.ac.uk/ukb/ukb/auxdata/ukb_imp_mfi.tgz

2. UKB imputation data (Permission required)
3. SNP List and beta's (i.e., the effect size of variant) for a PRS from the GWAS (base data)

Software tool requirements:
1. bgenix
2. Cat-bgen
3. SQLite
4. PLINK 2.0

