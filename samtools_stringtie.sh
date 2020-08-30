#!/bin/bash

for item in $(ls *.sam)
do
        echo "sam_${item%.*}"
        samtools sort -@ 8 -o ${item%.*}.bam ${item%.*}.sam

        echo "str_${item%.*}"
        stringtie -p 30 --rf -G ./ref.gff -o ./${item%.*}.gtf -l ${item%.*} ${item%.*}.bam -A ${item%.*}_abund.out

done
