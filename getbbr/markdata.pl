#!/usr/bin/perl
#
# Pick up the husnumber id from BBR::grund
#
use strict;


while (my $line=<>) {
	chomp($line);
  printf "1,%s\n",$line;
}
