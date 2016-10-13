#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

LOGDATE=$(date +%Y%m%dT%H%M%S)
mv ../DataFiles ../CompletedExperiments/DataFiles_$LOGDATE
mv ../FeatureSelection/Chunks/ArffPreprocessing ../CompletedExperiments/ArffPreprocessing_$LOGDATE
mv ../FeatureSelection/Chunks ../CompletedExperiments/Chunks_$LOGDATE
mv ../FeatureSelection ../CompletedExperiments/FeatureSelection_$LOGDATE
mv ../Train ../CompletedExperiments/Train_$LOGDATE
mv ../Test ../CompletedExperiments/Test_$LOGDATE
mv ../Temp ../CompletedExperiments/Temp_$LOGDATE
mv ../Models ../CompletedExperiments/Models_$LOGDATE
mv ../Outputs ../CompletedExperiments/Outputs_$LOGDATE
mv ../Logs ../CompletedExperiments/Logs_$LOGDATE

mkdir ../Temp
mkdir ../Logs
mkdir ../Outputs
mkdir ../Models
mkdir ../DataFiles
mkdir ../Train
mkdir ../Test
mkdir ../FeatureSelection
mkdir ../FeatureSelection/Chunks
mkdir ../FeatureSelection/Chunks/ArffPreprocessing
