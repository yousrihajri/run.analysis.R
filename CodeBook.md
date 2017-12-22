CodeBook

For run.analysis.R

Author: Yousri Hajri

R version 3.3.3 (2017-03-06) 

Object : Human Activity Recognition database built from the
recordings of 30 subjects performing activities of daily living (ADL)
while carrying a waist-mounted smartphone with embedded inertial sensors.

Input Dataset information:

The experiments have been carried out with a group of 30 volunteers
within an age bracket of 19-48 years. Each person performed six
activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING,
STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the
waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant
rate of 50Hz. The experiments have been video-recorded to label the data
manually. The obtained dataset has been randomly partitioned into two
sets, where 70% of the volunteers was selected for generating the
training data and 30% the test data.

The input data is the following:
- activity_labels with 6 obs. of 2 vars
- features with 561 obs. of 2 vars
- subject_test with 2947 obs. of 1 var
- subject_train with 7352 obs. of 1 var
- X_test with 2947 obs. of 561 vars
- X_train with 7352 obs. of 561 vars
- y_test with 2947 obs. of 1 var
- y_train with 7352 obs. of 1 var


Mission:

Our mission is to create one R script called run_analysis.R that does the following.

    1- Merges the training and the test sets to create one data set.
    2- Extracts only the measurements on the mean and standard deviation for each measurement.
    3- Uses descriptive activity names to name the activities in the data set
    4- Appropriately labels the data set with descriptive variable names.
    5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
Output: final_data 180 obs. of 81 vars
Variables are the following : 

mean value of :
tBodyAcc	XYZ 
tGravityAcc	XYZ
tBodyAccJerk	XYZ
tBodyGyro	XYZ
tBodyGyroJerk	XYZ
tBodyAccMag	
tGravityAccMag	
tBodyAccJerkMag	
tBodyGyroMag	
tBodyGyroJerkMag	
fBodyAcc	XYZ
fBodyAccJerk	XYZ
fBodyGyro	XYZ
fBodyAccMag	
fBodyAccJerkMag	
fBodyGyroMag	
fBodyGyroJerkMag	

constituting 33 vars

standard deviation of:

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

constituting 33 vars

meanFreq(): Weighted average of the frequency components to obtain a mean frequency of:

tBodyAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ

constituting 13 vars

The subject is a variable of 30 factors and the the activity_labels is a variable of 6 factors

The observations are summarised per subject per activity_label so 30*6=180




