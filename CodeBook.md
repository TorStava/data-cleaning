# CodeBook

This CodeBook describes the data gathering and cleaning process performed for the Coursera Getting and Cleaning Data Course assignment.

## Dataset description
The dataset used in the assignment is the "Human Activity Recognition Using Smartphones Dataset, Version 1.0", by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, and Luca Oneto from the Smartlab - Non Linear Complex Systems Laboratory, Università degli Studi di Genova.

The dataset contains data from experiments carried out with a group of 30 volunteers aged 19-48 years. The volunteers performed six activities while wearing a smartphone on the waist. Using the smartphone accelerometer and gyroscope data from 3-axial linear acceleration and 3-axial angular velocity was recorded.

## Getting the data
The dataset was downloaded from the link provided in the assignment:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The `run_analysis.R` script will unpack the zip-file automatically into a subdirectory named `data`.

## Loading the activity labels and features
The activity labels are loaded from the text file `activity_labels.txt` into the data table `activityLabels`, and the observation features are loaded from the text file `features.txt` into the table `features`.

## Selecting and cleaning feature names
A logical vector, `selectedFeatures`, is created based on the named observation features in the table `features`, where all features containing the text '-mean' or '-std' are matched and set as TRUE in the logical vector. 

## Loading the datasets
The script will automatically load the training and test datasets into the tables. The XTrain and XTest datasets are only populated with the selected features as determined by the logical vector `selectedFeatures` which is used as index.
- XTrain
- yTrain
- subjectTrain
- XTest
- yTest
- subjectTest

## Merging the datasets
The loaded sets of data tables are then combined column-wise using `cbind` so that we end up with two tables, `trainSet` and `testSet`. Each table contains the subject, y, and X- data for training and test data respectively. The two tables are then combined by `rbind` into a new table `mergedSet`.

## Setting column names
The first two columns of the merged table is set to 'Subject' and 'Activity', while the names for the remaining feature columns are set by extracting the selected names from the `features` table, indexed by the `selectedFeatures` logical vector. The feature column names are cleaned up by removing hyphens and parantheses before setting the column names.

## Creating factors
The 'Subject' and 'Activity' columns are then converted into factors. The activity factors are loaded from the `activityLabels` table.

## Melting and dcasting
In order to create a new tidy table containing the mean of the factors for each subject and activity, the dataset is first melted using the 'Subject' and 'Activity' columns as IDs. The melted dataset is then `dcast`ed into a final tidy data table with the calculated mean for all the Subject and Activity combinations.

## Writing the table to file
The final and tidy table is then written to a text file, `tidy.txt`, using the option `row.names = FALSE`.
