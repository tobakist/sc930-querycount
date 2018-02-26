#!/usr/bin/perl

# Find all queries in Ingres SC930 trace files,
# and group them by how many times they appear
# Tested with 10.2
#
# Run as "sc930-querycount.pl | sort -r -n"

# Thomas Johansson, 2018-02-26

use strict;
use warnings;

# Set to your directory
my $tracefiledir = "/srv/trace";

my @tracefiles = glob("$tracefiledir/sess*");

my @querylist;

for (@tracefiles) {
  my $datafile = $_;
  open(FH, "<$datafile") or die("Cannot open file\n");
  while(<FH>) {
    chomp();
    if($_ =~ /^QRY:(\d+)\/\d+\?(.*)/) {
      my $epoch = $1;
      my $query = $2;
      # Do stuff with $epoch if you feel like it
      push(@querylist, "$query");
    };
  };
  close(FH);
};

my %counter;
for (@querylist) {
  $counter{$_}++;
};

foreach my $keys (keys %counter) {
  print("$counter{$keys} : $keys\n");
};
