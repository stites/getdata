### Data set information

Excerpt from (UCI's Machine learning repository)[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
>
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

### Purpose

This script's intent is to download and extract a clean dataset from the above source. From the resulting dataset, the means corresponding to each subject and activity level was taken from the mean and standard deviation features in the data.

### Features Used

The standard deviation and mean features of the following variables were used:

- X, Y, and Z axies of the following dimensions:
    - `tBodyAcc`
    - `tGravityAcc`
    - `tBodyAccJerk`
    - `tBodyGyro`
    - `tBodyGyroJerk`
    - `fBodyAcc`
    - `fBodyAccJerk`
    - `fBodyGyro`
- The magnitude of the following dimensions:
    - `fBodyAcc`
    - `fBodyBodyAccJerk`
    - `fBodyBodyGyroJerk`
    - `fBodyBodyGyro`
    - `tBodyAccJerk`
    - `tBodyAcc`
    - `tBodyGyroJerk`
    - `tBodyGyro`
    - `tGravityAcc`
- the `activity_name` and `subject_name` were also used to group the above features.

### Output

The output of the data was the mean of the features used (see above) grouped by `activity_name`, and `subject_name`. `activity_name` is a variable containing information regarding if the subject was walking, walking upstairs, or walking downstairs, while `subject_name` is a number from 1-30.
