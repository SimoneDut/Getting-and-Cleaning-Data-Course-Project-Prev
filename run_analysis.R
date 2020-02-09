library(dplyr)
library(reshape2)

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fileName <- "HAR_Dataset.zip"

# Downloading and unzipping the raw data file, if necessary

if (!file.exists(fileName)) {
  print("Downloading the zip file...")
  download.file(fileUrl, destfile = fileName, method = "curl")
  unzip(fileName)
  }

# Reading the files

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

# 1. Merge the training and the test sets to create one data set

tidyDataSet1 <- rbind(cbind(subject_train, X_train, y_train),cbind(subject_test, X_test, y_test))
colnames(tidyDataSet1) <- c("subject", as.character(features[, 2]), "activity")

# 2. Extract only the measurements on the mean and standard deviation for each measurement (plus subject and activity)

tidyDataSet1 <- tidyDataSet1[, c(1, grep("mean\\(\\)|std\\(\\)", colnames(tidyDataSet1)), ncol(tidyDataSet1))]

# 3. Use descriptive activity names to name the activities in the data set

tidyDataSet1$activity <- activity_labels[tidyDataSet1$activity, 2]

# 4. Appropriately labels the data set with descriptive variable names

colnames(tidyDataSet1) <- gsub("BodyBody", "Body", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("^t", "time", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("^f", "frequency", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("Body", " body", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("Gravity", " gravity", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("Acc", " accelerometer", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("Gyro", " gyroscope", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("Jerk", " jerk", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("Mag", " magnitude", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("-mean\\(\\)", " mean", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("-std\\(\\)", " standard deviation", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("-X", " X", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("-Y", " Y", colnames(tidyDataSet1))
colnames(tidyDataSet1) <- gsub("-Z", " Z", colnames(tidyDataSet1))

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

tidyDataSet2 <- tidyDataSet1 %>%
  melt(id = colnames(tidyDataSet1)[c(1,ncol(tidyDataSet1))], measure.vars = colnames(tidyDataSet1)[-c(1,ncol(tidyDataSet1))]) %>%
  dcast(subject + activity ~ variable, mean)

# Output the final data set

write.table(tidyDataSet2, file = "output.txt", row.name = FALSE)