# Getting and Cleaning Data Course Project

This is the final, peer-graded, course project in the Coursera Getting and Cleaning Data Course Project, as a part of the Data Scientist Specialization.

Files included in this repository:

- `CodeBook.md` - Description of the data and data cleaning performed
- `README.md` - The file you're currently reading
- `run_analysis.R` - Script that will download, clean, and manipulate the data
- `tidy.txt` - The resulting data after running the `run_analysis.R` script

Running the `run_analysis.R` script will perform the following actions:
1. Download and unpack the datafiles if they don't already exist.
2. Load and merge the training and the test sets to create one data set.
3. Extract the mean and standard deviation for each measurement.
4. Set up descriptive activity names by using factors.
5. Appropriately labels the data set with descriptive variable names.
6. From the data set in step 5, create a second, independent tidy data set (`tidy.txt`) with the average of each variable for each activity and each subject.
