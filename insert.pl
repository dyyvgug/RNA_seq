#！usr/bin/perl -w
use strict;

my @species = ( "Asteroidea（Starfish）","Branchiostoma_lanceolatum","C_elegans_Ensl_WBcel235","Chlorella","Chlorella_vulgaris","Ciona_intestinalis","Danio_rerio（zebrafish）","Drosophila_melanogaster","hg19","Hydrozoa","Leptolyngbya_ohadii","mouse_mm10","Mycobacterium_tuberculosis_H37RV_NCBI_2001-09-07","NC10","Physcomitrella_patens","Pristionchus_pacificus","Rhodobacter_sphaeroides_2.4.1","Schistosoma_japonicum","Schizosaccharomyces_pombe","Strongylocentrotus_purpuratus"); my $n = <*.gff>;


foreach my $species (@species)  { 
	open (REF, "/media/hp/disk1/DYY/reference/annotation/$species/$n") or die $!;
	open (output, ">/media/hp/disk1/DYY/reference/annotation/$species/ref1.txt");

	while (<REF>)  	{
			chomp;                                                    
	   		my @a = split;                                     
		        my $column2 = $a[0];
		        print output "$column2\t$_\n"; }

close REF; close output;

}











