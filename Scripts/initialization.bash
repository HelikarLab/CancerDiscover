#!usr/bin/bash
        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#This script is designed to make the slurm files containing the path from the configuration file
start=$(date +%s)

#this records the memory usage
echo CPU: `top -b -n1 |grep "Cpu(s)" |awk '{print $2 + $4}' ` > ../Temp/memoryUsage1_initialization.temp
FREE_DATA=`free -m | grep Mem`
CURRENT=`echo $FREE_DATA | cut -f3 -d' '`
TOTAL=`echo $FREE_DATA | cut -f2 -d' '`
echo RAM: $(echo "scale = 2; $CURRENT/$TOTAL*100"| bc) > ../Temp/memoryUsage2_initialization.temp
cat ../Temp/memoryUsage1_initialization.temp ../Temp/memoryUsage2_initialization.temp > ../Logs/memoryUsage_initialization.txt

A=$(pwd)
source $A/Configuration.txt

##Master Script 1##
#Building the top part
echo -e "#!/bin/bash\n\n        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016\n        #Developed by Greyson Biegert and Akram Mohammed\n        #GPL-3.0\n\n#SBATCH --time=23:00:00         # Run time in hh:mm:ss\n#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)\n#SBATCH --job-name=MasterScript1\n#SBATCH --error=$pathToProject/Outputs/job.%J.err\n#SBATCH --output=$pathToProject/Outputs/job.%J.out\n\nstart=\$(date +%s)\n#this script constitutes the first leg of the pipeline, from raw CEL files through normalization.\ncd $pathToProject/Scripts\n" > $A/ms1.temp1

#Putting the top and bottom together
cat ms1.temp1 ms1.temp2 > masterScript_1.slurm
cat ms1.temp1 ms1_memoryUsage.txt ms1_sh.temp2 > masterScript_1.bash

##Master Script 2##
#this will build the top part
echo -e "#!/bin/bash\n\n        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016\n        #Developed by Greyson Biegert and Akram Mohammed\n        #GPL-3.0\n\n#SBATCH --time=23:00:00         # Run time in hh:mm:ss\n#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)\n#SBATCH --job-name=MasterScript2\n#SBATCH --error=$pathToProject/Outputs/job.%J.err\n#SBATCH --output=$pathToProject/Outputs/job.%J.out\n\nstart=\$(date +%s)\n#this script constitutes the second leg of the pipeline, from normalized expression matrix to feature selection.\ncd $pathToProject/Scripts\n" > $A/ms2.temp1

#Putting the top and bottom together
cat ms2.temp1 ms2.temp2 > masterScript_2.slurm
cat ms2.temp1 ms2_memoryUsage.txt ms2_sh.temp2 > masterScript_2.bash

##Master Script 3##
#this will build the top part
echo -e "#!/bin/bash\n\n        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016\n        #Developed by Greyson Biegert and Akram Mohammed\n        #GPL-3.0\n\n#SBATCH --time=23:00:00         # Run time in hh:mm:ss\n#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)\n#SBATCH --job-name=MasterScript3\n#SBATCH --error=$pathToProject/Outputs/job.%J.err\n#SBATCH --output=$pathToProject/Outputs/job.%J.out\n\nstart=\$(date +%s)\n#this script constitutes the third leg of the pipeline, from feature selection outputs to model training and testing.\ncd $pathToProject/Scripts\n" > $A/ms3.temp1

#Putting the top and bottom together
cat ms3.temp1 ms3.temp2 > masterScript_3.slurm
cat ms3.temp1 ms3_memoryUsage.txt ms3_sh.temp2 > masterScript_3.bash

##Feature Selection##
#this should make the entire script
echo -e "#!/bin/bash\n\n        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016\n        #Developed by Greyson Biegert and Akram Mohammed\n        #GPL-3.0\n\n#SBATCH --time=23:00:00         # Run time in hh:mm:ss\n#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)\n#SBATCH --job-name=featureSelection\n#SBATCH --error=$pathToProject/Outputs/job.%J.err\n#SBATCH --output=$pathToProject/Outputs/job.%J.out\n\n#this script calls in the script which performs feature selection.\ncd $pathToProject/Scripts\n\n perl featureSelectionSLURM.pl Configuration.txt" > $A/featureSelection.slurm

##Train Models##
#building the top part
echo -e "#!/bin/bash\n\n        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016\n        #Developed by Greyson Biegert and Akram Mohammed\n        #GPL-3.0\n\n#SBATCH --time=23:00:00         # Run time in hh:mm:ss\n#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)\n#SBATCH --job-name=TrainModels\n#SBATCH --error=$pathToProject/Outputs/job.%J.err\n#SBATCH --output=$pathToProject/Outputs/job.%J.out\n\n#this script contributes to model training.\ncd $pathToProject/Scripts\n" > $A/trainModelsSlurm.temp1

#combining top and bottom
cat trainModelsSlurm.temp1 trainModelsSlurm.temp2 > trainModels.slurm

##Test Models##
#building the top part
echo -e "#!/bin/bash\n\n        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016\n        #Developed by Greyson Biegert and Akram Mohammed\n        #GPL-3.0\n\n#SBATCH --time=23:00:00         # Run time in hh:mm:ss\n#SBATCH --mem=60000             # Minimum memory required per CPU (in megabytes)\n#SBATCH --job-name=TestModels\n#SBATCH --error=$pathToProject/Outputs/job.%J.err\n#SBATCH --output=$pathToProject/Outputs/job.%J.out\n\n#this script contributes to model testing.\ncd $pathToProject/Scripts\n" > $A/testModelsSlurm.temp1

#combining top and bottom
cat testModelsSlurm.temp1 testModelsSlurm.temp2 > testModels.slurm

end=$(date +%s)
runTime=$((end-start))
echo $runTime>../Logs/runTime_initialization.txt


