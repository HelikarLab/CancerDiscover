#Installing Bioconductor, Affy, AnnotationDbi, and hgu133plus2cdf

#Install Bioconductor
source ("http://bioconductor.org/biocLite.R")

#If there is a updated bioconductor package available
#biocLite("BiocUpgrade")

#Install Affy R module
biocLite("affy")

#Annotation Database Interface
#You will also need a package called AnnotationDbi which can be installed with the command below:
biocLite("AnnotationDbi")
#It provides user interface and database connection code for annotation data packages using SQLite data storage.

#CDF (Chip Definition File)
#Command to download the plate HG_U133_Plus2 cdf:
biocLite("hgu133plus2cdf")
#It is important to note that not all data must have been derived from affymetrix plates which meet the requirements put in place by the Affy R package. Plates such as HG_U95 and HG_U133 are known to be acceptable as long as their associated cdf has been installed.
