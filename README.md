---
title: "Course Project - Get and Clean Data"
author: "Donny Richmond"
date: "16 April 2016"
output: html_document
---

##The course project has the following requirements:
-  The submitted data set is tidy.
-  The Github repo contains the required scripts.
-  GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
-  The README that explains the analysis files is clear and understandable.
-  The work submitted for this project is the work of the student who submitted it.

The data set is taken from the following location:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Data Set Summary
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data

The output of script produces a TXT file which calculates t mean of all 'feature' variable by subject & activity.  The table is a data frame of dimension (180 x 68)

Here is a subset of the summary data showing the first four columns (64 feature variables in total):

| subject | activity     | tBodyAccmeanX | tBodyAccmeanY |
|---------|--------------|---------------|---------------|
| 1       | laying       | 0.221598244   | -0.040513953  |
| 1       | sittng       | 0.261237565   | -0.001308288  |
| 1       | standing     | 0.278917629   | -0.01613759   |
| 1       | walking      | 0.277330759   | -0.017383819  |
| 1       | walking_down | 0.28918832    | -0.009918505  |
| 1       | walking_up   | 0.25546169    | -0.023953149  |
| 2       | laying       | 0.281373404   | -0.01815874   |
| 2       | sittng       | 0.277087352   | -0.015687994  |
| 2       | standing     | 0.277911472   | -0.018420827  |
| 2       | walking      | 0.276426586   | -0.01859492   |
| 2       | walking_down | 0.277615348   | -0.022661416  |
| 2       | walking_up   | 0.24716479    | -0.021412113  |


## Codebook
A Codebook with a list of feature variables and more detailed description can be found at,
https://github.com/richmodo/GetAndCleanData---CourseProject/blob/master/Samsung%20Data%20Codebook.pdf


