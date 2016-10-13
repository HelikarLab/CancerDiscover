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
#use strict;
use warnings;

#In order to save time by renaiming input files for all instances I have made a variable aliases below

my $dir1 = '../Train';
my $dir2 = '../FeatureSelection';
my $dir3 = '../Test';

opendir(DIR, $dir1) or die $!;
while (my $file = readdir(DIR)) {
        #We only want files
	next unless (-f "$dir1/$file");
        #Use a regular expression to find files with specific input string
	next unless ($file =~ m/ExpressionSet\_train\.arff/);
        
        my @partialName = (split /train/, $file);


# Cfs Subset Evaluator + Best first
if ($Config{cfsSubsetEvaluatorBestFirst} eq "TRUE") {
system("java -Xss5G -Xmx45G weka.attributeSelection.CfsSubsetEval -s \"weka.attributeSelection.BestFirst -D 1 -N 5\" -i $dir1/$file &> $dir2/$partialName[0]'1.txt' ");
# Cfs Subset Evaluator + Genetic Search
} if ($Config{cfsSubsetEvaluatorGeneticSearch} eq "TRUE") {
system(" java -Xmx25G  weka.attributeSelection.CfsSubsetEval -s \"weka.attributeSelection.GeneticSearch -Z 20 -G 20 -C 0.6 -M 0.033 -R 20 -S 1\" -i $dir1/$file &> $dir2/$partialName[0]'2.txt' ");
}
# Cfs Subset Evaluator + Greedy Stepwise
if ($Config{cfsSubsetEvaluatorGreedyStepwise} eq "TRUE") {
system(" java -Xmx15G weka.attributeSelection.CfsSubsetEval -s \"weka.attributeSelection.GreedyStepwise -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'3.txt' ");
}
# Cfs Subset Evaluator + Linear Forward Selection
if ($Config{cfsSubsetEvaluatorLinearForwardSelection} eq "TRUE"){
system(" java -Xmx15G weka.attributeSelection.CfsSubsetEval -s \"weka.attributeSelection.LinearForwardSelection -D 0 -N 5 -I -K 50 -T 0\" -i $dir1/$file &> $dir2/$partialName[0]'4.txt' ");
}
# Cfs Subset Evaluator + Rank Search
#I'm not sure this line is working
#if ($Config{cfsSubsetEvaluatorRankSearch} eq "TRUE") {
#system(" java -Xmx15G weka.attributeSelection.CfsSubsetEval -s \"weka.attributeSelection.RankSearch -S 1 -R 0 -A weka.attributeSelection.GainRatioAttributeEval -- -M\" -i $dir1/$file &> $dir2/$partialName[0]'29.txt' ");
#}
# Cfs Subset Evaluator + Subset Size Forward Selection
#HELP# 
#if ($Config{cfsSubsetEvaluatorSubsetSizeForwardSelection} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.SubsetSizeForwardSelection -I -K 50 -T 0 -F 5 -S 1 -Z false -E weka.attributeSelection.ClassifierSubsetEval -- -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff -i $dir1/$file &> $dir2/$partialName[0]'33.txt' ");
#}
#Attribute Evaluator: Chi Squared Attribute Evaluator
#Chi Squared Attribute Evaluator + Ranker
if ($Config{ChiSquaredRanker} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ChiSquaredAttributeEval -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'7.txt'  ");
}
#Attribute Evaluator: Classifier Subset Evaluator
#Classifier Subset Evaluator + Best first
#SLOW# 
#if ($Config{ClassifierSubsetEvaluatorBestFirst} eq "TRUE") {
#system("java -Xmx5G weka.attributeSelection.ClassifierSubsetEval -B weka.classifiers.rules.ZeroR -H $dir3/$partialName[0]test.arff -s \"weka.attributeSelection.BestFirst -D 1 -N 5\" -i $dir1/$file &> $dir2/$partialName[0]'32.txt' ");  
#}
#Classifier Subset Evaluator + Genetic Search
if ($Config{ClassifierSubsetEvaluatorGeneticSearch} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ClassifierSubsetEval -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff -s \"weka.attributeSelection.GeneticSearch -Z 20 -G 20 -C 0.6 -M 0.033 -R 20 -S 1\" -i $dir1/$file >> $dir2/$partialName[0]'9.txt'  ");
#}
#Classifier Subset Evaluator + Linear Forward Selection
if ($Config{ClassifierSubsetEvaluatorLinearForwardSelection} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ClassifierSubsetEval -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff -s \"weka.attributeSelection.LinearForwardSelection -D 0 -N 5 -I -K 50 -T 0\" -i $dir1/$file &> $dir2/$partialName[0]'11.txt' ");
}

# Classifier Subset Evaluator + Rank Search
if ($Config{ClassifierSubsetEvaluatorRankSearch} eq "TRUE") {
system(" java -Xmx5G weka.attributeSelection.ClassifierSubsetEval -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff -s \"weka.attributeSelection.RankSearch -S 1 -R 0 -A weka.attributeSelection.GainRatioAttributeEval --\" -i $dir1/$file &> $dir2/$partialName[0]'12.txt' ");  
}

