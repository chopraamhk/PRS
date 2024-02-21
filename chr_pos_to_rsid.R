#!/usr/bin/Rscript
#Load packages
library(BiocManager) #version 1.30.22
library(BSgenome) #version 1.70.2
#library(SNPlocs.Hsapiens.dbSNP155.GRCh38) #if working on Rstudio
library(SNPlocs.Hsapiens.dbSNP150.GRCh38) #if working on conda
#getSNPlocs()
snps <- SNPlocs.Hsapiens.dbSNP150.GRCh38
snps
chr22_snps <- snpsBySeqname(snps, "22") #for 1 chromosome
chr22_snps

#for all the chromosomes
ChromosomesVec = as.character(seq(1, 22, by = 1)) 
all_snps_info = snpsBySeqname(snps, ChromosomesVec)
head(all_snps_info)
all_snps_info
all_snps_info_DF = data.frame(all_snps_info)

#load GWAS data 
gwasData = read.delim("/path/to/gwasfile", header = TRUE)
head(gwasData) #to see the header 

grGWAS_SNPs <- makeGRangesFromDataFrame(
  gwasData, 
  seqnames.field = 'CHR',
  start.field = 'POS',
  end.field = 'POS', 
  keep.extra.columns = TRUE)

head(grGWAS_SNPs)

#find overlaps and save the indices that are overlapped
#qHits gives us query dataframe rows to use, which here is overlapped rows for gwasData
#subHits gives us subject dataframe rows to use, which here is overlapped rows all_snps_info_DF
qHits<- queryHits(findOverlaps(query = grGWAS_SNPs, subject = all_snps_info, type = 'within'))
subHits <- subjectHits(findOverlaps(query = grGWAS_SNPs, subject = all_snps_info, type = 'within'))

#use indices to produce the original data for the overlaps
overlaps <- data.frame(gwasData[qHits,], all_snps_info_DF[subHits,])
head(overlaps)

write.csv(overlaps, "mapped_variants_gwas.csv")
