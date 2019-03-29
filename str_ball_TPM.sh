#!/bin/bash

bash ./stringtie.sh

#Rscript ./mergename.R

#stringtie --merge -p 8 -G /media/hp/disk1/DYY/reference/annotation/Arabidopsis_thaliana/ref.gtf -o stringtie_merged.gtf ./mergelist.txt

#bash ./ballgown.sh

perl ./exTPM_auto.pl ./ gtf
