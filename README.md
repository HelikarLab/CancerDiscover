# CancerDiscover

Welcome to **CancerDiscover**!

## Purpose: 
The purpose of this pipeline tool is to convert raw `CEL` file data into `Attribute Relation File Format` for cancer sample classification and biomarker discovery.


This README file will serve as a guide for using this software tool. We suggest reading through the entire document at least once, in order to get an idea of the options available, and how to customize the pipeline to fit your needs.


## Software Requirement 

Before installing **CancerDiscover**, make sure you have the necessary software packages installed. 

### Installing R

From the command line, enter the following commands below: 

```
sudo apt-get update
sudo apt-get install r-base
```
### Installing Bioconductor and Affy packages

Once `R` is installed you’ll need to use two more commands from within `R`.
From the command line enter the following command:

`R`

Once R has finished loading, enter the following command:

`source("http://bioconductor.org/biocLite.R")`

Wait for the command to finish executing then enter the following command to install the `Affy` `R` package:

`biocLite("affy")`

You will also need a package called AnnotationDbi which can be installed with the command below:

`biocLite("AnnotationDbi")`

### Installing WEKA

This project utilizes WEKA 3-6-11. In order to get this version, in a directory outside of the `CancerDiscover` directory, execute  the following command:

`wget https://sourceforge.net/projects/weka/files/weka-3-6/3.6.11/weka-3-6-11.zip/download`

Next, set the `WEKA` classpath by entering the following command in `.bashrc` file under Alias definitions:

