#!/usr/bin/perl

# helps facilitate the applications of multiple filters in-line
# set as teh main vee-filter, and it will apply the stream to the
# set filters in the order listed

use strict;
use warnings;
$|++;

# define filter dir here
my $FILTERDIR = "sample-filters/";

# add new filters to the list - note, they are run in top-down order
# warning - filters are not checked for existence first
my @FILTERS = (
               "$FILTERDIR/vee-filter.sh",
               "$FILTERDIR/vee-filter.pl",
               ,);

#
# automated from here on out - do not touch
#
my $FILTERS = join("|",@FILTERS);
my $out = "";
# loop over STDIN and capture qscript
while (<>) {
  $out .= $_;
}
# open pipe to filters, execute
open(FILTER, "|$FILTERS");
  # send contents of qscript to filters
  print FILTER  $out;
close(FILTER);
