#!/bin/bash

for item in $(ls *.sam)
do
	echo "sam_${item%.*}"		
	
	samtools sort -@ 8 -o ${item%.*}.bam ${item%.*}.sam
	species = $1
	echo "str_${item%.*}"
	stringtie -p 16 -G /media/hp/disk1/DYY/reference/annotation/${species}/ref.gtf -o ./${item%.*}.gtf -l ${item%.*} ${item%.*}.bam

done