```
export WEKAINSTALL=/absolute/path/to/weka/directory/` 
##for example: `export WEKAINSTALL=/home/general/weka/weka-3-6-11`
export CLASSPATH=$CLASSPATH:$WEKAINSTALL/weka.jar
```

**Note:** Since WEKA is Java-based framework, the user needs to install and set the classpath for `JAVA`. 

### Downloading CDF (Chip Definition File) File

In your web browser follow the link below. This web page is an archive of `cdf` files. In order for the pipeline to normalize the data correctly, you must find the file corresponding to your experimental plate. 

Follow the link and install it similar to how you installed the `Affy` `R` package:

(https://bioconductor.org/packages/3.3/data/annotation/).

For example, the following commands (entered in `R`, one at a time) would be used to install the plate *HG_U133_Plus2* `cdf` file.
```
source("http://bioconductor.org/biocLite.R")
biocLite("hgu133plus2cdf")
```
It is important to note that not all data must have been derived from affymetrix plates which meet the requirements put in place by the `Affy` `R` package. Plates such as *HG_U95* and *HG_U133* are known to be acceptable as long as their associated `cdf` has been installed. In order to refer to `Affy` documentation for more details, run the following command while `R` is working:
```
browseVignettes("affy")
```

### Installing Perl

#### For OSX users
Install `"Command Line Tools for Xcode"`, either directly or through `Xcode`, both available from Apple Developer downloads (free registration required). `Xcode` can also be installed through the App Store application.
Open the `Terminal.app` (found in Applications -> Utilities) and execute the command given below:
```
curl -L http://xrl.us/installperlosx | bash
```

#### For Unix/Linux users
Install a compiler, such as `gcc` through your system package management (e.g. `apt`, `yum`).

Open a Terminal and execute the command given below:
```
curl -L http://xrl.us/installperlnix | bash
```
## Hardware Requirements

You will need a computer with at least 230 MB of memory to store the **CancerDiscover** pipeline. 

## System Requirements

You will need current or very recent generations of your operating system: 
Linux, Unix, or MacOS.


## Downloading **CancerDiscover**

From your web browser, go to the GitHub website [link](https://github.com/HelikarLab/CancerDiscover). It is important to note that you may have to install other unix commands such as the command **source** and the larger software package `Perl`. Both are necessary for the pipeline to function. 

## Directory Structure of the Pipeline:

After installation of **CancerDiscover**, notice inside the **CancerDiscover** directory there are several empty directories and one which contains all of the scripts necessary to process data:

 - `DataFiles` directory contains raw CEL files and sampleList.txt file
 - `Outputs` repository contains  “resultsSummary.txt” file which will have the summary of  the model accuracies as well as information   regarding the context which gave the highest accuracy. 
- `Scripts` directory contains all of the source code 
- `Models` repository contains all of the classification models
- `Temp` directory contains intermediate files that are generated as part of the execution of the pipeline
- `Feature Selection` directory contains the feature selection algorithm output files and two nested directories for arff file generation, namely `Chunks` and `ArffPreprocessing`
- `Chunks` contains different threshold feature sets
- `ArffPreprocessing` directory contains the feature vectors in arff format . Feature vectors made here are split into training and testing datasets in their respective directories.
- `Train` is the repository of the training data for the modeling
- `Test` is the repository of the testing data for model testing
- `SampleData` is a directory which contains 10 sample CEL files and their associated sampleList.txt file
- `Logs` is a directory which contains the elapsed time in seconds for each leg of the pipeline from initialization through model testing.
- `CompletedExperiments` When the pipeline has finished running, the above directories which contain experimental data will be moved into this directory. This a directory will act as a repository of old experiment files organized by a time-stamp which reads Year, month, day, hours, minutes, seconds; in that order

## Execution of Pipeline
1. In the command line, your first step will be to place your raw `CEL` file data into the `DataFiles` directory.

2. Next, in the DataFiles directory you will need to make a two column csv (comma separated file) called *"sampleList.txt"*. In the first column write the name of each `CEL` file, and in the second column write the class identifier to be associated with that sample. See the example below:
```
CL2001031606AA.CEL,squamousCellCarcinoma
CL2001031607AA.CEL,squamousCellCarcinoma
CL2001031608AA.CEL,adenocarcinoma
CL2001031609AA.CEL,squamousCellCarcinoma
CL2001031611AA.CEL,adenocarcioma
```

3. If you are using the sample data:
   * enter the `SampleData` directory;
   * enter the command:
     `cp * ../DataFiles`;
     This command will copy all of the data and `sampleList.txt files` in the `SampleData` directory to the `DataFiles` directory.  
     
4. Initialization: 

   Once you have finished making the `sampleList.txt` file in the `DataFiles` directory, please go inside  the `Scripts` directory to      execute the next steps of the pipeline. 

   There are two versions of the pipeline, `BASH` and `SLURM` (Simple Linux Utility for Resource Management). `SLURM` is a computational    architecture used to organize user requests into a queue to utilize super-computer resources. `SLURM` requires no kernel         modifications for its operation and is relatively self-contained. Depending on your access to a `SLURM` scheduler, you will use one or    another set of scripts. If you do have access to a `SLURM` scheduler you will execute the scripts ending in `.slurm`. Otherwise, you will use the scripts ending in `.bash` . Due to the complexity of data manipulation, and/or the sheer size of your data, it is recommended to use a supercomputer. 

   Now, in the `Scripts` directory, edit the file called `Configuration.txt`, to make any changes desired for processing your data    including the normalization method, the size of data partitions, and which feature selection and classification algorithms are to be executed . The default settings for normalization are:
 
      - **Normalization:** `method="quantiles"`, 
      - **Background correction:** `method="rma"`,
      - **Pm value correction:** `method="pmonly"`,
      - **Summary:** `method="medianpolish"`.  
 
   The default setting for data partitioning is **50:50**. The default setting for feature selection algorithms will perform all       possible feature selection algorithm options. You can find the list of feature selection methods and their associated file names in the `Scripts` directory in the file named `featureSelectionAlgorithms.lookup`. The default setting for classification algorithms will generate models using the following algorithm options:
   
      - **Decision Tree**, 
      - **IBK**, 
      - **Naive Bayes**, 
      - **Random Forest**,
      - **Support Vector Machine**.
      
    If you wish to use other classification algorithms than the ones provided, refer to the0 `WEKA` resources at (weka.wikispaces.com/Primer). 
    In the configuration file you will also need to write in the absolute path. This path should end in `CancerDiscover`; for example a directory path might look like: `work/userGroup/userMember/data/CancerDiscover`
  
   ```
   cd ../Scripts
   bash initialization.bash
   ```

5. Normalization:

    The  purpose of the above script is to perform normalization on raw `CEL` data and generate the *Expression set matrix*. For other options, refer to (https://www.bioconductor.org/packages/devel/bioc/vignettes/affy/inst/doc/builtinMethods.pdf3)
   ```
  bash masterScript_1.bash
  ```
   For `SLURM` users:
  ```
  sbatch masterScript_1.slurm
  ```

6. Feature Selection:

 After normalization is complete, you will have a single file called `ExpressionSet.txt` in your `DataFiles` directory. The next step is to build a master feature vector file using the `ExpressionSet.txt` file. The next command you use will build this master feature vector file for you using the `ExpressionSet.txt` file, as well as perform data partitioning, or divide the master feature vector file into two parts; **training** and **testing**. The program will then perform feature selection using only the **training** portion of the master feature vector. Additionally, you can find the list of feature selection methods and their associated file names in the `Scripts` directory in the file named `featureSelectionAlgorithms.lookup`.

 The default setting for data partitioning is 50/50, meaning the master feature vector file will be split evenly into **training** and **testing** data sets while retaining approximately even distributions of your sample classes between the two daughter files. To achieve a larger split, such as 80/20 for training/testing, in the configuration file `Configuration.txt` replace the `2` with a `5`. This will tell the program to perform 5 folds, where the **training** file will retain `4` and the **testing** file will retain a single fold or `20%` of the master feature vector data. 

 The default setting for feature selection will perform all possible forms of feature selection available unless otherwise specified in the `configuration.txt` file. If you wish to change these feature selection options, in the `Scripts` directory you will need to edit the file named `configuration.txt`. Simply write `TRUE` next to all of the feature selection methods you wish to perform and `FALSE` if you do not want that method performed. Additionally, you can find the list of feature selection methods and their associated file names in the `Scripts` directory in the file named `featureSelectionAlgorithms.lookup`.

  ```
bash masterScript_2.bash	
```

For `SLURM` users:
```
sbatch masterScript_2.slurm
```
Once feature selection has been completed, new feature vectors are made based on the ranked lists of features.  The new feature vectors will be generated based on your threshold selections, and immediately  used to build and test classification models using a classification algorithm of your choosing. Lastly, the directories will be reset, and your old directories and files will be placed in the `CompletedExperiments` followed by a time-stamp. 
	
The last lines of the `masterScript_3` scripts will move the content of the `DataFiles` to `CompletedExperiments`, so the new experiment will run in `DataFiles` directory. You can find all raw data, feature selection outputs, **training** and **testing** feature vectors, models, and model results in the `CompletedExperiments` directory followed by a time-stamp. To run experiments with new data, begin with [step 1](#execution-of-pipeline).

```
bash masterScript_3.bash
```

For `SLURM` users:
```
sbatch masterScript_3.slurm
```
## Feedback

  Greyson Biegert	greyson@huskers.unl.edu

   Akram Mohammed	amohammed3@unl.edu

   Jiri Adamec		jadamec2@unl.edu

   Tomas Helikar		thelikar2@unl.edu


