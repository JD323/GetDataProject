---
title: "Codebook for run_analysis.R"
author: "John Darling"
date: "Wednesday, July 22, 2015"
output: html_document
---

The data utilized in this analysis derives from a study on human activity monitoring using smartphones conducted at the University of California Irvine Center for Machine Learning and Intelligent Systems. More information on the study that generated the data can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The data files themselves can be downloaded here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The run_analysis.R script reads the appropriate data from these files and creates a data frame attaching subject and activity IDs to data for each feature of the smartphone measurements, and identifies data as deriving from the test or the training dataset. Only the mean and standard deviation data (66 variables) are extracted from the overall smartphone dataset. The script also identifies activities by name and generates more readable variable names based information provided by UCI in the features.txt file accompanying the data. 

Seventeen feautures from the UCI dataset were used in this analysis:

UCI feature code  |     "Readable" feature name
----------------- | -------------
tBodyAcc-XYZ      |     body acceleration 
tGravityAcc-XYZ   |	gravity acceleration
tBodyAccJerk-XYZ  |	body acceleration jerk
tBodyGyro-XYZ     |	body gyroscope
tBodyGyroJerk-XYZ |	body gyroscope jerk
tBodyAccMag	      |	body acceleration magnitude
tGravityAccMag    |	gravity acceleration magnitude
tBodyAccJerkMag   |	body acceleration jerk magnitude
tBodyGyroMag      |	body gyroscope magnitude
tBodyGyroJerkMag  |	body gyroscope jerk magnitude
fBodyAcc-XYZ      |	transformed body acceleration
fBodyAccJerk-XYZ  |	transformed body acceleration jerk
fBodyGyro-XYZ     |	transformed body gyroscope
fBodyAccMag	      |	transformed body acceleration magnitude
fBodyAccJerkMag   |	transformed body acceleration jerk magnitude
fBodyGyroMag      |	transformed body gyroscope magnitude
fBodyGyroJerkMag  |	transformed body gyroscope jerk magnitude

The column on the left is derived from the UCI features_info.txt file, and the column on the right indicates the associated "readable"  names used in the processed dataset. Features represented above with an -XYZ suffix represent three different signals, one each measured on the X, Y and Z axis. "Transformed" indicates that the signal has been Fast Fourier Transformed as described in the features_info file. The total number of signals is thus 33 (17 feautures, 8 of which are measured in 3 dimensions). For each of these signals, UCI estimated a number of variables; for this analysis, only the mean and standard deviations were extracted. The final dataset has mean and standard deviation estimates for all 33 signals, resulting in a total of 66 variables. Along with the feature from which they are derived, variable names indicate the specified axis ("on xaxis", "on yaxis" or "on zaxis") and also whether the variable is derived from the mean or standard deviation estimate. 

The output of the script is a table of means for each of the 66 feature variables, calculated by subject and activity. The output table separates subjects by test and training datasets to facilitate downstream analysis. The final tidy dataset has 180 rows (one observation in each row) in 69 columns. Three columns specify the identification variables: dataset (TEST or TRAIN), subject (1-30), and activity ("walking", "walking upstairs", "walking downstairs", "sitting", "standing" or "laying" [sic]). The remaining 66 columns specify each measurement variable as described above.