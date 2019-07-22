#!/bin/bash
for item in $(ls *.bam)
do
	echo "index_${item%.*}"
	samtools index ${item%.*}.bam
done
