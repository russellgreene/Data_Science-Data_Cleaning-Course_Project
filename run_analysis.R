##
## Part 4: Appropriately labels the data set with descriptive variable names
##

## Note that it is easiest to give dataset descriptive variable names
## at the time it is read in so I do Part 4 first.


## Read in the list of features
featuresFileName <- 'UCI HAR Dataset/features.txt'
featuresDF <- read.table(featuresFileName, stringsAsFactors = FALSE)
colnames(featuresDF) <- c('featurenum', 'featurename')

## Clean up feature names
featuresDF$featurename <- gsub("\\(\\)", "", featuresDF$featurename)
featuresDF$featurename <- gsub(",", "_", featuresDF$featurename)
featuresDF$featurename <- gsub("-", "_", featuresDF$featurename)
featuresDF$featurename <- gsub("\\(", "_", featuresDF$featurename)
featuresDF$featurename <- gsub("\\)", "", featuresDF$featurename)

## Read in the training set
trainingFileName <- 'UCI HAR Dataset/train/X_train.txt'
trainingDF <- read.table(trainingFileName)
colnames(trainingDF) <- featuresDF$featurename
trainingSubjectFileName <- 'UCI HAR Dataset/train/subject_train.txt'
activityNumFileName <- 'UCI HAR Dataset/train/y_train.txt'
trainingDF["activityNum"] <- read.table(activityNumFileName)
trainingDF["subject"] <- read.table(trainingSubjectFileName)

## Read in the test set
testingFileName <- 'UCI HAR Dataset/test/X_test.txt'
testingDF <- read.table(testingFileName)
colnames(testingDF) <- featuresDF$featurename
testingSubjectFileName <- 'UCI HAR Dataset/test/subject_test.txt'
activityNumFileName <- 'UCI HAR Dataset/test/y_test.txt'
testingDF["activityNum"] <- read.table(activityNumFileName)
testingDF["subject"] <- read.table(testingSubjectFileName)


##
## Part 1: Merge training and test feature data sets 
##


## merge the training and test tables
totalDF <- rbind(trainingDF, testingDF)


##
## Part 2: Extract mean and standard deviation measurements
##
meanstdDF <- totalDF[,grep("mean|std", colnames(totalDF))]


##
## Part 3: Use descriptive activity names
##
totalDF['activityName'] <- factor(totalDF$activityNum,
                                  labels=c('WALKING', 'WALKING_UPSTAIRS',
                                      'WALKING_DOWNSTAIRS', 'SITTING',
                                      'STANDING', 'LAYING'))


##
## Part 5: From the data set in step 4, creates a second, independent
##         tidy data set with the average of each variable for each
##         activity and each subject.
##

## Convert to data table
library(data.table)
totalDT <- data.table(totalDF)

## Use lapply to apply the mean function to all of the feature cols
## grouped by subject and activity
subjectActivityMeanDT <- totalDT[,lapply(.SD, mean, na.rm=TRUE),
                                 by=list(subject,activityName),
                                 .SDcols=featuresDF$featurename]
