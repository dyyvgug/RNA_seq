# RNAseq
step 1: Download SRA files, high-throughput raw sequencing data.
  method one:using the prefetch function of the SRA-tools.
  E.g:download SRR3589957-SRR3589965(RNAseq of Homo sapiens 293 cell line)
  
      for i in `seq 57 65`;
      do    
      prefetch SRR35899${i}
      done
  method two:using the FTP protocol.
  E.g:download SRR8077484-SRR8077531(Mus musculus RNAseq)
    
      for i in ` seq 484 531`;
      do
        wget -c -t 0 ftp://ftp-trace.ncbi.nlm.nih.gov/sra/sra-instant/reads/ByStudy/sra/SRP/SRP166/SRP166114/SRR8077${i}     /SRR8077${i}.sra  
      done
  method three:using Entrez Direct package.
  E.g:
  
      esearch -db sra -query SRP091493 | efetch --format runinfo | cut -d ',' -f 1 | grep SRR | xargs fastq-dump --split-files –bzip2
