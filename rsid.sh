#!/bin/bash
#
#SBATCH --job-name="rscript"
#SBATCH -o rscript.o%j
#SBATCH -e rscript.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -n 32
#SBATCH -N 1

# Load any necessary modules
module load R
R
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(version = "3.18")
install.packages("BSgenome_1.70.2.tar.gz", type = "source", repos = NULL)
install.packages("SNPlocs.Hsapiens.dbSNP155.GRCh38_0.99.24.tar.gz", type = "source", repos = NULL)
quit()

# Run your R script
Rscript chr_pos_to_rsid.R

