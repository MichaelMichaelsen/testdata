#!/usr/bin/perl
#
# bbrbygning - fetch bygnings data based on husnumber id
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
$|=1;


my $filename = "testdata02-MU11-husnummer.csv";
my $output   = "testdata02-MU11-husnr-byg.csv";

my $result= GetOptions("input=s"=>\$filename,
                   "output=s"=> \$output);

open(BFE,$filename) or die "Unable to open $filename";
open(my $fh,">",$output) or die "Unable to create $output";
my $title= "bfenr,grundindeks,antalgrunde,grundid,husnummerid,antalbygninger,bygningnr,bygningsid";
printf $fh "%s\n",$title;
my $nr=1;
my $firstlien=<BFE>;
while (my $line=<BFE>) {
	chomp($line);
	my ($bfenr,$grundindeks,$antalgrunde,$grundid,$husnummerid) = split(/,/,$line);
  if ($husnummerid ne "") {
		my $json   = bbr::bygning('husnummer', $husnummerid);
		#printf "%s\n",$bfenr;
		#printf "%s\n", JSON->new->pretty->encode($json);
		if (defined $json) {
			my $antalbygninger = scalar(@{$json});
			for my $bygning (0..$antalbygninger-1) {
				my $bygninglokalid = $json->[$bygning]{"id_lokalId"};
				my $output = sprintf "%s,%d,%d,%s",$line,$antalbygninger,$bygning+1,$bygninglokalid;
		    printf "%6d:%s\n",$nr, $output;
				$nr++;
				printf $fh "%s\n", $output;
			}
		}
		else {
			printf "%6d:%s,,,\n",$nr,$line;
			printf $fh "%s,,,\n",$line;
			$nr++;
		}
	}
	else {
		printf "%6d:%s,,,\n",$nr,$line;
		printf $fh "%s,,,\n",$line;
		$nr++;
	}
}
