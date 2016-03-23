# Getting and Cleaning Data Course Project
## Codebook
### Russell Greene - March 2016

#### Variables

* featuresDF: A dataframe that contains the features read in from the features.txt file
* trainingDF: A dataframe that contains the training data read in from X_train.txt, y_train.txt, and subject_train.txt
* testingDF: A dataframe that contains the testing data read in from X_test.txt, y_test.txt, and subject_test.txt
* totalDF: A dataframe containing the training and testing data merged together
* meanstdDF: A dataframe containing only the mean and standard deviation for each measurement
* subjectActivityMeanDT: A datatable containing the mean of the features grouped by subject and activity

#### Data

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 



#### Transformations

##### Reading in Data
* The features were read in and then cleaned up using gsub.  All non *R friendly* characters were replaced by underscores.
* The training and testing datasets were read in and then merged into a single dataframe.  The column names were replaced by the cleaned feature names.

##### Merging training and test feature data sets
* Using the rbind command the trainingDF and testingDF dataframes were combined into the totalDF

##### Extracting mean and standard deviation measurements
* Using grep within the totalDF dataframe, the columns matching mean and std were pulled out and saved into the meanstdDF dataframe

##### Adding descriptive activity names
* Using the factor command, the activity numbers were converted into activity names and saved back into the totalDF dataframe.

##### Create another tidy data set with average of each variable for each activity and subject
* The totalDF dataframe was converted into a datatable.  AT which point lapply was used to compute the mean over all of the features (taken from the featuresDF dataframe), grouped by the subject and activityName columns.
* The results were saved to a new datatable subjectActivityMeanDT