
##############Downloading the data from link provided using curl################

UCI_HAR_Dataset_Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(UCI_HAR_Dataset_Url,destfile="./UCI_HAR_Dataset.zip",method="curl")

################################################################################

#############Extracting the data from UCI_HAR_Dataset.zip using unzip###########

unzip(zipfile="./UCI_HAR_Dataset.zip",exdir="./")

################################################################################

###########List all files in the working Directory including this R file########

list.files('./', recursive=TRUE)

################################################################################

##############Reading Training and Test Data from UCI_HAR_Dataset###############

#Reading Training datasets
X_Training_Values <- read.table("./UCI HAR Dataset/train/X_train.txt",header = FALSE)
Y_Training_Activity <- read.table("./UCI HAR Dataset/train/y_train.txt",header = FALSE)
Training_Subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",header = FALSE)

#Reading Test datasets
X_Test_Values <- read.table("./UCI HAR Dataset/test/X_test.txt",header = FALSE)
Y_Test_Activity <- read.table("./UCI HAR Dataset/test/y_test.txt",header = FALSE)
Test_Subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",header = FALSE)

#Reading Features
Features <- read.table("./UCI HAR Dataset/features.txt",head=FALSE)

#Read Activity labels
Activities <- read.table("./UCI HAR Dataset/activity_labels.txt",head=FALSE)
colnames(Activities) <- c("activity_ID", "activity_Type")

################################################################################

##############Reading Training and Test Data from UCI_HAR_Dataset###############

#Reading Training datasets
X_Training_Values <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_Training_Activity <- read.table("./UCI HAR Dataset/train/y_train.txt")
Training_Subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")

#Reading Test datasets
X_Test_Values <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_Test_Activity <- read.table("./UCI HAR Dataset/test/y_test.txt")
Test_Subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")

#Reading Features
Features <- read.table("./UCI HAR Dataset/features.txt")

#Read Activity labels
Activities <- read.table("./UCI HAR Dataset/activity_labels.txt")
colnames(Activities) <- c("activity_ID", "activity_Type")

################################################################################

##############Merging Training and Test Data from UCI_HAR_Dataset###############

All_Training <- cbind(Training_Subjects, X_Training_Values, Y_Training_Activity)
All_Test <- cbind(Test_Subjects, X_Test_Values, Y_Test_Activity)

################################################################################

###########Merging All Training and All Test Data from UCI_HAR_Dataset##########

Merged_Dataset <- rbind(All_Training, All_Test)

################################################################################

###############Adding Column names to Merged_Dataset from Features##############

colnames(Merged_Dataset) <- c("subject", Features[, 2], "activity")

################################################################################

###########Extracting only columns with mean and standard deviation#############
#######Subject and activity columns are also filtered along with the data#######

sub_act_mean_std_col <- grepl("subject|activity|mean|std", colnames(Merged_Dataset))

################################################################################

##########Subsetting Merged_Dataset to Filtered_Merged_Dataset##################

Filtered_Merged_Dataset <- Merged_Dataset[, sub_act_mean_std_col]

################################################################################

##################Assigning factor levels to activity values####################

Filtered_Merged_Dataset$activity <- factor(Filtered_Merged_Dataset$activity, 
                                 levels = Activities$activity_ID, labels = Activities$activity_Type)

################################################################################

################summary of Activity in Filtered Merged Dataset##################

summary(Filtered_Merged_Dataset$activity)

################################################################################

############################Tidying up Column Names#############################

Filtered_Merged_Dataset_Cols <- colnames(Filtered_Merged_Dataset)

original_terms <- c("Acc", "Gyro", "BodyBody", "Mag", "^t", "^f", "tBody", "-mean", "-std", "Freq", "angle", "gravity", "[\\(\\)-]")
replaced_terms <- c("Accelerometer", "Gyroscope", "Body", "Magnitude", "Time", "Frequency", "TimeBody", "Mean", "StandardDeviation", "Frequency", "Angle", "Gravity", "")

for (i in 1:length(original_terms)) {
  Filtered_Merged_Dataset_Cols <- gsub(original_terms[i], replaced_terms[i], Filtered_Merged_Dataset_Cols)
}

colnames(Filtered_Merged_Dataset) <- Filtered_Merged_Dataset_Cols
################################################################################

#####################Aggregating the seconds tidy data##########################

tidydata <- aggregate(. ~subject + activity, Filtered_Merged_Dataset, mean)
tidydata <- tidySet[order(tidySet$subject, tidySet$activity), ]

################################################################################


######################Exporting tidySet to a text file##########################

write.table(tidydata, "tidydata.txt", row.names = FALSE)

################################################################################