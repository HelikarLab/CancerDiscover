#!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0
        
	 use strict;
         use warnings;
   
  	my $dir1 = '../FeatureSelection/Chunks/ArffPreprocessing';
	opendir(DIR, $dir1) or die $!;
        while (my $file = readdir(DIR)) {
 
        # We only want files
	next unless (-f "$dir1/$file");
        # Use a regular expression to find files with specific input string
        next unless ($file =~ m/\_headComplete\.out/);

#this will split the file names and print only the variable parts (not the messy, long extensions)
my @partialName = (split /head/, $file);
my $header = "$dir1/$file";
my $data = "$dir1/$partialName[0]'dataComplete\.out'";
#print "$header\n";
#print "$data\n";

system("cat ../Scripts/arffTopTwoLines.txt '$dir1/$file' > '$dir1/temp1'" );
my $part1 = 'temp1';
#temp1 has the first two lines of the .arff and the attribute list 

system("cat '$dir1/$part1' ../Scripts/classAndDataLines.txt > '$dir1/temp2'");
my $part2 = 'temp2';
#temp2 now has the line '@attribute class {tumor,normal,etc}' and '@data' added to the bottom 

system("cat '$dir1/$part2' '$data' > $dir1/$partialName[0]'master.arff'");
#temp4 contains the header section and the transposed data complete with the last column identifying class and the first column identifying a sample number and sample name in the second column

system("rm $dir1/temp1 $dir1/temp2");
}                                                                   
           closedir(DIR);
           exit 0;
