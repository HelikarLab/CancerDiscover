setwd("/home/general/data/cancerML/DataFiles")
library(affy)
AffyBatch <-read.affybatch("GSM1544837_BM2806_GMP_91.CEL","GSM1544838_BM2806_HSC_87.CEL","GSM1544839_BM2806_L_MPP_89.CEL","GSM1544840_BM2806_MEP_92.CEL","GSM1544841_BM2806_MPP_88.CEL","GSM768750_7404.cel","GSM768751_7424.cel","GSM768752_7425.cel","GSM768753_7426.cel","GSM768754_7427.cel" ,
filenames = character(0),
phenoData = new("AnnotatedDataFrame"),
description = NULL,
notes = "",
compress = getOption("BioC")$affy$compress.cel,
rm.mask = FALSE, rm.outliers = FALSE, rm.extra = FALSE,
verbose = FALSE,sd=FALSE, cdfname = NULL)

eset_AffyBatch <- expresso(AffyBatch, normalize.method="quantiles", bgcorrect.method="rma",pmcorrect.method="pmonly", summary.method="medianpolish")

write.exprs(eset_AffyBatch, file="ExpressionSet.txt")
