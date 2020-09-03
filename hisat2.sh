#!/bin/bash

# Single-ended sequencing, the first chain specificity.Caenorhabditis elegans.
for item in $(ls *.sra)
do
        echo "hi_${item%.*}"
        hisat2 -p 30 -t --dta --rna-strandness R --max-intronlen 300000 -x ./index/genome_index -U ./fastq/${item%.*}.sra.fastq.gz -S ./${item%.*}.sam 2>>./mapping_repo.txt

done

# Paired-end sequencing, the first strand specificity.Mus musculus.
for item in $(ls *.sra)
do
        echo "hi_${item%.*}"
        hisat2 -p 30 -t --dta --rna-strandness RF -x ./index/genome_index -1 ./fastq/${item%.*}.sra_1.fastq -2 ./fastq/${item%.*}.sra_2.fastq -S ./${item%.*}.sam 2>>./mapping_repo.txt

done
