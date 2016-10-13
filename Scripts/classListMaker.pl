   #!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

	use strict;
	use warnings;
   
	my $dir1 = '../DataFiles';
	opendir(DIR, $dir1) or die $!;
     	while (my $file = readdir(DIR)) {
  
       # We only want files
       next unless (-f "$dir1/$file");
   
       # Use a regular expression to find files with sampleList.txt
       next unless ($file =~ m/sampleList\.txt/);


my @partialName = (split /head/, $file);

#this line makes a sorted version of the input file
system("sort $dir1/$file > $dir1/sampleList.temp");

#this line should pull out the class list column from the sampleList.txt file
system("awk -F\",\" \'{print \$2}\' $dir1/sampleList.temp > $dir1/classList\.txt");

#this line pulls out the sample names and modifies them for normalization step later
system("awk -F\",\" \'{print \$1}\' $dir1/sampleList\.temp > $dir1/sampleNames\.temp");
system("tr -s '\n' ',' < $dir1/sampleNames.temp>$dir1/sampleNames.temp2");
system("sed 's/,/\",\"/g' $dir1/sampleNames\.temp2 > $dir1/sampleNames\.temp3");
system("awk '{print substr(\$0, 1, length(\$0)-3)}' $dir1/sampleNames.temp3>$dir1/sampleNames.txt");
#removing temp files
system("rm $dir1/sampleNames.temp $dir1/sampleNames.temp2 $dir1/sampleNames.temp3 $dir1/sampleList.temp");
}

closedir(DIR);
    exit 0;



