We have been given the data set of each subject in the trainting and test folder.
The activity and activity label of the subjects are also given having the name of the activity and
the activity labelling for the corresponding activity name respectively

Also the feature obtained from the observation is also given in a seperate file.

For subject,activity and the observation of test, there is 
subject_test.txt(subject doing particular activity)
y_test.txt(activity)
X_text.txt(observation for each feature)
 

Same is for the training folder.

For feature of the observation and activity label of the activity,

feature.txt
activity_label.txt


The task we have been given is to calculate the average of each measurement for each subject and each activity

For example for the subject 3rd doing the activity walking , we have to calculate the average of fBodyGyro_mean_X.

Following are the steps that have been taken in these.




The tidy data sets obtained after this would have 79 features as the rownames and column names as the concanated form like activity_subject name

For example : if you want to get the average of fBodyGyro_std_Y for the subject 4th doing the activity Sitting ,the column have name Sitting_4 and row name fBodyGyro_std_Y


1.From training and test dataset,the Observation of X_test and X_trainig are extracted and put  into X__train and X_test dataframe

2.From subject datasets of  test and training folders, the subject information are extracted into subjects_test and subjects_train dataframe

3.From features.txt, the datasets are extracted into feature dataframe

4.From activity datasets of  test and training folders, the activity information are extracted into activity_test and activity_train dataframe

For all the above steps,we used read.table function

5.Combining X_train & X_test into X_Train_Test, subjects_test & subjects_train int o subjects, activity_test & activity_train together into activity using rbind function

6.Extracting the desired mean and standard deviation column from X_Train_Test by using grep function with the pattern matching on mean  or std and the resultant datafrrame is X_Train_Test_Filtered

7.All the column of X_Train_TestFiltered, activity and subject dataframe are combined using cbind function into resultdf dataframe 

8.The activity number are changed to descriptive activity name in activity column of the resultdf dataset and the final_labelleddf is obtained

In this process, first the activity_labels.txt are extracted having the activity name for the corresponding activity number
Then the column name for the obtained data frame are changed from "V1","V2" to "activityno","activityname"
Column names for resultdf is also manipulated for the successful merging of the activity_labels df and resultdf

Then the merge function is applied for both the df on activityno acolum

The column "activity no" is removed from the resultant df and we get the final_labelleddf

9.Finally after getting final data frame, the final_labelleddf is appropriately labelled with descriptive variable name
 gsub function is used in this step. The "-" is replaced with "_" and () with a blank

10.Finally the average of each measurement for each activity and each subject is calculated.

For example for the subject 3rd doing the activity walking , we have to calculate the average of fBodyGyro_mean_X.

The tidy data sets obtained after this would have 79 features as the rownames and column names as the concanated form like activity_subject name

For example : if you want to get the average of fBodyGyro_std_Y for the subject 4th doing the activity Sitting ,the column have name Sitting_4 and row name fBodyGyro_std_Y

First the observation of final_labelleddf are converted to numeric using sapply function
After this, the obtained matrix is converted to data frame using as.data.frame function

Then the final_labelleddf is split according to the subject and activity using split function

After this the averages are calculated into sapply function into colMeans function

11.Then the tidy data sets are stored into file.txt

write.table function is used for this purpose and the rowname and colname are dropped


