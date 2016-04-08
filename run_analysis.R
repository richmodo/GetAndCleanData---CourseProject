## Tidy Data Assignment (Week 4), Getting and Cleaning Data

# load library to used dplyr, plyr functions
library(dplyr)
library(plyr)

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
train_label_path <- file.path(traindatadir,"y_train.txt" )
train_data_path <-  file.path(traindatadir,"X_train.txt" )

# the variables ('features') and activity labels are not included in the respectiveve data sets
# as such a data frames from each of the critical TXT files is created
df_features <-  read.table(features_path, header = FALSE, sep = "")
df_test_label <- read.table(test_label_path, header = FALSE, sep = "")
df_test_data <- read.table(test_data_path, header = FALSE, sep = "")
df_train_label <- read.table(train_label_path, header = FALSE, sep = "")
df_train_data <- read.table(train_data_path, header = FALSE, sep = "")


# Step 1 - create a complete data set for the 'TEST' group of volunteers
# add 'feature' column names to test_data set by transposing the 'features' data frame
# the colnames command satisfies project requirement #4 (descriptive variables names)
colnames(df_test_data) <- df_features[ ,2]

# bind activity column to the test_data which has (activity codes: 1 through 6)
df_test_data <- cbind(activity = df_test_label[,1], df_test_data)

# add column to include a reference to which subject/group("TEST" or "TRAIN")
df_test_data <- cbind(group = "TEST", df_test_data)


# Step 2 - create a complete data set for the 'TRAIN' group of volunteers
# add 'feature' column names to test_data set by transposing the 'features' data frame
# the colnames command satisfies project requirement #4 (descriptive variables names)
colnames(df_train_data) <- df_features[ ,2]

# bind activity column to the train_data which has (activity codes: 1 through 6)
df_train_data <- cbind(activity = df_train_label[,1], df_train_data)

# add column to include reference to which group("TEST" or "TRAIN")
df_train_data <- cbind(group = "TRAIN", df_train_data)


# Step 3 - merge the data sets to satisfy project requirement #1
# merge data now that the variable names match for each data set, rows are bind together for total of 10,299 observations
df_all_data <- rbind(df_test_data, df_train_data)


# Step 4 - Create data set of only the 'mean' and std' variables to satisfy requirement # 2
# Note:  some variable names are not unique, so I have removed duplicates since they are not
# associated with the variables of interest
# if duplicates are not removed the select function will result in errors
filtered_data <- df_all_data[ !duplicated(names(df_all_data)) ]
filtered_data <- select(filtered_data, group, activity, matches("(mean|std)\\(.*\\)"))




# Step 5 - Add descriptive activity names as per requirement #3
filtered_data$activity <- mapvalues(filtered_data$activity, from = c("1", "2", "3", "4", "5", "6"), to = c("walking", "walking_up", "walking_down", "sittng", "standing", "laying"))


# used ddply function to calculate average by activity, also added 'group' column to the first column because it was removed by merge
test_summary <- filter(filtered_data, group == "TEST")
test_summary <- ddply(test_summary,.(activity),numcolwise(mean,na.rm = TRUE))
test_summary <- mutate(test_summary, group = "TEST" )


train_summary <- filter(filtered_data, group == "TRAIN")
train_summary <- ddply(train_summary,.(activity),numcolwise(mean,na.rm = TRUE))
train_summary <- mutate(train_summary, group = "TRAIN" )


# created independent data set to satisfy project requirement #5
summary_df <- rbind(test_summary, train_summary)
summary_df <- summary_df %>% select(group, everything())

#write ouput table as TXT file
write.table(summary_df, file = "summary_mean.txt", row.name=FALSE)


## WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
#colnames(df_features) <- c("num","feature")
#df_features <- df_features[ ,c("feature"), drop = FALSE]
#colnames(df_test_data) <- c("walk", "walkup", "walkdown", "sit", "stand", "lay")




