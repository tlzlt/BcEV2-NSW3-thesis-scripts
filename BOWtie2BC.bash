#!/bin/bash

#SBATCH --job-name=TianleBOWTIE2_1
#SBATCH --time=7-00:00:00
#SBATCH --partition=week
#SBATCH --ntasks=96
#SBATCH --mem-per-cpu=4000

module load Bowtie2/2.4.4-GCC-11.2.0
READS=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/BOTRYTIS_CINEREA/MYCOVIRUSES_QUANTIFICATION/01B_TRIMMED_READS
INDEX=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/BOTRYTIS_CINEREA/GENOMES/GCF_000143535.2_ASM14353v4/Bc_05_10_BOWTIE_indexes
OUTPUT=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/Onestepback/output

echo "Starting Bowtie at: $(date)"

## CHANGE the --very-fast option accordingly
## See  https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml
    


bowtie2 -p 96 --sensitive -x ${INDEX}/GCF_000143535.2_ASM14353v4_rna.fna \
-1 ${READS}/BcNSW3_val_1.fq.gz \
-2 ${READS}/BcNSW3_val_2.fq.gz \
-S --un-conc ${OUTPUT}/BcNSW3_UnMap.fq

