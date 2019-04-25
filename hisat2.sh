#!/bin/bash

cd /media/hp/disk1/DYY/sra_fq_RNAseq/Bacillus_subtilis/experiment1
for item in $(ls *.sra)
do
	echo "hi_${item%.*}"
	hisat2 -p 16 -t --dta -x /media/hp/disk1/DYY/reference/index/Bacillus_subtilis/genome_index 
	-U /media/hp/disk1/DYY/sra_fq_RNAseq/Bacillus_subtilis/fastq/${item%.*}.sra.fastq.gz 
	-S /media/hp/Katniss/DYY/aligned/Bacillus_subtilis/experiment1/${item%.*}.sam 
	2>>/media/hp/Katniss/DYY/aligned/Bacillus_subtilis/experiment1/mapping_repo.txt
	
done
