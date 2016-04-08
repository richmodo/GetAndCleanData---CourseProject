---
title: "Course Project - Get and Clean Data"
author: "Donny Richmond"
date: "8 April 2016"
output: html_document
---

The course project has the following requirements:


1)  The submitted data set is tidy.
2)  The Github repo contains the required scripts.
3)  GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
4)  The README that explains the analysis files is clear and understandable.
5)  The work submitted for this project is the work of the student who submitted it.

The data set is taken from the following location:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Set Summary:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data


The output of script produces a TXT file which calculates t mean of all variables by group data set ('test' or 'train') and by activity.  The table is a data frame of dimension (12 x 68), with 66 variables

Here is a subset of the summary data showing the first four columns (64 variables not shown):


| group | activity     | tBodyAcc-mean()-X | tBodyAcc-mean()-Y |
|-------|--------------|-------------------|-------------------|
| TEST  | laying       | 0.2672276         | -0.01824562       |
| TEST  | sittng       | 0.2720398         | -0.01412215       |
| TEST  | standing     | 0.2787912         | -0.01622627       |
| TEST  | walking      | 0.2765264         | -0.01825071       |
| TEST  | walking_down | 0.2880629         | -0.01617515       |
| TEST  | walking_up   | 0.2631264         | -0.02427446       |
| TRAIN | laying       | 0.269191          | -0.01834525       |
| TRAIN | sittng       | 0.273449          | -0.01214261       |
| TRAIN | standing     | 0.2792938         | -0.01612308       |
| TRAIN | walking      | 0.2762602         | -0.01776771       |
| TRAIN | walking_down | 0.2881689         | -0.01637019       |
| TRAIN | walking_up   | 0.2619295         | -0.02664705       |


