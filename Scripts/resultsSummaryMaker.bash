#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#The purpose of this script is to compile the resulting accuracies from model generation into a single file

for i in {1..23}
do
#TRAINING#
cd ../Train/
echo "Entering Train directory"
#Decision Tree#
A1=$(grep 'Correctly Classified Instances' $i\_top1pc_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
B1=$(grep 'Correctly Classified Instances' $i\_top10pc_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
C1=$(grep 'Correctly Classified Instances' $i\_top33pc_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
D1=$(grep 'Correctly Classified Instances' $i\_top66pc_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
E1=$(grep 'Correctly Classified Instances' $i\_top100pc_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
F1=$(grep 'Correctly Classified Instances' $i\_top25features_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
G1=$(grep 'Correctly Classified Instances' $i\_top50features_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')
H1=$(grep 'Correctly Classified Instances' $i\_top100features_DTtrain.out |awk 'NR % 2==0' |awk '{print $5}')

#Naive Bayes#
A2=$(grep 'Correctly Classified Instances' $i\_top1pc_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
B2=$(grep 'Correctly Classified Instances' $i\_top10pc_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
C2=$(grep 'Correctly Classified Instances' $i\_top33pc_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
D2=$(grep 'Correctly Classified Instances' $i\_top66pc_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
E2=$(grep 'Correctly Classified Instances' $i\_top100pc_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
F2=$(grep 'Correctly Classified Instances' $i\_top25features_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
G2=$(grep 'Correctly Classified Instances' $i\_top50features_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')
H2=$(grep 'Correctly Classified Instances' $i\_top100features_NBtrain.out |awk 'NR % 2==0' |awk '{print $5}')

#IBK#
A3=$(grep 'Correctly Classified Instances' $i\_top1pc_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
B3=$(grep 'Correctly Classified Instances' $i\_top10pc_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
C3=$(grep 'Correctly Classified Instances' $i\_top33pc_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
D3=$(grep 'Correctly Classified Instances' $i\_top66pc_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
E3=$(grep 'Correctly Classified Instances' $i\_top100pc_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
F3=$(grep 'Correctly Classified Instances' $i\_top25features_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
G3=$(grep 'Correctly Classified Instances' $i\_top50features_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')
H3=$(grep 'Correctly Classified Instances' $i\_top100features_IBKtrain.out |awk 'NR % 2==0' |awk '{print $5}')

#Support Vector machine#
A4=$(grep 'Correctly Classified Instances' $i\_top1pc_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
B4=$(grep 'Correctly Classified Instances' $i\_top10pc_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
C4=$(grep 'Correctly Classified Instances' $i\_top33pc_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
D4=$(grep 'Correctly Classified Instances' $i\_top66pc_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
E4=$(grep 'Correctly Classified Instances' $i\_top100pc_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
F4=$(grep 'Correctly Classified Instances' $i\_top25features_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
G4=$(grep 'Correctly Classified Instances' $i\_top50features_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')
H4=$(grep 'Correctly Classified Instances' $i\_top100features_SVMtrain.out |awk 'NR % 2==0' |awk '{print $5}')

#Random Forest#
A5=$(grep 'Correctly Classified Instances' $i\_top1pc_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
B5=$(grep 'Correctly Classified Instances' $i\_top10pc_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
C5=$(grep 'Correctly Classified Instances' $i\_top33pc_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
D5=$(grep 'Correctly Classified Instances' $i\_top66pc_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
E5=$(grep 'Correctly Classified Instances' $i\_top100pc_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
F5=$(grep 'Correctly Classified Instances' $i\_top25features_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
G5=$(grep 'Correctly Classified Instances' $i\_top50features_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')
H5=$(grep 'Correctly Classified Instances' $i\_top100features_RFtrain.out |awk 'NR % 2==0' |awk '{print $5}')

#this will compile the training results for later
echo -e "$i Top 1%\t$A1\t$A2\t$A3\t$A4\t$A5" > ../Temp/$i\_train1pc.temp
echo -e "$i Top 10%\t$B1\t$B2\t$B3\t$B4\t$B5" > ../Temp/$i\_train10pc.temp
echo -e "$i Top 33%\t$C1\t$C2\t$C3\t$C4\t$C5" > ../Temp/$i\_train33pc.temp
echo -e "$i Top 66%\t$D1\t$D2\t$D3\t$D4\t$D5" > ../Temp/$i\_train66pc.temp
echo -e "$i Top 100%\t$E1\t$E2\t$E3\t$E4\t$E5" > ../Temp/$i\_train100pc.temp
echo -e "$i Top 25features\t$F1\t$F2\t$F3\t$F4\t$F5" > ../Temp/$i\_train25feats.temp
echo -e "$i Top 50features\t$G1\t$G2\t$G3\t$G4\t$G5" > ../Temp/$i\_train50feats.temp
echo -e "$i Top 100features\t$H1\t$H2\t$H3\t$H4\t$H5" > ../Temp/$i\_train100feats.temp

echo -e "GRESYON! $i Top 100features $H1 $H2 $H3 $H4 $H5"


cd ../Temp/
cat  $i\_train1pc.temp  $i\_train10pc.temp  $i\_train33pc.temp  $i\_train66pc.temp $i\_train100pc.temp $i\_train25feats.temp  $i\_train50feats.temp  $i\_train100feats.temp >  $i\_tempTrainLine2.txt

done

for i in {1..23}
do
#TESTING#
cd ../Test/
#echo "entering Test"
#Decision Tree#
A6=$(grep 'Correctly Classified Instances' $i\_top1pc_DTTest.out |awk '{print $5}')
B6=$(grep 'Correctly Classified Instances' $i\_top10pc_DTTest.out |awk '{print $5}')
C6=$(grep 'Correctly Classified Instances' $i\_top33pc_DTTest.out |awk '{print $5}')
D6=$(grep 'Correctly Classified Instances' $i\_top66pc_DTTest.out |awk '{print $5}')
E6=$(grep 'Correctly Classified Instances' $i\_top100pc_DTTest.out |awk '{print $5}')
F6=$(grep 'Correctly Classified Instances' $i\_top25features_DTTest.out |awk '{print $5}')
G6=$(grep 'Correctly Classified Instances' $i\_top50features_DTTest.out |awk '{print $5}')
H6=$(grep 'Correctly Classified Instances' $i\_top100features_DTTest.out |awk '{print $5}')

#Naive Bayes#
A7=$(grep 'Correctly Classified Instances' $i\_top1pc_NBTest.out |awk '{print $5}')
B7=$(grep 'Correctly Classified Instances' $i\_top10pc_NBTest.out |awk '{print $5}')
C7=$(grep 'Correctly Classified Instances' $i\_top33pc_NBTest.out |awk '{print $5}')
D7=$(grep 'Correctly Classified Instances' $i\_top66pc_NBTest.out |awk '{print $5}')
E7=$(grep 'Correctly Classified Instances' $i\_top100pc_NBTest.out |awk '{print $5}')
F7=$(grep 'Correctly Classified Instances' $i\_top25features_NBTest.out |awk '{print $5}')
G7=$(grep 'Correctly Classified Instances' $i\_top50features_NBTest.out |awk '{print $5}')
H7=$(grep 'Correctly Classified Instances' $i\_top100features_NBTest.out |awk '{print $5}')

#IBK#
A8=$(grep 'Correctly Classified Instances' $i\_top1pc_IBKTest.out |awk '{print $5}')
B8=$(grep 'Correctly Classified Instances' $i\_top10pc_IBKTest.out |awk '{print $5}')
C8=$(grep 'Correctly Classified Instances' $i\_top33pc_IBKTest.out |awk '{print $5}')
D8=$(grep 'Correctly Classified Instances' $i\_top66pc_IBKTest.out |awk '{print $5}')
E8=$(grep 'Correctly Classified Instances' $i\_top100pc_IBKTest.out |awk '{print $5}')
F8=$(grep 'Correctly Classified Instances' $i\_top25features_IBKTest.out |awk '{print $5}')
G8=$(grep 'Correctly Classified Instances' $i\_top50features_IBKTest.out |awk '{print $5}')
H8=$(grep 'Correctly Classified Instances' $i\_top100features_IBKTest.out |awk '{print $5}')

#Support Vector machine#
A9=$(grep 'Correctly Classified Instances' $i\_top1pc_SVMTest.out |awk '{print $5}')
B9=$(grep 'Correctly Classified Instances' $i\_top10pc_SVMTest.out |awk '{print $5}')
C9=$(grep 'Correctly Classified Instances' $i\_top33pc_SVMTest.out |awk '{print $5}')
D9=$(grep 'Correctly Classified Instances' $i\_top66pc_SVMTest.out |awk '{print $5}')
E9=$(grep 'Correctly Classified Instances' $i\_top100pc_SVMTest.out |awk '{print $5}')
F9=$(grep 'Correctly Classified Instances' $i\_top25features_SVMTest.out |awk '{print $5}')
G9=$(grep 'Correctly Classified Instances' $i\_top50features_SVMTest.out |awk '{print $5}')
H9=$(grep 'Correctly Classified Instances' $i\_top100features_SVMTest.out |awk '{print $5}')

#Random Forest#
A10=$(grep 'Correctly Classified Instances' $i\_top1pc_RFTest.out |awk '{print $5}')
B10=$(grep 'Correctly Classified Instances' $i\_top10pc_RFTest.out |awk '{print $5}')
C10=$(grep 'Correctly Classified Instances' $i\_top33pc_RFTest.out |awk '{print $5}')
D10=$(grep 'Correctly Classified Instances' $i\_top66pc_RFTest.out |awk '{print $5}')
E10=$(grep 'Correctly Classified Instances' $i\_top100pc_RFTest.out |awk '{print $5}')
F10=$(grep 'Correctly Classified Instances' $i\_top25features_RFTest.out |awk '{print $5}')
G10=$(grep 'Correctly Classified Instances' $i\_top50features_RFTest.out |awk '{print $5}')
H10=$(grep 'Correctly Classified Instances' $i\_top100features_RFTest.out |awk '{print $5}')

echo -e "$i Top 1%\t$A6\t$A7\t$A8\t$A9\t$A10" > ../Temp/$i\_test1pc.temp
echo -e "$i Top 10%\t$B6\t$B7\t$B8\t$B9\t$B10" > ../Temp/$i\_test10pc.temp
echo -e "$i Top 33%\t$C6\t$C7\t$C8\t$C9\t$C10" > ../Temp/$i\_test33pc.temp
echo -e "$i Top 66%\t$D6\t$D7\t$D8\t$D9\t$D10" > ../Temp/$i\_test66pc.temp
echo -e "$i Top 100%\t$E6\t$E7\t$E8\t$E9\t$E10" > ../Temp/$i\_test100pc.temp
echo -e "$i Top 25features\t$F6\t$F7\t$F8\t$F9\t$F10" > ../Temp/$i\_test25feats.temp
echo -e "$i Top 50features\t$G6\t$G7\t$G8\t$G9\t$G10" > ../Temp/$i\_test50feats.temp
echo -e "$i Top 100features\t$H6\t$H7\t$H8\t$H9\t$H10" > ../Temp/$i\_test100feats.temp

echo -e "$i $A6 $B6 $C6 $D6 $E6 $F6 $G6 $H6 $A7 $B7 $C7 $D7 $E7 $F7 $G7 $H7 $A8 $B8 $C8 $D8 $E8 $F8 $G8 $H8 $A9 $B9 $C9 $D9 $E9 $F9 $G9 $H9 $A10 $B10 $C10 $D10 $E10 $F10 $G10 $H10" > ../Temp/$i\_array.temp
cd ../Temp
cat  $i\_test1pc.temp  $i\_test10pc.temp  $i\_test33pc.temp  $i\_test66pc.temp $i\_test100pc.temp  $i\_test25feats.temp  $i\_test50feats.temp  $i\_test100feats.temp >  $i\_tempTestLine4.txt

done

echo -e "Training Thresholds\tDecision Tree\tNaive Bayes\tIBK\tSupport Vector Machine\tRandom Forest" > line1.temp
echo -e "Testing Thresholds\tDecision Tree\tNaive Bayes\tIBK\tSupport Vector Machine\tRandom Forest" > line3.temp
echo -e "DT:1% DT:10% DT:33% DT:66% DT:100% DT:25features DT:50features DT:100features NB:1% NB:10% NB:33% NB:66% NB:100% NB:25features NB:50features NB:100features IBK:1% IBK:10% IBK:33% IBK:66% IBK:100% IBK:25features IBK:50features IBK:100features SVM:1% SVM:10% SVML:33% SVM:66% SVM:100%SVM SVM:25features SVM:50features SVM:100features RF:1% RF:10% RF:33% RF:66% RF:100% RF:25features RF:50features RF:100features" > arrayTopRow.temp

#this command will make the first half of the results file
cat line1.temp 1_tempTrainLine2.txt 2_tempTrainLine2.txt 3_tempTrainLine2.txt 4_tempTrainLine2.txt 5_tempTrainLine2.txt 6_tempTrainLine2.txt 7_tempTrainLine2.txt 8_tempTrainLine2.txt 9_tempTrainLine2.txt 10_tempTrainLine2.txt 11_tempTrainLine2.txt 12_tempTrainLine2.txt 13_tempTrainLine2.txt 14_tempTrainLine2.txt 15_tempTrainLine2.txt 16_tempTrainLine2.txt 17_tempTrainLine2.txt 18_tempTrainLine2.txt 19_tempTrainLine2.txt 20_tempTrainLine2.txt 21_tempTrainLine2.txt 22_tempTrainLine2.txt 23_tempTrainLine2.txt line3.temp 1_tempTestLine4.txt 2_tempTestLine4.txt 3_tempTestLine4.txt 4_tempTestLine4.txt 5_tempTestLine4.txt 6_tempTestLine4.txt 7_tempTestLine4.txt 8_tempTestLine4.txt 9_tempTestLine4.txt 10_tempTestLine4.txt 11_tempTestLine4.txt 12_tempTestLine4.txt 13_tempTestLine4.txt 14_tempTestLine4.txt 15_tempTestLine4.txt 16_tempTestLine4.txt 17_tempTestLine4.txt 18_tempTestLine4.txt 19_tempTestLine4.txt 20_tempTestLine4.txt 21_tempTestLine4.txt 22_tempTestLine4.txt 23_tempTestLine4.txt > resultsSummary.temp


#this command makes the temp matrix file for comparisons
cat arrayTopRow.temp 1_array.temp 2_array.temp 3_array.temp 4_array.temp 5_array.temp 6_array.temp 7_array.temp 8_array.temp 9_array.temp 10_array.temp 11_array.temp 12_array.temp 13_array.temp 14_array.temp 15_array.temp 16_array.temp 17_array.temp 18_array.temp 19_array.temp 20_array.temp 21_array.temp 22_array.temp 23_array.temp > arrayMatrix.temp

#performing comparisons
cd ../Scripts
awk -f row_max.awk ../Temp/arrayMatrix.temp > ../Temp/lastLine.temp

cd ../Temp
#editing comparison output file so it looks pretty
awk '{print "\nUsing feature selection method #"$1" gave the highest accuracy (or accuracies) of "$2"\n\twhen submitted to the classification algorithm(s) "$3"\n"}' lastLine.temp | sed -e 's/,/ and /g' -e 's/:/ with a threshold of the top /g' > lastLine.txt

cat resultsSummary.temp lastLine.txt > ../Outputs/resultsSummary.txt


