#!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0
	
	use strict;
	use warnings;
	
	my $dir1 = '../DataFiles';
	my $dir2 = '../Scripts';
	
	opendir(DIR, $dir1) or die $!;
        while (my $file = readdir(DIR)) {

        #We only want files
        next unless (-f "$dir1/$file");
        # Use a regular expression to find files with specific input string
        next unless ($file =~ m/\_transposed.txt/);

my @partialName = (split /transposed/, $file);

#the following is for making a dataComplete file with the sample names masked
#now add the class column without adding the sample number
system("paste $dir1/$file $dir1/classList.txt > $dir1/tempA");

system("sed -e 's/ /,/g' -e 's/\t/,/g' $dir1/tempA > $dir1/$partialName[0]'dataComplete.txt'");

system("rm $dir1/tempA");

}

           closedir(DIR);
           exit 0;

