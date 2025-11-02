#!/bin/bash

#SBATCH --job-name=Trinitystrict
#SBATCH --time=7-00:00:00
#SBATCH --partition=week
#SBATCH --ntasks 48
#SBATCH --mem-per-cpu=4000

module load Trinity/2.12.0-foss-2020b

INPUT=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/Onestepback/output

## OR could define the file prefix in this example as e.g. DATA=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/BOTRYTIS_CINEREA/RNASeq/BC8742-LFD2731_L3, then modify script to included --left as ${DATA}_1.fq.gz and --right as ${DATA}_2.fq.gz etc.

## OUTDIR must must contain the word 'trinity' as a safety precaution, given that auto-deletion can take place.
OUTDIR=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/TrinityAssemble/strict

echo "Starting Trinity at: $(date)"

######################################################################################################
## Basic command is
## Trinity --seqType fq --left reads_1.fq --right reads_2.fq --CPU 6 --max_memory 20G 
## See e.g. https://github.com/trinityrnaseq/trinityrnaseq/wiki/Running-Trinity
######################################################################################################

######################################################################################################
## The example below does a combined assembly of 1 set of paired reads. If you want to combine reads from different samples you can specify a sample.txt file that lists files. IF you want to generate different aseemblies from multiple samples, I think it is better to run as two/many separate jobs, so both can run in parallel.
######################################################################################################

#--full_cleanup 
#.1.fq is left, .2. is right!
# run:  dos2unix Trinity2_Demo_Max_Mem.sh  first!


mkdir -p $OUTDIR
Trinity --seqType fq --max_memory 192G --CPU 48 --left ${INPUT}/BcNSW3_UnMap.2.fq  --right ${INPUT}/BcNSW3_UnMap.1.fq --min_kmer_cov 2 --output $OUTDIR

echo "Finished Trinity at: $(date)"
