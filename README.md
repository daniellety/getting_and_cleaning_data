Getting and Cleaning Data Course Project

This aims to show the ability to collect, work with, and clean datasets.

After downloading the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
Generally, it will do the following:
1. Merge the training and test sets found in the downloaded file.
2. Extract only the mean and standard deviation for each measurement.
3. Label the variable names appropriately.
4. Create a second, independent tidy data set that computes the average of each variable for each activity and each subject.


The run_analysis.r script does the following:
1. Download the dataset if it is not in the working directory. Once downloaded, unzip it.
2. Load the activity label and feature information but only keeping those columns that have mean or standard deviation.
3. Load the training and test datasets from the downloaded file.
4. Merge the activity and subject data with the selected columns from #2.
5. Create another dataset that computes the mean of the measurements from the created dataset and it will be written to 'tidy.txt'.
