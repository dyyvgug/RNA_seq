#!/bin/bash

for i in `seq 10 57`
do
	hisat2 -p 8 -t --dta -x /media/hp/disk1/DYY/reference/index/mouse_mm10/genome_index -1 /media/hp/disk1/DYY/sra_fq_RNAseq/mouse_mm10/experiment3/fastq/SRR76618${i}.sra_1.fastq.gz -2 /media/hp/disk1/DYY/sra_fq_RNAseq/mouse_mm10/experiment3/fastq/SRR76618${i}.sra_2.fastq.gz -S ./SRR76618${i}.sam


done
