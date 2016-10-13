#!/usr/bin/perl
        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#Check the Arguments
 if ($#ARGV != 0 ) {
     print "Usage: $0 <ConfigFile>\n";
         exit;
         }

          my $config_file=$ARGV[0];
          my %Config = ();

          # Function to Parse the Environment Variables
          sub parse_config_file {
           	local ($config_line, $Name, $Value, $Config);
           	my ($File, $Config) = @_;
           	open (CONFIG, "$File") or die "ERROR: Config file not found : $File";
           	while (<CONFIG>) {
           		$config_line=$_;
           		chop ($config_line);          # Remove trailling \n
           		$config_line =~ s/^\s*//;     # Remove spaces at the start of the line
           		$config_line =~ s/\s*$//;     # Remove spaces at the end of the line
           		if ( ($config_line !~ /^#/) && ($config_line ne "") ){    # Ignore lines starting with # and blank lines
           			($Name, $Value) = split (/=/, $config_line);          # Split each line into name value pairs
           			$$Config{$Name} = $Value;                             # Create a hash of the name value pairs
           				}
           			}
           	close(CONFIG);
           }
           # Source Env Variables
           parse_config_file ($config_file, \%Config);  # Call the Function to create the Config hash
           #print " $Config{foldNumber}\n";
           #print "Greyson is cool";
	   #print "Script $0 Finished\n";
#This is a script for data partitioning so I don't have to use the weka GUI all the time.
# -N = number of folds
# -F = the fold you want to keep in the output file (Default 1)
# -S = seed number
# -V = true or false, determines if selected fold is kept or if the other folds are kept
# -c = indicates which column contains the class variable

my $dir1 = "../DataFiles";
my $dir2 = "../Train";
my $dir3 = "../Test";

opendir(DIR, $dir1) or die $!;

while (my $file = readdir(DIR)) {
        #We only want files
        next unless (-f "$dir1/$file");
        #Use a regular expression to find files with specific input string
        next unless ($file =~ m/_master\.arff/);
        my @partialName = (split /\_master/, $file); #this line will keep our naming convention from the input file to the output file.

#This line makes a train file. 
system("java -Xmx5G weka.filters.supervised.instance.StratifiedRemoveFolds -i $dir1/$file -o $dir2/$partialName[0]\_train.arff \ -S 1121 -c last -N $Config{foldNumber} -F 1 -V ");
#this linie makes a test file
system("java -Xmx5G weka.filters.supervised.instance.StratifiedRemoveFolds -i $dir1/$file -o $dir3/$partialName[0]\_test.arff \ -S 1121 -c last -N $Config{foldNumber} -F 1 ");

}
closedir (DIR);
exit 0;
