## GCD Project
## 1.  Merge train and test data sets and create one set

setwd("C:/Users/rubina/Desktop/R/Class/GCD/UCI HAR Dataset")

testSub <- read.table("./test/subject_test.txt", header = T, sep = "")
testX <- read.table("./test/X_test.txt", header = T, sep = "")
testy <- read.table("./test/y_test.txt", header = T, sep = "")

trainSub <- read.table("./train/subject_train.txt", header = T, sep = "")
trainX <- read.table("./train/X_train.txt", header = T, sep = "")
trainy <- read.table("./train/y_train.txt", header = T, sep = "")

features <- read.table("./features.txt")
activityLabels <- read.table("./activity_labels.txt")

colNames <- gsub("[[:punct:]]","", features$V2, ignore.case = FALSE, perl = FALSE)
colnames(testX) <- colNames
colnames(trainX) <- colNames

colnames(testSub) <- "Subject"
colnames(trainSub) <- "Subject"

colnames(testy) <- "Activity"
colnames(trainy) <- "Activity"

# Merge the test and train subject datasets
testsComplete <- cbind(testSub, testy,testX)
trainComplete <- cbind(trainSub,trainy,trainX)
allData <- rbind(trainComplete,testsComplete)

# Merge the test and train activity labels datasets
## 3.  Descriptive activity names
## 4.  Label the data set with descriptive variable names

# Merge all three datasets
meanstdData <- allData[, grep("mean|std|Subject|Activity", names(allData))]
labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
meanstdData$Activity <- labels[meanstdData$Activity]

## 2.  Extract measurments on mean and standard deviation
# Create a smaller dataset containing only the mean and std variables
#meanstdData <- allData[, grep("mean|std|Subject|Activity", names(allData))]

## 5.  Create second tidy data set with average of each variable for each activity and subject
# Compute the average(mean), grouped by subject, label
melted = melt(meanstdData, id.var = c("Subject", "Activity"))
means = dcast(melted, Subject + Activity ~ variable, mean)

# Output final dataset
means

# Save the resulting dataset
write.table(means, file="tidy_data.txt", row.name=FALSE)

## 6.  Upload to GitHub