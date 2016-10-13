#!/usr/bin/bash
        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#this script removes files from the following directory if the files have a size of 0 (aka empty)
cd ../FeatureSelection/Chunks/ArffPreprocessing

for x in *
do
    if [ -s $x ]
    then
        continue
    else
        rm -rf $x
    fi
done
