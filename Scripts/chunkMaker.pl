   #!/usr/bin/perl

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

    use strict;
    use warnings;
   
    my $dir1 = '../FeatureSelection';
    my $dir2 = '../FeatureSelection/Chunks';
    opendir(DIR, $dir1) or die $!;
    while (my $file = readdir(DIR)) {
   
    # We only want files
     next unless (-f "$dir1/$file");
   
   # Use a regular expression to find files with .txt
    next unless ($file =~ m/\.txt/);
   

   my @partialName = (split /\_/, $file);
#this scipt parces out the ranked feature lists from output file from feature selection
#1
system("grep '_' $dir1/$partialName[0]'\_1\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_1\_chunk\.txt' ");

#2
system("grep '_' $dir1/$partialName[0]'\_2\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_2\_chunk\.txt' ");

#3
system("grep '_' $dir1/$partialName[0]'\_3\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_3\_chunk\.txt' ");

#4
system("grep '_' $dir1/$partialName[0]'\_4\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_4\_chunk\.txt' ");

#5
system("grep '_' $dir1/$partialName[0]'\_5\.txt' |awk '{print \$3}' > $dir2/$partialName[0]'\_5\_chunk\.txt' ");

#6
system("grep '_' $dir1/$partialName[0]'\_6\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_6\_chunk\.txt' ");

#7
system("grep '_' $dir1/$partialName[0]'\_7\.txt' |awk '{print \$3}' > $dir2/$partialName[0]'\_7\_chunk\.txt' ");

#8
#there is only a single attribute to pull from this input file
system("grep '^                     [0-9]' $dir1/$partialName[0]\_8\.txt |awk '{print \$1}' > $dir2/$partialName[0]'\_8\_chunk\.txt' ");

#9
system("grep '_' $dir1/$partialName[0]'\_9\.txt' | awk '{print \$1}'  > $dir2/$partialName[0]'\_9\_chunk\.txt' ");

#10
system("grep '_' $dir1/$partialName[0]'\_10\.txt' |awk '{print \$3}' > $dir2/$partialName[0]'\_10\_chunk\.txt' ");

#11
system("grep '_' $dir1/$partialName[0]'\_11\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_11\_chunk\.txt' ");

#12
#there is only a single attribute to pull from this input file
system("grep '^                     [0-9]' $dir1/$partialName[0]\_12\.txt |awk '{print \$1}' > $dir2/$partialName[0]'\_12\_chunk\.txt' ");

#13
system("grep '_' $dir1/$partialName[0]'\_13\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_13\_chunk\.txt' ");

#14
#there is only a single attribute to pull from this input file
system("grep '_' $dir1/$partialName[0]'\_14\.txt' |awk '{print \$1}'> $dir2/$partialName[0]'\_14\_chunk\.txt' ");

#15
system("grep '_' $dir1/$partialName[0]'\_15\.txt'| awk '{print \$1}' > $dir2/$partialName[0]'\_15\_chunk\.txt' ");

#16
system("grep '_' $dir1/$partialName[0]'\_16\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_16\_chunk\.txt' ");

#17
#there is only a single attribute to pull from this input file
system("grep '_' $dir1/$partialName[0]'\_17\.txt' |awk '{print \$1}'> $dir2/$partialName[0]'\_17\_chunk\.txt' ");

#18
#there is only a single attribute to pull from this input file
system("grep '^                     [0-9]' $dir1/$partialName[0]\_18\.txt |awk '{print \$1}' > $dir2/$partialName[0]'\_18\_chunk\.txt' ");

#19
#there is only a single attribute to pull from this input file
system("grep '_' $dir1/$partialName[0]'\_19\.txt' |awk '{print \$1}' > $dir2/$partialName[0]'\_19\_chunk\.txt' ");

#20
system("grep '^ [0-9]' $dir1/$partialName[0]'\_20\.txt' > $dir1/20\.temp ");
system("awk -F\" \" '{print \$3}' $dir1/20\.temp > $dir2/$partialName[0]'\_20\_chunk\.txt'  ");

#21
system("grep '_' $dir1/$partialName[0]'\_21\.txt' |awk '{print \$3}' > $dir2/$partialName[0]'\_21\_chunk\.txt' ");

#22
system("grep '^  [0-9]'  $dir1/$partialName[0]'\_22\.txt' |sort -k1,1nr -k2,2 | grep '_'| awk '{print \$2}' > $dir2/$partialName[0]'\_22\_chunk\.txt' ");

#23
system("grep '_'  $dir1/$partialName[0]'\_23\.txt'  |awk '{print \$3}' > $dir2/$partialName[0]'\_23\_chunk\.txt' ");

system("rm $dir1/20\.temp ");

}
closedir (DIR);
exit 0;

