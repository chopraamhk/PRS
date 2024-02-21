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
#source activate rscript
conda activate rscript 

# Run your R script
Rscript chr_pos_to_rsid.R

