# Set your working directory

# Download the dataset if it does not exist in the working directory:
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

# Unzip dataSet to ./data directory
unzip(zipfile="./data/Dataset.zip",exdir="./data")

# Load activity labels and features information
activityLabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("./data/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Keep only the data on mean and standard deviation 
featuresInclude <- grep(".*mean.*|.*std.*", features[,2])
featuresInclude.names <- features[featuresInclude,2]
featuresInclude.names <- gsub('-mean', 'Mean', featuresInclude.names)
featuresInclude.names <- gsub('-std', 'Std', featuresInclude.names)
featuresInclude.names <- gsub('[-()]', '', featuresInclude.names)


# Load the datasets
train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
trainActivities <- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
testActivities <- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge the train and test datasets and add labels
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresInclude.names)

# Change the activities and subjects into factors
allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$subject <- as.factor(allData$subject)

# Create second dataset and compute for the average of the measurements
secData <- aggregate(. ~subject + activity, allData, mean)
secData <- secData[order(secData$subject, secData$activity),]

# Write the calculated tidy dataset into a text file named tidy
write.table(secData, "tidy.txt", row.names = FALSE, quote = FALSE)
