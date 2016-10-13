#!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#the purpose of this scirpt is to take the classList.txt file and pull out the class information for the @attribute class {} line.
	use strict;
	use warnings;
   
	my $dir1 = '../DataFiles';
	my $dir2 = '../Scripts';
	opendir(DIR, $dir1) or die $!;
     	while (my $file = readdir(DIR)) {
  
       # We only want files
       next unless (-f "$dir1/$file");
   
       # Use a regular expression to find files with sampleList.txt
       next unless ($file =~ m/classList\.txt/);


my @partialName = (split /head/, $file);

#this line identifies all of the unique enties of the input file
system("uniq $dir1/$file > $dir1/classLine.temp");

#this line pulls out the sample names and modifies them for normalization step later
system("tr -s '\n' ',' < $dir1/classLine.temp>$dir1/classLine.temp2");
system("awk '{print substr(\$0, 1, length(\$0)-1)}' $dir1/classLine.temp2>$dir1/classLine.temp3");
system("awk '{print \"\@attribute class {\" \$0 \"}\"}' $dir1/classLine.temp3 > $dir1/classLine.temp4");
system("cat $dir1/classLine.temp4 $dir2/dataLine.txt > classAndDataLines.txt");

#removing temp files
system("rm $dir1/classLine.temp $dir1/classLine.temp2 $dir1/classLine.temp3 $dir1/classLine.temp4");
}

closedir(DIR);
    exit 0;



