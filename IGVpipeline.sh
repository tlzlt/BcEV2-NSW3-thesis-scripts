#!/bin/bash
#SBATCH --job-name=Bowtie2_IGV_Pipeline
#SBATCH --time=1-00:00:00
#SBATCH --partition=day
#SBATCH --ntasks=12
#SBATCH --mem-per-cpu=4000

# ========= editable =========
#Unmapped reads:
#/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/MYCOVIRUSES/TIANLE_2025/IQtree/Onestepback/output
#BcNSW3_UnMap.1.fq.gz & 2

#Original reads:
#/data/group/gendalllab/project/SUSTAINABLE_CROP_PROTECTION_HUB/BOTRYTIS_CINEREA/MYCOVIRUSES_QUANTIFICATION/01B_TRIMMED_READS
#BcNSW3_val_1.fq.gz & 2

FASTQ1=/path/to/sample_1.fq.gz           # 1.fastq1 (fq)
FASTQ2=/path/to/sample_2.fq.gz           # 2.fastq2 (fq)
FASTA_DIR=/path/to/fasta_files           # fasta folder - save the fasta file as .fa
OUTDIR=/path/to/output                   # output folder

# ========== fixed ================
THREADS=96
mkdir -p ${OUTDIR}/intermediate
mkdir -p ${OUTDIR}/IGV_ready

module load Bowtie2/2.4.4-GCC-11.2.0
module load SAMtools/1.13-GCC-11.2.0

echo "==== Pipeline Start at $(date) ===="

for FASTA in ${FASTA_DIR}/*.fa
do
    BASENAME=$(basename ${FASTA} .fa)
    echo ">>> Processing $BASENAME"

    # 1. build index
    bowtie2-build ${FASTA} ${OUTDIR}/intermediate/${BASENAME}.index
    echo "build SAM $(date)"

    # 2. build SAM
    bowtie2 -p ${THREADS} --sensitive \
        -x ${OUTDIR}/intermediate/${BASENAME}.index \
        -1 ${FASTQ1} -2 ${FASTQ2} \
        -S ${OUTDIR}/intermediate/${BASENAME}.sam
    echo "SAM>BAM $(date)"

    # 3. SAM > BAM > sort > BAI
    samtools view -bS ${OUTDIR}/intermediate/${BASENAME}.sam > ${OUTDIR}/intermediate/${BASENAME}.bam
    echo "sort BAM $(date)"
    samtools sort ${OUTDIR}/intermediate/${BASENAME}.bam -o ${OUTDIR}/IGV_ready/${BASENAME}.sorted.bam
    echo "build BAI $(date)"
    samtools index ${OUTDIR}/IGV_ready/${BASENAME}.sorted.bam

    # 4. fasta index
    cp ${FASTA} ${OUTDIR}/IGV_ready/${BASENAME}.fa
    samtools faidx ${OUTDIR}/IGV_ready/${BASENAME}.fa

    echo ">>> Done processing ${BASENAME}"
done

echo "==== Pipeline Finished at $(date) ===="
