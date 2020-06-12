Getting and Cleaning Data Course Project - Final Course Assignment
==================================================================

This repository has R code , documentation and data related to the week4 Getting and Cleaning Data Course Project. 

The repository includes the following files and folders:
-------------------------------------------------------

- 'ReadMe.md' 

- 'CodeBook.md' - Describes the code in R scipt 'run_analysis.md',changes made on data set, the input and the output obtained

- 'run_analysis.R' - R code to be executed. This file contains the complete code to process the data.

- 'tidySet.txt' - Tidy summary data obtained from the data in 'UCI HAR Dataset' folder using run_analysis.R'

- 'UCI HAR Dataset'-  Source folder of data set processed. README.txt in folder give information on subfolders and files.

'run_analysis.R' -R Code:
-------------------------
- Download the file - Handles the file download from URL
- Unzip the file - Unzip the downloaded file and store the folder
- Identify path and files - Check the downloaded folder and subfolders for file and record path for later reference
- Merging data set - Combines the different files in the 'test' and 'train' folders to form a single data set
- Extracting only the measurements on the mean and standard deviation for each measurement. - Columns are selected to form new data table
- Using descriptive activity names to name the activities in the data set - Columns are labeled and activity table is created
- Labeling the data set with descriptive variable names - New column added with activities and all columns are labeled.
- Output as a tidy data set with the average of each variable for each activity and each subject- Mean taken after grouping, sorted and printed.
