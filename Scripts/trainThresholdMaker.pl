    #!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

    use strict;
    use warnings;

    	my $dir1 = '../FeatureSelection/Chunks/ArffPreprocessing';
	my $dir2 = '../DataFiles';
	
	opendir(DIR, $dir1) or die $!;

for (my $i=1; $i <= 23; $i++) {

#print "$matchingFile \n";
#print "$dir1/$file \n";

#system("awk -F\"\t\" 'FILENAME==\"$dir1/$file\"{a[\$1]=\$1} FILENAME==\"$matchingFile\"{if(a[\$1]){print \$0}}' $dir1/$file  $matchingFile > $dir1/$partialName[0]'\_matched.out'");

system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top1pc\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top1pc\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top1pc\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top10pc\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top10pc\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top10pc\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top33pc\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top33pc\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top33pc\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top66pc\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top66pc\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top66pc\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top100pc\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top100pc\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top100pc\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top25features\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top25features\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top25features\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top50features\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top50features\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top50features\_matched.out ");
system("awk -F\"\t\" 'FILENAME==\"$dir1/$i\_top100features\.txt\"{a[\$1]=\$1} FILENAME==\"../DataFiles/ExpressionSet.txt\"{if(a[\$1]){print \$0}}' $dir1/$i\_top100features\.txt ../DataFiles/ExpressionSet.txt > $dir1/$i\_top100features\_matched.out ");


#this is the line which workds on the commmand line
#awk -F"\t" 'FILENAME=="4_1_top1pc.txt"{a[$1]=$1} FILENAME=="../../../DataFiles/ExpressionSet.txt"{if(a[$1]){print $0}}' 4_1_top1pc.txt ../../../DataFiles/ExpressionSet.txt > 4_1_top1pc_matched.out

    }

    closedir(DIR);
    exit 0;



