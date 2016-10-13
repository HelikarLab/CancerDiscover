#!/bin/bash
        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

#this script is designed to build the temporary scripts for the normalization.R command, using the path and values designated by the Configuration file
A=$(pwd)
source $A/Configuration.txt

#this makes the top part of the script
echo -e "setwd(\"$pathToProject/DataFiles\")\nlibrary(affy)" > Rcode.R

#this makes the bottom part of the script
echo -e "filenames = character(0),\nphenoData = new(\"AnnotatedDataFrame\"),\ndescription = NULL,\nnotes = \"\",\ncompress = getOption(\"BioC\")\$affy\$compress.cel,\nrm.mask = FALSE, rm.outliers = FALSE, rm.extra = FALSE,\nverbose = FALSE,sd=FALSE, cdfname = NULL)\n\neset_AffyBatch <- expresso(AffyBatch, normalize.method=\"$normMethod\", bgcorrect.method=\"$bgCorrectMethod\",pmcorrect.method=\"$pmCorrectMethod\", summary.method=\"$summaryMethod\")\n\nwrite.exprs(eset_AffyBatch, file=\"ExpressionSet.txt\")" > Rcode.R2

#this puts the three pieces together, top middle and bottom
cat Rcode.R AffyBatchLine.txt Rcode.R2 > normalization.R


