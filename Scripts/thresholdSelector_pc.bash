#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

# This script is supposed to take an input file which contains a list of ranked probes, and create an output file which lists the probes still in ranked order (highest to lowest) but the output list should only be a fraction of the original list. Meaning, I want an output list of probes which correspond to the top 1% 5% 10% etc. of the ranked probes from the input list. 

# I am changing where the script will function, to the directory containing the input and eventual output files. 
cd ../FeatureSelection/Chunks/ArffPreprocessing

# The output (a) from the word count command is a number corresponding to the total amount of lines (probes) in the input file. This number (a) is then used to find out how many lines (b) constitute a given percent. That line (b) and all the lines before it, are then placed in a new file as the top percent of ranked attributes.

for i in {1..23}
do 
input="../ExpressionSet_"$i"_chunk.txt"
	#echo "AKRAM $input"
	
	#echo "Greyson output$i_$j"
A=$(awk 'END{print NR*0.01}' $input)
awk 'NR<='$A' {print $0}' $input > "$i"_top1pc.txt

C=$(awk 'END{print NR*0.10}' $input)
awk 'NR<='$C' {print $0}' $input > "$i"_top10pc.txt

D=$(awk 'END{print NR*0.333}' $input)
awk 'NR<='$D' {print $0}' $input > "$i"_top33pc.txt

E=$(awk 'END{print NR*0.666}' $input)
awk 'NR<='$E' {print $0}' $input > "$i"_top66pc.txt

F=$(awk 'END{print NR*1}' $input)
awk 'NR<='$F' {print $0}' $input > "$i"_top100pc.txt

#the following three lines are working
awk 'NR==1,NR==25 {print $0}' $input > "$i"_top25features.txt

awk 'NR==1,NR==50 {print $0}' $input > "$i"_top50features.txt

awk 'NR==1,NR==100 {print $0}' $input > "$i"_top100features.txt

done

