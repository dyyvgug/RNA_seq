# RNAseq
step 1: Download SRA files, high-throughput raw sequencing data.
  method one:using the prefetch function of the SRA-tools.
  E.g:
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
