#Helikar Lab, University of Nebraska, Lincoln  copyright 2016
#Developed by Greyson Biegert and Akram Mohammed
#GPL-3.0

filenames = character(0),
phenoData = new("AnnotatedDataFrame"),
description = NULL,
notes = "",
compress = getOption("BioC")$affy$compress.cel,
rm.mask = FALSE, rm.outliers = FALSE, rm.extra = FALSE,
verbose = FALSE,sd=FALSE, cdfname = NULL)

eset_AffyBatch <- expresso(AffyBatch, normalize.method="quantiles", bgcorrect.method="rma",pmcorrect.method="pmonly", summary.method="medianpolish")

write.exprs(eset_AffyBatch, file="ExpressionSet.txt")
