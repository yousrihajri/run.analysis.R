CodeBook

For run.analysis.R

Author: Yousri Hajri

R version 3.3.3 (2017-03-06)   

The following steps were followed:

1- we load the raw data from the source:
      -activity_labels
      -features
      -subject_train
      -subject_test
      -X_train
      -X_test
      -y_train
      -y_test
      
2- we merge train & test using rbind function:
      -subject
      -X
      -y
      
3- we merge y and activity_labels by changing an integer observation with the correspondent character value:
      The for loop will go through all the y observations and test on any observation if it's equal to one 
      of the 6 possibilities in activity_labels. When it matches, the activity_label replaces the number.
      
      
4- we add the features as first row in X then we move them to become colnames. The old colnames are deleted.

5- we merge all subject, y and X to get fulldata. we can remove everything and keep only fulldata.

6- in fulldata some colnames contain the word "mean" and some contain the word "std". we make a loop to grep the 
    word in the colnames and when it matches, we add the column number in a vector V1 (for "mean") and V2 (for "std").
    meanfulldata is a subset of fulldata with column numbers V1. Similar for V2 giving stdfulldata.

7- subdata is the merger of meanfulldata and stdfulldata

8- subdata2 and subdata3 are temporary tables which add a new column to subdata for grouping_by subject & activity_labels

9- meandata is created by summarizing subdata3 and replacing the ex-1st-columns in place

10- all old data is removed, only meandata and subdata are kept for further analysis


   


      



