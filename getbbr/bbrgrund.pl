#!/usr/bin/perl
#
# Pick up the husnumber id from BBR::grund
#
use strict;
use LWP::Simple;
use JSON::Parse ':all';
use Getopt::Long;
use JSON;
use DBI;

use lib("../lib");
use dar;
use bbr;

my $platform = "mysql";
my $database = "hb29202_testdata";
my $host     = "mydb16.surf-town.net";
my $username = "hb29202_dba";
my $password = "7q9L6!40";
#$|=1;

my $filename = "testdata02-MU11.csv";
my $output   = "testdata02-MU11-husnummer.csv";

my $result= GetOptions("input=s"=>\$filename,
                   "output=s"=> \$output);

open(BFE,$filename)           or die "Unable to open $filename";
open(my $fh,'>',$output)      or die "Unable to create $output";

my $nr=0;
my $title= "bfenr,grundindeks,antalgrunde,grundid,husnummerid";

printf $fh "%s\n", $title;
while (my $line=<BFE>) {
	chomp($line);
	my ($flag,$bfenr) = split(/,/,$line);
	next if ($flag eq 0);
	my $json   = bbr::grund('BFEnummer', $bfenr);
	next if (!$json);
	#printf "%s\n", JSON->new->pretty->encode($json);
  my $antalgrunde = scalar @{$json};
	$nr++;
	for my $grund  (0..$antalgrunde-1){
		my $id_lokalid  = $json->[$grund]{"id_lokalId"};
		my $husnummerid = $json->[$grund]{"husnummer"};
		my $output = sprintf "%s", join(",",$bfenr,$antalgrunde, $grund+1,$id_lokalid,$husnummerid);
		printf "%5d: %s\n", $nr, $output;
		printf  $fh "%s\n", $output;
	}
}
close  $fh;
