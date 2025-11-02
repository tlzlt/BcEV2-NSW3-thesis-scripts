#!/bin/bash

#SBATCH --job-name=SPAdes
#SBATCH --time=10:00:00
#SBATCH --partition=day
#SBATCH --ntasks 12
#SBATCH --mem-per-cpu=4000

module load SPAdes

READ1=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/Onestepback/output/BcNSW3_UnMap.1.fq.gz
READ2=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/Onestepback/output/BcNSW3_UnMap.2.fq.gz
TRUSTED=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/SPAdes/Reassemble/TRUSTEDcontig.fasta
OUTDIR=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/SPAdes/Reassemble
THREADS=8
MEM="20"

echo "Starting SPAdes at: $(date)"

######################################################################################################
## Basic command is
## spades.py -1 left.fastq.gz -2 right.fastq.gz -o output_folder
## See e.g. https://github.com/ablab/spades
######################################################################################################

spades.py --rna \
  -1 "$READ1" -2 "$READ2" \
  --trusted-contigs "$TRUSTED" \
  -t "$THREADS" -m "$MEM" \
  -o "$OUTDIR"

echo "Finished SPAdes at: $(date)"
