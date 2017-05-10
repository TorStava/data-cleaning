###############################################
## Coursera - Getting and Cleaning Data
## Week 4 assignment
## 
## Date: 2017-05-09
## Author: Tor Olav Stava
###############################################

# Define variables
startDir <- getwd()
dataDir <- "data"
downloadUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- paste(dataDir, "getdata-projectfiles-UCI-HAR-Dataset.zip", sep = "/")
unZipDir <- paste(dataDir, "UCI HAR Dataset", sep = "/")

# Create data directory if it doesn't exist.
if(!file.exists(dataDir)) {dir.create(dataDir)}

# Download the datafile if it doesn't exist.
if(!file.exists(fileName)) {download.file(downloadUrl, fileName)}

# Unzip the files if the subdir doesn't already exist
if(!file.exists(unZipDir)) {unzip(fileName, exdir = dataDir)}

# Set the workdir to the extracted subdirectory
setwd(unZipDir)

# Read the table of features
features <- read.table("features.txt", stringsAsFactors = FALSE)

# Read the activity labels
activityLabels <- read.table("activity_labels.txt", stringsAsFactors = FALSE)

# Create a logical vector of the observations wanted
selectedFeatures <- grepl("*.mean.*|*.std.*", features[,2])

# Load and merge the training set
XTrain <- read.table("train/X_train.txt")[selectedFeatures]
yTrain <- read.table("train/y_train.txt")
subjectTrain <- read.table("train/subject_train.txt")
trainSet <- cbind(subjectTrain, yTrain, XTrain)

# Load the test set
XTest <- read.table("test/X_test.txt")[selectedFeatures]
yTest <- read.table("test/y_test.txt")
subjectTest <- read.table("test/subject_test.txt")
testSet <- cbind(subjectTest, yTest, XTest)

# Merge the training and test datasets
mergedSet <- rbind(trainSet, testSet)

# Load the 'dplyr' package to access the pipe '%>%' operator
library(dplyr)

# Clean up and set descriptive column names
activityNames <- features[,2][selectedFeatures] %>%
        gsub(pattern = '-mean', replacement = 'Mean') %>%
        gsub(pattern = '-std', replacement = 'Std') %>%
        gsub(pattern = '[-()]', replacement = '')
colnames(mergedSet) <- c("Subject", "Activity", activityNames)

# Making factors of Subject and Activity columns
mergedSet$Subject <- as.factor(mergedSet$Subject)
mergedSet$Activity <- factor(mergedSet$Activity,
        levels = activityLabels[,1],
        labels = activityLabels[,2])

# Loading the 'data.table' package to access the melt method
library(data.table)

# Melting the dataset on the keys "Subject" and "Activity"
meltedSet <- melt(mergedSet, id = c("Subject", "Activity"))

# Creating a new tidy dataset with the mean of the variables
newDataSet <- dcast(meltedSet, Subject + Activity ~ variable, mean)

# Saving the new dataset to a file
setwd(startDir)
write.table(newDataSet, "tidy.txt", row.names = FALSE, quote = FALSE)

