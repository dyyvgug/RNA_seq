#!/bin/bash

for item in $(ls *.bam)
do
	echo "ball_${item%.*}"
	stringtie -e -B -p 16 -G stringtie_merged.gtf -o ballgown/${item%.*}/${item%.*}.gtf ${item%.*}.bam		

done
