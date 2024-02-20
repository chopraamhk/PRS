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

#changing variant id to chr:pos and saving a table using write.table function in R. As in GTEx files, we already do not have variant rsid's.
```{r}
gwas_vsmc1$SNP <- paste0("chr", gwas_vsmc1$CHR, ":", gwas_vsmc1$POS)
gwas_vsmc2$SNP <- paste0("chr", gwas_vsmc2$CHR, ":", gwas_vsmc2$POS)
```
```{r}
write.table(gwas_vsmc1, file = "/home/mchopra/Documents/PhD-Year1/GTEx_GWAS/Stats_VSMC_I_chr_snp.org.fastGWA", sep = "\t", quote = FALSE , row.names = FALSE)
write.table(gwas_vsmc2, file = "/home/mchopra/Documents/PhD-Year1/GTEx_GWAS/Stats_VSMC_II_chr_snp.org.fastGWA", sep = "\t", quote = FALSE , row.names = FALSE)
```
#To save chr:pos id's in a file 
```
awk -F, '{ if (NR>1) { print $2 }}' Stats_VSMC_I_chr_snp.org.fastGWA > chrposlist_VSMCI.txt
awk -F, '{ if (NR>1) { print $2 }}' Stats_VSMC_II_chr_snp.org.fastGWA > chrposlist_VSMCII.txt
```
#As the UKB imputed files are in built hg37 and GTEx GWAS snps are in built hg38; Lifting over is required. Liftover from GTEx GWAS SNPs (hg38) to hg37/19 built. 
#Tool: crossmap 
#At first, do the crossmap and from there split it into snps_37.txt and chrpos_37.txt
#To perform the lifting over we do need "chr" in file, for that the below awk command would be helpful. 
```
awk '{print "chr"$0}' chrposlist_VSMCII.txt > chrposlist_VSMCII
```
The instructions can be followed from here https://pythonhosted.org/CrossMap/
```
CrossMap.py bed hg38ToHg19.over.chain.gz chrposlist_VSMCI.bed chrposlist37_VSMC1.bed
```
#for getting the snp id's
```
https://lh3lh3.users.sourceforge.net/ucsc-mysql.shtml
```
