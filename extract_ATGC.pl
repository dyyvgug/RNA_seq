#!/usr/bin/perl
use strict;
use warnings;
use List::UtilsBy qw(min_by);


=head1
Author:DYY
Date: 2018-9-27
Purpose:Extract sequences that eliminate base deviations.
logic:hash，key=>value;determine the multiple relationship by the smallest number.
usage:RNA sequencing under chain non-specific the conditions,Analyze the number of bases ATGC to eliminate AT or GC preferences.

=cut
 
my @sample = ("SRR6176429.F");
foreach my $id (@sample)   {
	print "processing $id now\n\n";
	select_reads($id);  }


# read statistics, for unstranded sequencing.

sub select_reads  {
	 
	my ($sam) = @_;

	open(hand2, "$sam/nuc_status.txt");
	my %ref; my %stat;
	while (<hand2>)   {
		next if /^nuc/;	
		chomp;
		my @a = split /\t/, $_;
		$ref{$a[0]} = $a[2];
		$stat{$a[0]} = $a[1];
	}
	close hand2;

	my $min_tag = min_by { $ref{$_} } keys %ref;

	my $high; my $low; my @min_nuc;
	if ($min_tag =~ /[GC]/)   {
		@min_nuc = ("G", "C");
		$high = $ref{"A"} + $ref{"T"};
		$low = $ref{"G"} + $ref{"C"};
	}
	else { 
		@min_nuc = ("A", "T");
		$high =$ref{"G"} + $ref{"C"};
		$low =$ref{"A"} + $ref{"T"};
	  }

	my $theoretical_ratio = $high/$low;
	my $total_low;


	foreach my $i (@min_nuc)  {
		$total_low += $stat{$i};  }
	print "$total_low\n";	

	my $n = int($total_low*$theoretical_ratio);
		                                            
	my $count=0; my %end; my %gene; 
	mkdir $sam;
	open (hand1,"$sam.fa") or die $!;
	open (hand3,">$sam\_norm.fa") ;
	my $name;
	while (<hand1>)                 {
		$_ =~ s/\s+$//;
		$count++;
		my $mod=$count % 2;
		if ($mod ==1) {
			$name = $_;}
		if ($mod == 0)  { 
	 
			my $end=substr($_,0,1);
				
			if  ($end=~ /[AT]/) {
				print hand3 "$name\n$_\n";
		      }

			if  ($end=~ /[GC]/ and $n > 0)  {
				print hand3 "$name\n$_\n";
				$n=$n-1; }

			if ($end=~ /[GC]/ and $n <= 0) {
				next }
				 
		      }	
	       }
		        
		close hand1;close hand3;
		  

	}
	       
    

