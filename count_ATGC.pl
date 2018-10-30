#!/usr/bin/perl
use strict;
use warnings;

my $min=1;
my $size = 20;
my @sample = ("SRR6176430.F");
# put the name of your fastq files in this array. For example, the full file name is SRR123456.fastq, then place SRR123456 in the array. The example is as below. 

foreach my $id (@sample)   {
	print "processing $id now\n\n";
	trim3($id);  }

sub trim3                                                      {
	my ($sam)=@_; 

	my $count=0; my %end; my %gene; 
mkdir $sam;
open (hand1,"$sam.fa") or die $!;
while (<hand1>)                 {
	$_ =~ s/\s+$//;
	$count++;
	my $mod=$count % 2;

if ($mod == 0)  {   
		my $string = $_;        
                my $end=substr($_,0,1);
                $end{$end}++;
                
               
                my $A = () = $string =~ /A/g;
                $gene{"A"}+=$A;

                my $T = () = $string =~ /T/g;
                $gene{"T"}+=$T;
              
                my $G = () = $string =~ /G/g;
                $gene{"G"}+=$G;
             
                my $C = () = $string =~ /C/g;
                $gene{"C"}+=$C;    
       }
            
            }    
	close hand1;
          
            my @nuc =('A', 'T', 'G', 'C');

	open (hand2, ">$sam/nuc_status1.txt");
	print hand2 "nuc\tend\ttotal\n";

      foreach my $i (@nuc) {
	 print hand2 "$i\t$end{$i}\t$gene{$i}\n";
	 }
	close hand2;

    

}
       
    
