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
	next unless ($file =~ m/top10pc\_train\.arff/);

	my @partialName = (split /train/, $file);

#The following lines are for training and model creation
system("grep '^[0-9]' $dir1/$file > ../Temp/sampleCount.temp");
#my $sampleCount2=(`perl -lne "END {print  $. }" ../Temp/sampleCount.temp`);
my $sampleCount2=`wc -l ../Temp/sampleCount.temp|awk '{print \$1}' `;
#print "GREYSON the sample count is $sampleCount2 \n\n";

if ($Config{NaiveBayes} eq "TRUE"){
if ($sampleCount2 < 12) {
system("java -Xmx5G weka.classifiers.bayes.NaiveBayes -t '$dir1/$file' -d '$dir2/$partialName[0]'NB.model -x 2 > '$dir1/$partialName[0]'NBtrain\.out");
} else {
system("java -Xmx5G weka.classifiers.bayes.NaiveBayes -t '$dir1/$file' -d '$dir2/$partialName[0]'NB.model -x 10 > '$dir1/$partialName[0]'NBtrain\.out");
}}

if ($Config{DecisionTree} eq "TRUE"){
if ($sampleCount2 < 12) {
system("java -Xmx5G weka.classifiers.trees.J48 -t '$dir1/$file' -d '$dir2/$partialName[0]'DT.model -x 2 > '$dir1/$partialName[0]'DTtrain\.out");
} else {
system("java -Xmx5G weka.classifiers.trees.J48 -t '$dir1/$file' -d '$dir2/$partialName[0]'DT.model -x 10 > '$dir1/$partialName[0]'DTtrain\.out");
}}

if ($Config{SupportVectorMachine} eq "TRUE"){
if ($sampleCount2 < 12) {
system("java -Xmx5G weka.classifiers.functions.SMO -t '$dir1/$file' -d '$dir2/$partialName[0]'SVM.model -x 2 > '$dir1/$partialName[0]'SVMtrain\.out");
} else {
system("java -Xmx5G weka.classifiers.functions.SMO -t '$dir1/$file' -d '$dir2/$partialName[0]'SVM.model -x 10 > '$dir1/$partialName[0]'SVMtrain\.out");
}}

if ($Config{IBK} eq "TRUE"){
if ($sampleCount2 < 12) {
system("java -Xmx5G weka.classifiers.lazy.IBk -t '$dir1/$file' -d '$dir2/$partialName[0]'IBK.model -x 2 > '$dir1/$partialName[0]'IBKtrain\.out");
} else {
system("java -Xmx5G weka.classifiers.lazy.IBk -t '$dir1/$file' -d '$dir2/$partialName[0]'IBK.model -x 10 > '$dir1/$partialName[0]'IBKtrain\.out");
}}

if ($Config{RandomForest} eq "TRUE"){
if ($sampleCount2 < 12) {
system("java -Xmx5G weka.classifiers.trees.RandomForest -t '$dir1/$file' -d '$dir2/$partialName[0]'RF.model -x 2 >  '$dir1/$partialName[0]'RFtrain\.out"); 
} else {
system("java -Xmx5G weka.classifiers.trees.RandomForest -t '$dir1/$file' -d '$dir2/$partialName[0]'RF.model -x 10 >  '$dir1/$partialName[0]'RFtrain\.out");
}}

}
closedir(DIR);
exit 0;
