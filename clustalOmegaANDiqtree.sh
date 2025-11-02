#!/bin/bash
#SBATCH --job-name=AgTre.sh
#SBATCH --mail-type=ALL
#SBATCH --mail-user=18771077@students.ltu.edu.au
#SBATCH --cpus-per-task=8
#SBATCH --mem-per-cpu=8000
#SBATCH --time=7-00:00:00
#SBATCH --partition week


cd /data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/119tree/outgroup
DATA=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/119tree/outgroup/outG.fasta

echo "Starting at: $(date)"
 
module load Clustal-Omega/1.2.4-GCC-10.3.0

clustalo -i $DATA -o output.aln --outfmt=clu --force --auto -v --log=clustalomega.log

module load IQ-TREE 

INPUT=/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/119tree/outgroup/output.aln

iqtree2 -s $INPUT -nt AUTO -o NC_016509

echo "Ended at: $(date)"

