#!usr/bin/perl 
use strict;
use warnings;
#程序指定两个参数，第一个参数是指定的文件夹名，每二个参数是指定的扩展名。
die "Usage: $0 <dir> <extion>\n" unless @ARGV == 2;
my $Dir = $ARGV[0] ;
my $Ext = $ARGV[1] ;
opendir(DH, "$Dir") or die "Can't open: $!\n" ;
#读取指定文件夹下面的指定扩展名的文件名，保存到数组里。
my @list = grep {/$Ext$/ && -f "$Dir/$_" } readdir(DH) ;
closedir(DH) ;
chdir($Dir) or die "Can't cd dir: $!\n" ;
foreach my $file (@list){
	open(FH, "$file") or die "Can't open: $!\n" ;
	print "$file:\n" ;
open (hand1, ">$Dir/$file.T");	
while(<FH>){
	chomp;
	if (/transcript_id \"(.+?)\";.+ref_gene_name \"(.+?)\";.+FPKM \"(.+)\";.+TPM \"(.+)\";/)     {

		#print "$1\t$2\t$3\t$4\n";
		my $transcript_id = $1;
		my $gene_name = $2;
		my $fpkm = $3;
		my $tpm = $4;
		print hand1 "$transcript_id\t$gene_name\t$fpkm\t$tpm\n";  }


}
print "\n";
close(FH) ;close(hand1);
} 



