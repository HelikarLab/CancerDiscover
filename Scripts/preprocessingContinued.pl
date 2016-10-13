#!/usr/bin/perl
        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#the purpose of this scirpt is to take the _head.txt files and add @attribute to the beginning of each line, and numeric to the end of each line for arff preprocessing
	use strict;
	use warnings;
   
	my $dir1 = '../DataFiles';
	opendir(DIR, $dir1) or die $!;
     	while (my $file = readdir(DIR)) {
  
       # We only want files
       next unless (-f "$dir1/$file");
   
       # Use a regular expression to find files with _top
       next unless ($file =~ m/\_head\.txt/);


my @partialName = (split /head/, $file);

#this line should add @attribute to the beginning of each line in the *_head.txt files
system("awk '{print \"\@attribute \" \$0 \" numeric\";}' $dir1/$file > $dir1/$partialName[0]'headComplete.txt'");

}

closedir(DIR);
    exit 0;



