#!/bin/bash

for item in $(ls *.sra)
do
        echo "hi_${item%.*}"
        hisat2 -p 30 -t --dta --rna-strandness R --max-intronlen 300000 -x ./index/genome_index -U ./fastq/${item%.*}.sra.fastq.gz -S ./${item%.*}.sam 2>>./mapping_repo.txt

done
