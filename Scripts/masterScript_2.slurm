#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#SBATCH --time=23:00:00         # Run time in hh:mm:ss
#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)
#SBATCH --job-name=MasterScript2
#SBATCH --error=/home/general/data/CancerDiscover/Outputs/job.%J.err
#SBATCH --output=/home/general/data/CancerDiscover/Outputs/job.%J.out

start=$(date +%s)
#this script constitutes the second leg of the pipeline, from normalized expression matrix to feature selection.
cd /home/general/data/CancerDiscover/Scripts

#Splitting the data and head sections
perl processingBeforeTransposing.pl &
wait

#Head section completion
perl preprocessingContinued.pl &
wait

#Data matrix transposition
perl transposer.pl &
wait

#Addition of class variables
perl sampleNumberClassPaster.pl &
wait

#each piece of the arrf is compiled into single file, with the correct orientation
perl classAndDataLineMaker.pl &
perl concatenationTRAIN.pl &
wait

#data partitioning
perl dataPartitioning.pl Configuration.txt &
wait

#feature selection
sbatch featureSelection.slurm

end=$(date +%s)
runTime=$((end-start))
echo $runTime>../Logs/runTime_ms2SLURM.txt
