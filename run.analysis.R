systimebegin <- Sys.time()
library(data.table)
library(stringr)
library(tidyverse)


##Extract features and activity labels
##Extract subject_test X_test & y_test 
##Extract subject_train X_train & y_train 
setwd(dir = "C:\\Users\\yousri.hajri\\Documents\\DATA_SCIENCE\\3_GETTING_AND_CLEANING_DATA\\WEEK4\\run_analysis.R")
source("data.extractor.R")

##Merge train&test

subject <- rbind.data.frame(subject_train, subject_test)
X <- rbind.data.frame(X_train, X_test)
y <- rbind.data.frame(y_train, y_test)

##Merge y and activity_labels

y <- merge (x=y, y=activity_labels, by.x = "V1", by.y = "V1", sort=F) 
y <- select (y, V2) %>% rename(activity_labels=V2)

##Merge X and features

X <- as.data.frame(X)
X <- rbind(as.vector(features$V2), X)
colnames(X)=X[1,]
X <- X[-1,]
X <- as.data.table(X)

##Rename column of subject

subject <- rename (subject, subject=V1)

##Fulldata merger

fulldata <- cbind(subject, y, X)

##Create meanfulldata with colnames containing "mean"
v1 <- c()
for (i in 3:length(colnames(fulldata))) {
              if (length(grep("mean", colnames(fulldata[,i,with=FALSE])))==1) {
               v1 <- c(v1,i)      }}
mean_fulldata <- fulldata[,c(1,2,v1),with=FALSE]

##Create stdfulldata with colnames containing "std"
v2 <- c()
for (i in 3:length(colnames(fulldata))) {
  if (length(grep("std", colnames(fulldata[,i,with=FALSE])))==1) {
    v2 <- c(v2,i)      }}
std_fulldata <- fulldata[,v2,with=FALSE]

##Merge meanfulldata and stdfulldata in subdata

subdata <- cbind (mean_fulldata, std_fulldata)

##Class the columns of subdata 

collength <- length(names(subdata))

for(i in 3:collength) {
              subdata[,i] <- as.numeric (as.matrix(subdata[,i,with=FALSE])) }

subdata$activity_labels <- as.factor(subdata$activity_labels)
subdata$subject <- as.factor(subdata$subject)

subdata <- as.tibble (subdata)

subdata <- arrange (subdata, subject)

##Summarise all subject/activity_labels by mean function

final_data <- subdata %>%
  group_by(subject, activity_labels) %>%
  summarise_all (funs(mean))


##Remove old data

remove (subject, X, y)
remove (subject_train, subject_test,
        X_train, X_test,
        y_train, y_test)
remove (activity_labels, features)
remove (fulldata, mean_fulldata, std_fulldata)


##Performance
systimeend <- Sys.time()
runtime <- systimeend - systimebegin
print(runtime)




