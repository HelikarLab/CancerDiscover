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

#this records the memory usage
echo CPU: `top -b -n1 |grep "Cpu(s)" |awk '{print $2 + $4}' ` > ../Temp/memoryUsage1_ms1.temp
FREE_DATA=`free -m | grep Mem`
CURRENT=`echo $FREE_DATA | cut -f3 -d' '`
TOTAL=`echo $FREE_DATA | cut -f2 -d' '`
echo RAM: $(echo "scale = 2; $CURRENT/$TOTAL*100"| bc) > ../Temp/memoryUsage2_ms1.temp
cat ../Temp/memoryUsage1_ms1.temp ../Temp/memoryUsage2_ms1.temp  > ../Logs/memoryUsage_ms1.txt

#building temp files for normalization and classList.txt
perl classListMaker.pl
bash readAffyBatchMaker.bash 
bash RcodeTempBuilder.bash

#Raw data normalization
Rscript normalization.R

end=$(date +%s)
runTime=$((end-start))
echo $runTime>../Logs/runTime_ms1BASH.txt

