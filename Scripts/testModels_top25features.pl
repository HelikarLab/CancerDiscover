#!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#The following block of code pulls information from the configuration file
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

use strict;
use warnings;
my $dir1 = '../Train';
my $dir2 = '../Models';
my $dir3 = '../Test';

opendir(DIR, $dir1) or die $!;
while (my $file = readdir(DIR)) {
	# We only want files
	next unless (-f "$dir1/$file");
	# Use a regular expression to find files with specific input string
	next unless ($file =~ m/top25features\_train\.arff/);

	my @partialName = (split /train/, $file);

#The following lines are for testing
my $test = "$dir3/$partialName[0]'test\.arff'" ;
my $train ="$dir1/$file";

if ($Config{NaiveBayes} eq "TRUE"){
system("java -Xmx5G weka.classifiers.bayes.NaiveBayes  -l '$dir2/$partialName[0]'NB.model  -T '$test' > '$dir3/$partialName[0]'NBTest\.out");
}
if ($Config{DecisionTree} eq "TRUE"){ 
system("java -Xmx5G weka.classifiers.trees.J48 -l '$dir2/$partialName[0]'DT.model  -T '$test' > '$dir3/$partialName[0]'DTTest\.out");
}
if ($Config{SupportVectorMachine} eq "TRUE"){
system("java -Xmx5G weka.classifiers.functions.SMO -l '$dir2/$partialName[0]'SVM.model  -T '$test' > '$dir3/$partialName[0]'SVMTest\.out");
}
if ($Config{IBK} eq "TRUE"){
system("java -Xmx5G weka.classifiers.lazy.IBk -l '$dir2/$partialName[0]'IBK.model  -T '$test' > '$dir3/$partialName[0]'IBKTest\.out");
}
if ($Config{RandomForest} eq "TRUE"){
system("java -Xmx5G weka.classifiers.trees.RandomForest -l '$dir2/$partialName[0]'RF.model  -T '$test' >  '$dir3/$partialName[0]'RFTest\.out");
}

#The following lines make .p files
if ($Config{NaiveBayes} eq "TRUE"){
system("java -Xmx5G weka.classifiers.bayes.NaiveBayes  -t '$train' -T '$test' -p 0 > '$dir3/$partialName[0]'NBTest\.p");
}
if ($Config{DecisionTree} eq "TRUE"){
system("java -Xmx5G weka.classifiers.trees.J48 -t '$train' -T '$test' -p 0 > '$dir3/$partialName[0]'DTTest\.p");
}
if ($Config{SupportVectorMachine} eq "TRUE"){
system("java -Xmx5G weka.classifiers.functions.SMO -t '$train' -T '$test' -p 0 > '$dir3/$partialName[0]'SVMTest\.p");
}
if ($Config{IBK} eq "TRUE"){
system("java -Xmx5G weka.classifiers.lazy.IBk  -t '$train' -T '$test' -p 0 > '$dir3/$partialName[0]'IBKTest\.p");
}
if ($Config{RandomForest} eq "TRUE"){
system("java -Xmx5G weka.classifiers.trees.RandomForest -t '$train' -T '$test' -p 0 >  '$dir3/$partialName[0]'RFTest\.p");
}
}
closedir(DIR);
exit 0;
