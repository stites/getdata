library(tidyr)
library(dplyr)
library(data.table)

zipfile <- "./dataset.zip"
dataDir <- "./UCI HAR Dataset"

# make a path to the dataDir (note the impurity in this function)
makePath <- function(filename){
  paste(dataDir, filename, sep="/")
}

# get the zip file and extract it:
getData <- function (zipfile){
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                destfile=zipfile,
                method="curl")
  unzip(zipfile, exdir='.')
  file.remove(zipfile)
}

# Given a data type (test, train), find all files matching the pattern
listType <- function (root=root, type=type){
  path    <- makePath(type)
  pattern <- paste('*', type, '.txt', sep="")
  sort(list.files(path=path, pattern=pattern, full.names = TRUE))
}


# ---------------------------------------------------- #
# Set up                                               #
# ---------------------------------------------------- #

# see if we need to get the data:
if (!file.exists(zipfile) && !file.exists(dataDir)){
  getData(zipfile)
}

# ---------------------------------------------------- #
# 1. Merge training and test sets                      #
# ---------------------------------------------------- #

# get an aggregate dataframe
getDF <- function(type, collist){
  listType(root=dataDir, type) %>%                # list all files of type (train/test)
    sort %>%                                      # then sort them
    lapply(FUN=read.table, strip.white=TRUE) %>%  # read them with read.table
    do.call(what=cbind)                           # and call cbind on the generated list
}

# read a table of the given filename
getLabels <- function(filename){
  read.table(makePath(filename),           
             sep=" ",
             col.names=c("index","labels"),
             colClasses="character")
}
# map column names from a list of files
colNameMapper <- function(type, features){
  listType(root=dataDir, type) %>%        # given a type, get the files
    sort %>%                              # sort them for consistency
    lapply(FUN=function(filename){        # across the list...
      if (grepl('subject', filename)) {   # if the file has subject in it, we add a subject name col
         c("subject_name")
      } else if (grepl('y_', filename)) { # y_ implies activity name
         c("activity_name")
      } else {
        features$labels                   # ... and everything else comes from this features df
      }
    }) %>%
    unlist
}

# ----------
features        <- getLabels('features.txt')
activity_labels <- getLabels('activity_labels.txt')

testFiles            <- getDF("test")
colnames(testFiles)  <- colNameMapper("test", features)  # completes 4
trainFiles           <- getDF("train")
colnames(trainFiles) <- colNameMapper("train", features) # completes 4

all <- rbind(trainFiles, testFiles)

# ---------------------------------------------------- #
# 2. Extract mean and sd for each measurement          #
# ---------------------------------------------------- #
extract <-all[,c(grepl("subject|activity|mean\\(|std\\(", colnames(all), perl=TRUE))]

# ---------------------------------------------------- #
# 3. Name the activities in the data set               #
# ---------------------------------------------------- #
extract$activity_name <- factor(extract$activity_name,
                                activity_labels$index,
                                activity_labels$labels)

# ---------------------------------------------------- #
# 4. descriptively label the data set                  #
# ---------------------------------------------------- #

# completed on line 79/81 - has to be done twice in case
# of inconsistency in fileordering

# ---------------------------------------------------- #
# 5. Get mean of each variable by activity and subject #
# ---------------------------------------------------- #
# From the data set in (4). Create a second,
# independent tidy data set.
tidy_mean_and_sd <- aggregate(extract[,3:length(extract)-1],
                              by=list(activity_name=extract$activity_name,
                                      subject_name=extract$subject_name),
                              mean)

# ---------------------------------------------------- #
# 6. Submit                                            #
# ---------------------------------------------------- #
write.table(tidy_mean_and_sd,
            file="tidy_mean_and_sd.txt",
            row.names=FALSE)




