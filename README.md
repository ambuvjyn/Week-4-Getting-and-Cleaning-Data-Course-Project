# **Getting and Cleaning Data Course Project**

This project is part of Getting and Cleaning Data Course Project.

This repo has -

-   CodeBook.md :

    -   The code book describes the variables, the data, and any transformations or work that was performed to clean up the data.

-   run_analysis.R

    -   The R script which has 15 sections to process the data and create tidydata.txt.

-   tidydata.txt

    -   The final tidy data that was created based on instructions of this project.

-   README.md

    -   Which is this file you are currently viewing.

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here is the link for the data for this project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The R script called run_analysis.R that does the following 15 steps :

1.  Downloading the data from link provided using curl
2.  Extracting the data from UCI_HAR_Dataset.zip using unzip
3.  List all files in the working Directory including this R file
4.  Reading Training and Test Data from UCI_HAR_Dataset
    -   *Reading Training datasets*

    -   *Reading Test datasets*

    -   *Reading Features*

    -   *Read Activity labels*
5.  Reading Training and Test Data from UCI_HAR_Dataset
    1.  *Reading Training datasets*

    2.  *Reading Test datasets*

    3.  *Reading Features*

    4.  *Read Activity labels*
6.  Merging Training and Test Data from UCI_HAR_Dataset (I)
7.  Merging All Training and All Test Data from UCI_HAR_Dataset
8.  Adding Column names to Merged_Dataset from Features
9.  Extracting only columns with mean and standard deviation (II)
10. Subsetting Merged_Dataset to Filtered_Merged_Dataset
11. Assigning factor levels to activity values (III)
12. summary of Activity in Filtered Merged Dataset
13. Tidying up Column Names (IV)
14. Aggregating the seconds tidy data (V)
15. Exporting tidySet to a text file

The major 5 steps needed for the result are tagged as :

-   I. Merges the training and the test sets to create one data set.

-   II\. Extracts only the measurements on the mean and standard deviation for each measurement.

-   III\. Uses descriptive activity names to name the activities in the data set

-   IV\. Appropriately labels the data set with descriptive variable names.

-   V. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
