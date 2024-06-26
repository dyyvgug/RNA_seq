#!/bin/bash
#SBATCH -J pipeline
#SBATCH -N 1
#SBATCH --ntasks-per-node=30
#SBATCH --mem=30G
#SBATCH -o rna-seq.out
#SBATCH -e rna-seq.err

for item in $(ls *.sra)
do
	echo "sra_${item%.*}"
	fastq-dump --gzip --split-3 -O ./fastq/ -A ${item%.*}.sra
done

cd ./fastq/
fastqc ./*
multiqc ./*
gzip -d *.gz
rename 's/fastq/fq/g' *.fastq

mkdir ../clipper_quality
# remove quality score less than 20
for item in $(ls *.fq)
do
	echo "quality_${item%.*}"
	fastq_quality_filter -q 20 -p 80 -Q 33 -i ./${item%.*}.fq -o ../clipper_quality/${item%.*}_qua.fq
done

cd ..
mkdir ./aligned
# Paired-end sequencing, the first strand specificity.Mus musculus.
for item in $(ls *.sra)
do
        echo "hi_${item%.*}"
        hisat2 -p 30 -t --dta --rna-strandness RF -x /proj/y.dong/genome/$1/index/genome_index -1 ./clipper_quality/${item%.*}.sra_1_qua.fq -2 ./clipper_quality/${item%.*}.sra_2_qua.fq -S ./aligned/${item%.*}.sam 2>>./mapping_repo.txt

done

# Single-end sequencing
#for item in $(ls *.sra)
#do
#        echo "hi_${item%.*}"
#        hisat2 -p 30 -t --dta --rna-strandness R -x /proj/y.dong/genome/$1/index/genome_index -U ./clipper_quality/${item%.*}.sra_qua.fq -S ./aligned/${item%.*}.sam 2>>./mapping_repo.txt
#done

cd ./aligned
for item in $(ls *.sam)
do
        echo "sam_${item%.*}"
	samtools view -b -@ 30 -o ${item%.*}.bam ${item%.*}.sam
	samtools flagstat ${item%.*}.bam > ${item%.*}.bam.flag
	samtools sort -@ 30 -o ${item%.*}_sort.bam ${item%.*}.bam
done


for item in $(ls *.sam)
do
        echo "str_${item%.*}"
        stringtie -p 30 --rf -G /proj/y.dong/genome/$1/genomic.gff -o ./${item%.*}.gtf -l ${item%.*} ${item%.*}_sort.bam -A ${item%.*}_abund.out

done


ls *.gtf > mergelist.txt
stringtie --merge -p 30 -G /proj/y.dong/genome/$1/genomic.gff -o stringtie_merged.gtf mergelist.txt


#mkdir ./ballgown
#for item in $(ls *.bam)
#do
#	echo "ball_${item%.*}"
#	stringtie -e -B -p 30 -G stringtie_merged.gtf -o ./ballgown/${item%.*}/${item%.*}.gtf ${item%.*}.bam
#done

# Set fixed directory and extension
Dir="./"
Ext="gtf"

# Navigate to the specified directory
cd "$Dir" || { echo "Cannot change directory to $Dir"; exit 1; }

# List files with the specified extension
for file in *"$Ext"; do
    # Check if the file exists
    if [ -f "$file" ]; then
        echo "$file:"

        # Define the output file
        output_file="${file}.T"

        # Process the file and extract required values
        awk '
        BEGIN { OFS="\t" }
        /transcript_id/ && /ref_gene_name/ && /FPKM/ && /TPM/ {
            match($0, /transcript_id "([^"]+)";.+ref_gene_name "([^"]+)";.+FPKM "([^"]+)";.+TPM "([^"]+)";/, arr)
            print arr[1], arr[2], arr[3], arr[4]
        }' "$file" > "$output_file"

        echo "Processed and saved to $output_file"
    else
        echo "No files with extension $Ext found in $Dir"
    fi
done

echo "Processing complete."
