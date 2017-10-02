systimebegin <- Sys.time()
library(data.table)
library(dplyr)
library(tidyr)
library(stringr)
wait.time <- 1


##Extract features and activity labels
##Extract subject_test X_test & y_test 
##Extract subject_train X_train & y_train 
source("C:\\Users\\yousri.hajri\\Desktop\\DATA SCIENCE\\3 GETTING AND CLEANING DATA\\WEEK4\\run_analysis.R\\data.extractor.R")

##Merge train&test

subject <- rbind.data.frame(subject_train, subject_test)
X <- rbind.data.frame(X_train, X_test)
y <- rbind.data.frame(y_train, y_test)

##Merge y and activity_labels

for (i1 in 1:length(y$V1)) {
  for (i2 in 1:6)          {
                            if (y$V1[[i1]]==activity_labels$V1[[i2]]) {
                              y$V1[[i1]] <- as.character (activity_labels$V2[[i2]])} 
}
}

##Merge X and features
X <- as.data.frame(X)
X <- rbind(as.vector(features$V2), X)
colnames(X)=X[1,]
X <- X[-1,]
X <- as.data.table(X)

##Rename columns of subject & y

subject <- rename (subject, subject=V1)
y <- rename (y, activity_labels=V1)

##Fulldata merger

fulldata <- cbind(subject, y, X)

##Remove old data

remove (subject, X, y)
remove (features)
remove (subject_train, subject_test,
        X_train, X_test,
        y_train, y_test)
remove (activity_labels)

#Seek for NA's
#library(mice)
#NAdata <- md.pattern(fulldata)


##Create meanfulldata with colnames containing "mean"
v1 <- c()
for (i in 3:length(colnames(fulldata))) {
              if (length(grep("mean", colnames(fulldata[,i,with=FALSE])))==1) {
               v1 <- c(v1,i)      }}
meanfulldata <- fulldata[,c(1,2,v1),with=FALSE]

##Create stdfulldata with colnames containing "std"
v2 <- c()
for (i in 3:length(colnames(fulldata))) {
  if (length(grep("std", colnames(fulldata[,i,with=FALSE])))==1) {
    v2 <- c(v2,i)      }}
stdfulldata <- fulldata[,v2,with=FALSE]

##Merge meanfulldata and stdfulldata in subdata

subdata <- cbind (meanfulldata, stdfulldata)

##Class the columns of subdata and make 2-digit subject

collength <- length(names(subdata))

for(i in 3:collength) {
              subdata[,i] <- as.numeric (as.matrix(subdata[,i,with=FALSE])) }
subdata <- arrange (subdata, subject)
subdata$subject <- as.character (subdata$subject)
for (i in 1:nrow(subdata)) { if (as.numeric(subdata [i, "subject"]) <=9)
                    {subdata [i, "subject"] <- paste ("0",subdata [i, "subject"],
                                              sep = "")
}}

subdata$activity_labels <- as.factor(subdata$activity_labels)
subdata$subject <- as.factor(subdata$subject)

subdata <- tbl_df(subdata)

for (i in 1:5)
  
{ print ("subdata is ready ...")
  wait <- function(wait.time)
  {now <- proc.time()[3]
  while(proc.time()[3] < (now + wait.time)) dum <- 0 }
  wait(wait.time)}




##Create meandata with mean of each subject for each activity

subdata2 <- subdata %>%
  arrange(activity_labels) %>%
  arrange(subject) %>%
  mutate (newcol = paste(subject, activity_labels))

subdata3 <- cbind (subdata2$newcol, subdata2)

subdata3 <- subdata3 %>%
  select (-2,-3,-newcol) %>%
  rename(V='subdata2$newcol') %>%
  group_by(V) 

meandata <- summarise_all (subdata3, funs(mean))
meandata <- arrange (meandata, V)
excolumns <- as.data.frame (str_split_fixed(meandata$V, " ", 2))
excolumns <- rename(excolumns, subject = V1, activity_labels=V2)
meandata <- cbind (excolumns, meandata)
meandata <- meandata [,-3 ]
meandata <- tbl_df(meandata)



##Remove old data

remove (fulldata, meanfulldata, stdfulldata, subdata2, subdata3, excolumns)

for (i in 1:5)
  
{ print ("meandata is ready ...")
  wait <- function(wait.time)
  {now <- proc.time()[3]
  while(proc.time()[3] < (now + wait.time)) dum <- 0 }
  wait(wait.time)}

systimeend <- Sys.time()
runtime <- systimeend - systimebegin
print(runtime)



