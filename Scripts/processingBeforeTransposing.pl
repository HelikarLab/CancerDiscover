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

        # Use a regular expression to find files
        next unless ($file =~ m/ExpressionSet\.txt/);

my @partialName = (split /\./, $file);

#these two lines will make two files from the same input file. One will contain the attributes list to be put in the header of the .arff and the other will contain the data to be transposed in the next step before being placed in the .arff. 
system("awk -F \'\t\' 'NR>=2{print \$1}' $dir1/$file > $dir1/$partialName[0]'\_head.txt'");

system("awk -F \'\t\' 'NR>=2{\$1=\"\"\; print \$0}' $dir1/$file > $dir1/$partialName[0]'\_data.txt'");

#system("cut -d'\t' -f 2- $dir1/$file > $dir1/$partialName[0]'\_data.txt'");

}

closedir(DIR);
    exit 0;

