#!/bin/env perl

# test filter that replaces AUBURN with an img tag

while(<STDIN>) {
  chomp;
  if ($_ =~ s/AUBURN/<img src=http:\/\/www.emaspro.com\/Portals\/0\/images\/Logo\%20-\%20Auburn.jpg>/g ) {
  # argv[0] is the name of the formatting function
    if ($ARGV[0] =~ m/groff/) {
      printf("'nf\n%s\n'fi\n",$_); 
    } else {
      printf("%s\n",$_); 
    } 
  } else {
    printf("%s\n",$_); 
  }
}
