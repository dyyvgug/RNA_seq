#!/bin/bash
mkdir clipper_fastq
cd fq
for item in $(ls *.sra)
do
	echo "clipper_${item%.*}"
	fastx_clipper -a GATCGGAA -l 20 -d 0 -Q 33 -i ./${item%.*}.sra.fastq -o ../clipper_fastq/${item%.*}_tri.fastq
done