#Classifier Subset Evaluator + Subset Size Forward Selection
if ($Config{ClassifierSubsetEvaluatorSubsetSizeForwardSelection} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ClassifierSubsetEval -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff -s \"weka.attributeSelection.SubsetSizeForwardSelection -I -K 50 -T 0 -F 5 -S 1 -Z -E weka.attributeSelection.ClassifierSubsetEval -- -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff\" -i $dir1/$file &> $dir2/$partialName[0]'13.txt'  ");
}
#Attribute Evaluator: Consistency Subset Evaluator
#Consistency Subset Evaluator + Best first
if ($Config{ConsistencySubsetEvlaulatorBestFirst} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ConsistencySubsetEval -s \"weka.attributeSelection.BestFirst -D 1 -N 5\" -i $dir1/$file &> $dir2/$partialName[0]'14.txt'  ");
}
#Consistency Subset Evaluator + Genetic Search
if ($Config{ConsistencySubsetEvaluatorGeneticSearch} eq "TRUE") {
system(" java -Xmx5G weka.attributeSelection.ConsistencySubsetEval -s \"weka.attributeSelection.GeneticSearch -Z 20 -G 20 -C 0.6 -M 0.033 -R 20 -S 1\" -i $dir1/$file &> $dir2/$partialName[0]'15.txt' ");
}
#Consistency Subset Evaluator + Greedy Stepwise
#SLOW# 
#if ($Config{ConsistencySubsetEvaluatorGreedyStepwise} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.ConsistencySubsetEval -s \"weka.attributeSelection.GreedyStepwise -T -1.7976931348623157E308 -R -N -1\" -i $dir1/$file > $dir2/$partialName[0]'31.txt' ");  
#}
#Consistency Subset Evaluator + Linear Forward Selection
if ($Config{ConsistencySubsetEvaluatorLinearForwardSelection} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ConsistencySubsetEval -s \"weka.attributeSelection.LinearForwardSelection -D 0 -N 5 -I -K 50 -T 0\" -i $dir1/$file >> $dir2/$partialName[0]'17.txt'  ");
}
#Consistency Subset Evaluator + Rank Search
if ($Config{ConsistencySubsetEvaluatorRankSearch} eq "TRUE") {
system(" java -Xmx5G weka.attributeSelection.ConsistencySubsetEval -s \"weka.attributeSelection.RankSearch -S 1 -R 0 -A weka.attributeSelection.GainRatioAttributeEval --\" -i $dir1/$file >> $dir2/$partialName[0]'18.txt' "); 
}
#Consistency Subset Evaluator + Subset Size Forward Selection
if ($Config{ConsistencySubsetEvaluatorSubsetSizeForwardSelection} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ConsistencySubsetEval -s \"weka.attributeSelection.SubsetSizeForwardSelection -I -K 50 -T 0 -F 5 -S 1 -Z -E weka.attributeSelection.ClassifierSubsetEval -- -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff\" -i $dir1/$file >> $dir2/$partialName[0]'19.txt'  ");
}
#Attribute Evaluator: Filtered Attribute Evaluator
#Filtered Attribute Evaluator + Ranker
if ($Config{FilteredAttributeEvaluatorRanker} eq "TRUE") {
system(" java -Xmx5G weka.attributeSelection.FilteredAttributeEval -W \"weka.attributeSelection.InfoGainAttributeEval\" -F \"weka.filters.supervised.instance.SpreadSubsample -M 0.0 -X 0.0 -S 1\" -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'20.txt' ");
}
#Attribute Evaluator: Filtered Subset Evaluator
#Filtered Subset Evaluator + Best first
#if ($Config{FilteredSubsetEvaluatorBestFirst} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.FilteredSubsetEval -W \"weka.attributeSelection.CfsSubsetEval\" -F \"weka.filters.supervised.instance.SpreadSubsample -M 0.0 -X 0.0 -S 1\" -s \"weka.attributeSelection.BestFirst -D 1 -N 5\" -i $dir1/$file &> $dir2/$partialName[0]'28.txt' ");  
#}
#Filtered Subset Evaluator + Genetic Search 
#if ($Config{FilteredSubsetEvaluatorGeneticSearch} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.FilteredSubsetEval -W \"weka.attributeSelection.CfsSubsetEval\" -F \"weka.filters.supervised.instance.SpreadSubsample -M 0.0 -X 0.0 -S 1\" -s \"weka.attributeSelection.GeneticSearch -Z 20 -G 20 -C 0.6 -M 0.033 -R 20 -S 1\" -i $dir1/$file &> $dir2/$partialName[0]'27.txt' ");  
#}
#Filtered Subset Evaluator + Greedy Stepwise
#if ($Config{FilteredSubsetEvaluatorGreedyStepwise} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.FilteredSubsetEval -W \"weka.attributeSelection.CfsSubsetEval\" -F \"weka.filters.supervised.instance.SpreadSubsample -M 0.0 -X 0.0 -S 1\" -s \"weka.attributeSelection.GreedyStepwise -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'26.txt' ");  
#}
#Filtered Subset Evaluator + Linear Forward Selection
#if ($Config{FilteredSubsetEvaluatorLinearForwardSelection} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.FilteredSubsetEval -W \"weka.attributeSelection.CfsSubsetEval\" -F \"weka.filters.supervised.instance.SpreadSubsample -M 0.0 -X 0.0 -S 1\" -s \"weka.attributeSelection.LinearForwardSelection -D 0 -N 5 -I -K 50 -T 0\" -i $dir1/$file &> $dir2/$partialName[0]'25.txt' ");  
#}
#Filtered Subset Evaluator + Subset Size Forward Selection
#if ($Config{FilteredSubsetEvaluatorSubsetSizeForwardSelection} eq "TRUE") {
#system(" java -Xmx5G weka.attributeSelection.FilteredSubsetEval -W \"weka.attributeSelection.CfsSubsetEval\" -F \"weka.filters.supervised.instance.SpreadSubsample -M 0.0 -X 0.0 -S 1\" -s \"weka.attributeSelection.SubsetSizeForwardSelection -I -K 50 -T 0 -F 5 -S 1 -Z -E weka.attributeSelection.ClassifierSubsetEval -- -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff\" -i $dir1/$file &> $dir2/$partialName[0]'24.txt' ");  
#}
#Attribute Evaluator: Gain Ratio Attribute Evaluator
#Gain Ratio Attribute Evaluator + Ranker
if ($Config{GainRatioAttributeEvaluatorRanker} eq "TRUE") {
system(" java -Xmx5G weka.attributeSelection.GainRatioAttributeEval -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'23.txt'  ");
}
#Attribute Evaluator: Latent Semantic Analysis
#Latent Semantic Analysis + Ranker
if ($Config{LatentSemanticAnalysisRanker} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.LatentSemanticAnalysis -R 0.95 -A 5 -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'22.txt'  ");
}
#Attribute Evaluator: One R Attribute Evlauator
#One R Attribute Evlauator + Ranker
if ($Config{OneRAttributeEvaluatorRanker} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.OneRAttributeEval -S 1 -F 10 -B 6 -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'21.txt' ");
}
#Attribute Evaluator: Relief F Attribute Evaluator
#Relief F Attribute Evaluator + Ranker
if ($Config{ReliefFAttributeEvaluatorRanker} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.ReliefFAttributeEval -M -1 -D 1 -K 10 -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'5.txt'  ");
}
#Attribute Evaluator: SymmetricalUncertAttributeEval
#SymmetricalUncertAttributeEval + Ranker
if ($Config{SymmetricalUncertAttributeEvalRanker} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.SymmetricalUncertAttributeEval -s \"weka.attributeSelection.Ranker -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'10.txt'");
}
#Wrapper Subset Evaluator + Genetic Search
if ($Config{WrapperSubsetEvaluatorGeneticSearch} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.WrapperSubsetEval -B weka.classifiers.rules.ZeroR -F 5 -T 0.01 -R 1 -s \"weka.attributeSelection.GeneticSearch -Z 20 -G 20 -C 0.6 -M 0.033 -R 20 -S 1\" -i $dir1/$file >> $dir2/$partialName[0]'16.txt' ");
}
#Wrapper Subset Evaluator + Rank Search
if ($Config{WrapperSubsetEvaluatorRankSearch} eq "TRUE") {
system(" java -Xmx5G weka.attributeSelection.WrapperSubsetEval -B weka.classifiers.rules.ZeroR -F 5 -T 0.01 -R 1 -s \"weka.attributeSelection.RankSearch -S 1 -R 0 -A weka.attributeSelection.GainRatioAttributeEval --\" -i $dir1/$file &> $dir2/$partialName[0]'8.txt' "); 
}
#Wrapper Subset Evaluator + Subset Size Forward Selection
if ($Config{WrapperSubsetEvaluatorSubsetSizeForwardSelection} eq "TRUE") {
system("java -Xmx5G weka.attributeSelection.WrapperSubsetEval -B weka.classifiers.rules.ZeroR -F 5 -T 0.01 -R 1 -s \"weka.attributeSelection.SubsetSizeForwardSelection -I -K 50 -T 0 -F 5 -S 1 -Z -E weka.attributeSelection.ClassifierSubsetEval -- -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff\" -i $dir1/$file &> $dir2/$partialName[0]'6.txt' ");
}
#Classifier Subset Evaluator + Greedy Stepwise
#SLOW# 
#if ($Config{ClassifierSubsetEvaluatorGreedyStepwise} eq "TRUE") {
#system("java -Xmx5G weka.attributeSelection.ClassifierSubsetEval -B weka.classifiers.rules.ZeroR -T -H $dir3/$partialName[0]test.arff -s \"weka.attributeSelection.GreedyStepwise -R -T -1.7976931348623157E308 -N -1\" -i $dir1/$file &> $dir2/$partialName[0]'30.txt' ");
}
}
closedir(DIR);
exit 0;

