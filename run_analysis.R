#From training and test dataset,extracting the data and putting it into X__train and X_test dataframe

X_train<-read.table("X_train.txt")
X_test<-read.table("X_test.txt")

#From subject datasets of individual test and training parts, extracting it and putting it into subjects_test and subjects_train dataframe

subjects_test<-read.table("subject_test.txt")
subjects_train<-read.table("subject_train.txt")

#From features.txt, extract the datasets into feature dataframe

feature<-read.table("features.txt")

#From activities datasets of train and test datasets, extracting and putting it into activity_test and activity_train dataframe

activity_test<-read.table("y_test.txt")
activity_train<-read.table("y_train.txt")

#Combining X_train & X_test, subjects_test & subjects_train, activity_test & activity_train together using rbind function

X_Train_Test<-rbind(X_test,X_train)
subjects<-rbind(subjects_test,subjects_train)
activity<-rbind(activity_test,activity_train)

#Extracting the desired mean and standard deviation column from X_Train_Test by using grep function

index<-grep("(.*)(mean|std)(.*)",feature$V2)
X_Train_Test_Filtered<-X_Train_Test[,index]

#combining the X_Train_Test_Filtered,subjects,activity dataframes into a single resultdf dataframe by using cbind

resultdf<-cbind(X_Train_Test_Filtered,subjects,activity)

#changing the activity number to descriptive activity name in activity column

activity_labels<-read.table("activity_labels.txt")

colnames(activity_labels)<-c("activityno","activityname")

colnames(resultdf)<-c(as.character(feature[index,]$V2), "subject","activityno")

labelleddf<-merge(resultdf,activity_labels,by.x = "activityno",by.y = "activityno")

final_labelleddf<-labelleddf[,!(names(labelleddf) %in% c("activityno"))]

#Finally after getting final data frame, appropriately labelling the data set with descriptive variable name


names(final_labelleddf)<-gsub("-","_",names(final_labelleddf))

names(final_labelleddf)<-gsub("\\()","",names(final_labelleddf))

#Calculating  the average of each variable for each activity and each subject.




final_labelleddf<-sapply(final_labelleddf,as.numeric)

final_labelleddf<-as.data.frame(final_labelleddf)

s<-split(final_labelleddf,list(final_labelleddf$subject,final_labelleddf$activityname))

m<-sapply(s,colMeans)
m<-t(m)
#Storing the tidy data set in a file named file.txt

m1<-as.data.frame(m)

m1$activityname<-activity_labels[,2][match(m1$activityname,activity_labels[,1])]


x<-write.table(m1,file = "./file.txt",row.names = FALSE)

y<-read.table("file.txt")

y

