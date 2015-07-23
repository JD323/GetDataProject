---
title: "README for run_analysis.R script"
author: "John Darling"
date: "Wednesday, July 22, 2015"
output: html_document
---

The run_analysis.R script reads in data on human activity monitoring using smartphones generated at the University of California Irvine Center for Machine Learning and Intelligent Systems. More information on the study that generated the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data files themselves can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To run the script, the following data files should be extracted and placed into the working directory that contains the run_analysis.R script:
  
* features.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* y_test.txt
* y_train.txt

The run_analysis.R script reads the appropriate data from these files and creates a data frame attaching subject and activity IDs to data for each feature of the smartphone measurements, and identifies data as deriving from the test or the training dataset. Only the mean and standard deviation data (66 variables) are extracted from the overall smartphone dataset. The script also identifies activities by name (walking, walking upstairs, walking downstairs, sitting, standing and laying[sic]) and generates more readable variable names based on the features (see Codebook.md for more details). 

The output of the script is a table of means for each of the 66 feature variables, calculated by subject and activity. This table is saved in the file phoneDataMeans.txt. 

NOTE: This script utilizes the R package "dplyr" and will attach this package automatically. This requires "dplyr" to be installed on your machine. If dplyr is not installed on your machine you can do so by calling

```{r}
install.packages("dplyr")
```

To run the script, save it in the directory that contains the data files specified above. Set this directory as your working directory in R and source the script with 


```{r}
source("run_analysis.R")
```

then call it with

```{r}
run_analysis()
```


The results of the analysis can be read back into R with the read.table function (specify header=TRUE). So, for instance, from your working directory the data can be read into a data frame called "data" using the following:

```{r}
data<-read.table("phoneDataMeans.txt", header=TRUE)
```
