#!/bin/bash

for item in $(ls *.sra)
do
	echo "QC_${item%.*}"	
	fastq-dump --gzip --split-3 -O ./fastq/ -A ${item%.*}.sra
done

#Batch quality control
cd ./fastq/
fastqc ./*
multiqc ./*

