# Getting and Cleaning Data Course Project
## Russell Greene - March 2016

### Scripts

There is only one script used in this project: **run_analysis.R**

The script uses *relative* paths which means that it expects to be run in the top level directory which contains the **UCI HAR Dataset** subdirectory.  File names will not be found if it is run anywhere else.

The script will:
* Read in the features.txt file
* Make those column names r friendly
* Read in the training and test data sets

At that point it will completed part 4 of the assignment and put those clean feature names into the column names of the data frame.

It then:
* Merges the training and test data sets into a single dataframe (Part 1)
* Extracts only the mean and stddev and saves them into another dataframe (Part 2)
* Replaces the activity numbers with factor names (Part 3)
* And finally converts the data frame into a datatable and computes the mean of all features grouped by subject and activity using lapply.
