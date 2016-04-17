## Tidy Data Assignment (Week 4), Getting and Cleaning Data

# load library to used dplyr, plyr, data.table functions
library(dplyr)
library(plyr)
library(data.table)

# creates a 'Data' subdirectory if none exists
mainDir <- "C:/Users/User/Google Drive/Coursera/GetandClean"
subDir <- "Data"

if (file.exists(subDir)){
  setwd(file.path(mainDir))
} else {
  dir.create(file.path(mainDir, subDir))
  setwd(file.path(mainDir))
}

# URL of machine learning file to download
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# file name and destination
destfile <-  file.path(subDir, "data.zip")

# check if downloaded file already exists,others download
if (file.exists(destfile)) {
} else {
  download.file(url, destfile)
}




# set the file paths of each test and training data set following zip extraction
featuresdir <- "./data/UCI HAR dataset"
testdatadir <- "./data/UCI HAR dataset/Test"
traindatadir <- "./data/UCI HAR dataset/Train"

features_path <- file.path(featuresdir,"features.txt" )

test_label_path <- file.path(testdatadir,"y_test.txt" )
test_data_path <-  file.path(testdatadir,"X_test.txt" )
test_subject_path <- file.path(testdatadir,"subject_test.txt")

train_label_path <- file.path(traindatadir,"y_train.txt" )
train_data_path <-  file.path(traindatadir,"X_train.txt" )
train_subject_path <- file.path(traindatadir,"subject_train.txt")

# the variables ('features') and activity labels are not included in the respectiveve data sets
# as such a data frames from each of the critical TXT files is created
df_features <-  read.table(features_path, header = FALSE, sep = "")


df_test_label <- read.table(test_label_path, header = FALSE, sep = "")
df_test_data <- read.table(test_data_path, header = FALSE, sep = "")
df_test_subject <- read.table(test_subject_path, header = FALSE, sep = "")


df_train_label <- read.table(train_label_path, header = FALSE, sep = "")
df_train_data <- read.table(train_data_path, header = FALSE, sep = "")
df_train_subject <- read.table(train_subject_path, header = FALSE, sep = "")

# Step 1 - create a complete data set for the 'TEST' group of volunteers
# add 'feature' column names to test_data set by transposing the 'features' data frame
# the colnames command satisfies project requirement #4 (descriptive variables names)
colnames(df_test_data) <- df_features[ ,2]

# bind activity and subject column to the test_data set
df_test_data <- cbind(activity = df_test_label[,1], subject = df_test_subject[,1], df_test_data)


# Step 2 - create a complete data set for the 'TRAIN' group of volunteers
# add 'feature' column names to test_data set by transposing the 'features' data frame
# the colnames command satisfies project requirement #4 (descriptive variables names)
colnames(df_train_data) <- df_features[ ,2]


# bind activity and subject columns to the train_data set
df_train_data <- cbind(activity = df_train_label[,1], subject = df_train_subject[,1], df_train_data)


# Step 3 - merge the data sets to satisfy project requirement #1
# merge data now that the variable names match for each data set, rows are bind together for total of 10,299 observations
df_all_data <- rbind(df_test_data, df_train_data)


# Step 4 - Create data set of only the 'mean' and std' variables to satisfy requirement # 2
# Note:  some variable names are not unique, so I have removed duplicates since they are not
# associated with the variables of interest
# if duplicates are not removed the select function will result in errors
filtered_data <- df_all_data[ !duplicated(names(df_all_data)) ]
#filtered_data <- select(filtered_data, activity, subject, matches("(mean|std)\\(.*\\)"))
filtered_data <- select(filtered_data, activity, subject, matches("(mean|std)"))
filtered_data <- select(filtered_data, everything(), -starts_with("angle"))

# rename column names to make more readable
colnames(filtered_data) <- gsub("[()-]", "", colnames(filtered_data))
colnames(filtered_data) <- gsub("-mean", "Mean", colnames(filtered_data))
colnames(filtered_data) <- gsub("-std", "Std", colnames(filtered_data))


# Step 5 - Add descriptive activity names as per requirement #3
filtered_data$activity <- mapvalues(filtered_data$activity, from = c("1", "2", "3", "4", "5", "6"), to = c("walking", "walking_up", "walking_down", "sittng", "standing", "laying"))


# reshape data from wide to long
data_melted <- melt(filtered_data, id.vars = c("subject", "activity"), variable.name = "feature")

# compute the average by subject and activity to satisfy project requirement #5
summary_df <- dcast(data_melted, subject + activity ~ feature, mean)


#write ouput table as TXT file
write.table(summary_df, file = "tidydata.txt", row.name=FALSE, quote = FALSE)




