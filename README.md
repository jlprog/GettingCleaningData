Tidy Data Set of HAR
====================

This repositary is created for the course porject of Getting and Cleanning Data course and includes the following files:
- run_analysis.R
- codebook.md
- HAR_summary.txt

This project aims to prepare a tidy data that can be used for later analysis.

## Dataset 

The data set is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## [run_analysis.R](https://github.com/jlprog/GettingCleaningData/blob/master/run_analysis.R)

The R script does the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The output is [HAR_tidydata.txt] displaying a tidy data set. 

The run_analysis.R script is well-documented and there are in-line comments which explain each step taken to transform the data.

## [codebook.md](https://github.com/jlprog/GettingCleaningData/blob/master/codebook.md)

The codebook describes each variable and its values in HAR_tidydata.txt.  
