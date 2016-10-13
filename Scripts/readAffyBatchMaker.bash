#!/bin/bash

        #Helikar Lab, University of Nebraska, Lincoln  copyright 2016
        #Developed by Greyson Biegert and Akram Mohammed
        #GPL-3.0

awk '{print "AffyBatch <-read.affybatch(\""$0"\" ," }' ../DataFiles/sampleNames.txt > AffyBatchLine.txt
