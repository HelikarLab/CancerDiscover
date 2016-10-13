#!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

	use strict;
	use warnings;

my $dir2 = '../DataFiles';
	opendir(DIR, $dir2) or die $!;

	while (my $file = readdir(DIR)) {

	#We only want files
	next unless (-f "$dir2/$file");
	#Use a regular expression to find files with specific input string
	next unless ($file =~ m/\_data\.txt/);

my @partialName = (split /data/, $file);

system("awk -F\" \" '
{
    for (i=1; i<=NF; i++)  {
        a[NR,i] = \$i
    }
}
NF>p { p = NF }
END {
    for(j=1; j<=p; j++) {
        str=a[1,j]
        for(i=2; i<=NR; i++){
            str=str\",\"a[i,j];
        }
        print str
    }

}' $dir2/$file > $dir2/$partialName[0]'transposed.txt'" );

}

           closedir(DIR);
           exit 0;


