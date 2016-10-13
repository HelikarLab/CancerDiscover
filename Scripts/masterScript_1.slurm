#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#SBATCH --time=23:00:00         # Run time in hh:mm:ss
#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)
#SBATCH --job-name=MasterScript1
#SBATCH --error=/home/general/data/CancerDiscover/Outputs/job.%J.err
#SBATCH --output=/home/general/data/CancerDiscover/Outputs/job.%J.out

start=$(date +%s)
#this script constitutes the first leg of the pipeline, from raw CEL files through normalization.
cd /home/general/data/CancerDiscover/Scripts

#building temp files for normalization and classList.txt
perl classListMaker.pl
bash readAffyBatchMaker.bash 
bash RcodeTempBuilder.bash

#Raw data normalization
sbatch R_normalization.slurm
end=$(date +%s)
runTime=$((end-start))
echo $runTime>../Logs/runTime_ms1SLURM.txt
