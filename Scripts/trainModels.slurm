#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#SBATCH --time=23:00:00         # Run time in hh:mm:ss
#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)
#SBATCH --job-name=TrainModels
#SBATCH --error=/home/general/data/CancerDiscover/Outputs/job.%J.err
#SBATCH --output=/home/general/data/CancerDiscover/Outputs/job.%J.out

#this script contributes to model training.
cd /home/general/data/CancerDiscover/Scripts

#this will TRAIN the files for top 1% of features
perl trainModels_top1pc.pl Configuration.txt
 
#this will TRAIN the files for top 10% of features
perl trainModels_top10pc.pl Configuration.txt

#this will TRAIN the files for the top 33% of features
perl trainModels_top33pc.pl Configuration.txt

#this will TRAIN the files for the top 66% of features
perl trainModels_top66pc.pl Configuration.txt

#this will TRAIN the files for the top 100% of features
perl trainModels_top100pc.pl Configuration.txt

#this will TRAIN the files for the top 25 features
perl trainModels_top25features.pl Configuration.txt
 
#this will TRAIN the files for the top 50 features
perl trainModels_top50features.pl Configuration.txt

#this will TRAIN the files for the top 100 features
perl trainModels_top100features.pl Configuration.txt
