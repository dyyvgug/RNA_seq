#!/bin/bash
mkdir ../clipper_quality

for item in $(ls *.fq)
do
	echo "quality_${item%.*}"
	fastq_quality_filter -q 20 -p 80 -Q 33 -i ./${item%.*}.fq -o ../clipper_quality/${item%.*}_qua.fq
done

