getdata
=======
main file: run_analysis.R
This script downloads the associated Samsung files from archive.ics.uci.edu if they are not present in the working directory. It then proceeds to:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
6. Create a file called tidy\_mean\_and\_sd.txt with write.table() using the row.name=FALSE parameter.

The above is also detailed in the course's project description. Since the data assets to take up space, they have been ignored in this repository. For details regarding the contents of the data, please refer to Codebook.md.
