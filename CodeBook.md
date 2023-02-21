## **This work is done by Ambu Vijayan as part of Getting and Cleaning Data Course Project**

The Data for this project can be obtained from : <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

*All the work is carried out in Rstudio*

### About this R script : "run_analysis.R"

This R performs 15 following steps

1.  **Downloading the data from link provided using curl**
2.  **Extracting the data from UCI_HAR_Dataset.zip using unzip**
3.  **List all files in the working Directory including this R file**
4.  **Reading Training and Test Data from UCI_HAR_Dataset**
    -   *Reading Training datasets*

    -   *Reading Test datasets*

    -   *Reading Features*

    -   *Read Activity labels*
5.  **Reading Training and Test Data from UCI_HAR_Dataset**
    1.  *Reading Training datasets*

    2.  *Reading Test datasets*

    3.  *Reading Features*

    4.  *Read Activity labels*
6.  **Merging Training and Test Data from UCI_HAR_Dataset (I)**
7.  **Merging All Training and All Test Data from UCI_HAR_Dataset**
8.  **Adding Column names to Merged_Dataset from Features**
9.  **Extracting only columns with mean and standard deviation (II)**
10. **Subsetting Merged_Dataset to Filtered_Merged_Dataset**
11. **Assigning factor levels to activity values (III)**
12. **summary of Activity in Filtered Merged Dataset**
13. **Tidying up Column Names (IV)**
14. **Aggregating the seconds tidy data (V)**
15. **Exporting tidySet to a text file**

### [**Tree view of UCI HAR Dataset**]{.underline}

UCI HAR Dataset

│ activity_labels.txt

│ features.txt

│ features_info.txt

│ README.txt

├───test

│ │ subject_test.txt

│ │ X_test.txt

│ │ y_test.txt

└───train

│ subject_train.txt

│ X_train.txt

│ y_train.txt

# [Detailed R code explanation]{.underline}

1.  **Downloading the data from link provided using curl**

`UCI_HAR_Dataset_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"`

`download.file(UCI_HAR_Dataset_Url,destfile="./UCI_HAR_Dataset.zip",method="curl")`

2.  **Extracting the data from UCI_HAR_Dataset.zip using unzip**

`unzip(zipfile="./UCI_HAR_Dataset.zip",exdir="./")`

3.  **List all files in the working Directory including this R file**

`list.files('./', recursive=TRUE)`

4.  **Reading Training and Test Data from UCI_HAR_Dataset**

-   *Reading Training datasets*

`X_Training_Values <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)`

`Y_Training_Activity <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)`

`Training_Subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)`

-   *Reading Test datasets*

`X_Test_Values <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)`

`Y_Test_Activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)`

`Test_Subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)`

-   *Reading Features*

`Features <- read.table("./UCI HAR Dataset/features.txt",head=FALSE)`

-   *Read Activity labels*

`Activities <- read.table("./UCI HAR Dataset/activity_labels.txt",head=FALSE)`

`colnames(Activities) <- c("activity_ID", "activity_Type")`

5.  **Reading Training and Test Data from UCI_HAR_Dataset**

-   *Reading Training datasets*

`X_Training_Values <- read.table("./UCI HAR Dataset/train/X_train.txt")`

`Y_Training_Activity <- read.table("./UCI HAR Dataset/train/y_train.txt")`

`Training_Subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")`

-   *Reading Test datasets*

`X_Test_Values <- read.table("./UCI HAR Dataset/test/X_test.txt")`

`Y_Test_Activity <- read.table("./UCI HAR Dataset/test/y_test.txt")`

`Test_Subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")`

-   *Reading Features*

`Features <- read.table("./UCI HAR Dataset/features.txt")`

-   *Read Activity labels*

`Activities <- read.table("./UCI HAR Dataset/activity_labels.txt")`

`colnames(Activities) <- c("activity_ID", "activity_Type")`

6.  **Merging Training and Test Data from UCI_HAR_Dataset**

`All_Training <- cbind(Training_Subjects, X_Training_Values, Y_Training_Activity)`

`All_Test <- cbind(Test_Subjects, X_Test_Values, Y_Test_Activity)`

7.  **Merging All Training and All Test Data from UCI_HAR_Dataset**

`Merged_Dataset <- rbind(All_Training, All_Test)`

8.  **Adding Column names to Merged_Dataset from Features**

`colnames(Merged_Dataset) <- c("subject", Features[, 2], "activity")`

9.  **Extracting only columns with mean and standard deviation**

*Subject and activity columns are also filtered along with the data*

`sub_act_mean_std_col <- grepl("subject|activity|mean|std", colnames(Merged_Dataset))`

10. **Subsetting Merged_Dataset to Filtered_Merged_Dataset**

`Filtered_Merged_Dataset <- Merged_Dataset[, sub_act_mean_std_col]`

11. **Assigning factor levels to activity values**

`Filtered_Merged_Dataset$activity <- factor(Filtered_Merged_Dataset$activity, levels = Activities$activity_ID, labels = Activities$activity_Type)`

12. **summary of Activity in Filtered Merged Dataset**

`summary(Filtered_Merged_Dataset$activity)`

13. **Tidying up Column Names**

`Filtered_Merged_Dataset_Cols <- colnames(Filtered_Merged_Dataset)`

`original_terms <- c("Acc", "Gyro", "BodyBody", "Mag", "^t", "^f", "tBody", "-mean", "-std", "Freq", "angle", "gravity", "[\\(\\)-]")`

`replaced_terms <- c("Accelerometer", "Gyroscope", "Body", "Magnitude", "Time", "Frequency", "TimeBody", "Mean", "StandardDeviation", "Frequency", "Angle", "Gravity", "")`

`for (i in 1:length(original_terms)) {`

`Filtered_Merged_Dataset_Cols <- gsub(original_terms[i], replaced_terms[i], Filtered_Merged_Dataset_Cols)`

`}`

`colnames(Filtered_Merged_Dataset) <- Filtered_Merged_Dataset_Cols`

14. **Aggregating the seconds tidy data**

`tidydata <- aggregate(. ~subject + activity, Filtered_Merged_Dataset, mean)`

`tidydata <- tidySet[order(tidySet$subject, tidySet$activity), ]`

15. **Exporting tidySet to a text file**

`write.table(tidydata, "tidydata.txt", row.names = FALSE)`
