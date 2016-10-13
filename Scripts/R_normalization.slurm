#!/bin/bash
        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#SBATCH --time=168:00:00
#SBATCH --mem-per-cpu=60000
#SBATCH --job-name=R_normalization
#SBATCH --error=R_normalization.stdout
#SBATCH --output=R_normalization.stderr
 
module load R/3.1

R CMD BATCH normalization.R
