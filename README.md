# RNAseq
**tools preparation**

    conda install sra-tools
    conda install fastqc
    conda install fastx_toolkit
    conda install hisat2
    conda install samtools
    

**step 1: Download SRA files, high-throughput raw sequencing data.**
  method one:using the prefetch function of the SRA-tools.
    E.g:download SRR3589957-SRR3589965(RNAseq of *Homo sapiens* 293 cell line)
  
    for i in `seq 57 65`;
    do    
    prefetch SRR35899${i}
    done
  method two:using the FTP protocol.
    E.g:download SRR5422017-SRR5422019(RNAseq of *Saccharomyces cerevisiae*)
    
    for i in `seq 7 9`;
    do
    wget -c -t 0 ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR542/SRR542201${i}/SRR542201${i}.sra	#new
    done
  method three:using Entrez Direct package.
    E.g:download all SRA files under the SRP091493 project number and unzip those SRA file.
  
    $ esearch -db sra -query SRP091493 | efetch --format runinfo | cut -d ',' -f 1 | grep SRR | xargs fastq-dump --split-files –bzip2
   method four:using aspera.
    E.g:all SRA files in file a can be downloaded. File a can be directly accessed by the NCBI project into the accession list option in all runs.
    
    $ prefetch -t ascp -a "/home/user/.aspera/connect/bin/ascp|/home/user/.aspera/connect/etc/asperaweb_id_dsa.openssh" --option-file SRR_Acc_List.txt -O ./
**step 2:Unzip the SRA file and do quality control**

    $ bash SRA-QC.sh
**step 3:Download the genome file and annotation file for the corresponding specie**
Find the corresponding genome in NCBI, copy the download link, and download it directly using the wget command.
  E.g:download genome of *Drosophila_melanogaster*,and the annotation file is gff,the same download method.
  
    $ wget -c -t 0 ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/215/GCF_000001215.4_Release_6_plus_ISO1_MT/GCF_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz
**step 4:Use the mapping tool to build index of the corresponding species genome**
  E.g:Use hisat2 to build an index file for the honeybee genome.
  
    $ hisat2-build /media/hp/disk1/DYY/reference/genome/Apis_mellifera/genome.fa /media/hp/disk1/DYY/reference/index/Apis_mellifera/genome_index
**step 5:Mapping to genome.**
There are many different sequence alignment tools, such as STAR,hisat2,BWA,Tophat,bowtie2...Choose tools according to your needs.
  E.g:using hisat2.
  
    $ bash hisat2.sh
**step 6:Use samtools to convert the sam files generated by the alignment to bam files and sort them. The bam file is passed to the stringtie software for transcript quantification.（sam to sorted_bam,stingtie quantification）**

    $ bash samtools_stringtie.sh
**step 7:If you want to use ballgown to analyze gene expression differences, you need to put the file name of the gtf file into a txt file, separated by \n, that is, the name text must be in one column. You can do this with this R script.**

    $ Rscript mergename.R
**step 8:Use ballgown to read coverage tables,The file generated by ballgown is passed to R for gene expression difference analysis.**

    $ bash ballgown.sh
**step 9:Use the script to extract the TPM and FPKM values of the genes in the gtf file generated by the stringtie calculation.(This script can pass two parameters, the first parameter is the path, and the second parameter is the file extension, which is convenient for batch processing.)**
    
    $ perl exTPM_auto.pl ./ gtf
**step 10:from step 6 to step 8,this shell script can be used directly to process multiple species simultaneously.**
    
    $ bash str_ball_TPMauto.sh
**step 11:




