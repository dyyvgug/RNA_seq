#!/bin/bash
mkdir ../aligned_ri_mv
for item in $(ls *.fq)
do
	echo "bw_rm_${item%.*}"
	bowtie2 -x ../rRNA/sp_rRNA --un=../aligned_ri_mv/${item%.*}_rmrRNA.fq -U ${item%.*}.fq -p 30 -S ../aligned_ri_mv/${item%.*}_rRNA.sam
	rm ../aligned_ri_mv/${item%.*}_rRNA.sam
done
