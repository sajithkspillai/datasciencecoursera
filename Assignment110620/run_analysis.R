#Set the working folder
setwd("C:\\Users\\Sajith\\Documents\\datasciencecoursera")
#Download the zip file from URL
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip",method="curl")
#Unzip the downloaded file in assignment folder
unzip(zipfile="./Dataset.zip",exdir="./Assignment110620")
#Set path of the files
path = file.path("./Assignment110620", "UCI HAR Dataset")
#List the files in the path
filels = list.files(path, recursive=TRUE)
filels

#1.Merges the training and the test sets to create one data set.

#Reading files from train folder
trainset<-read.table(file.path(path, "train", "X_train.txt"),header=F)
trainlabel<-read.table(file.path(path, "train", "y_train.txt"),header=F)
trainsubject<-read.table(file.path(path, "train", "subject_train.txt"),header=F)
#Reading files from test folder
testset<-read.table(file.path(path, "test", "X_test.txt"),header=F)
testlabel<-read.table(file.path(path, "test", "y_test.txt"),header=F)
testsubject<-read.table(file.path(path, "test", "subject_test.txt"),header=F)
#Combining readings of test and training
newset<-rbind(trainset,testset)
#Combining label of test and training
newlabel<-rbind(trainlabel,testlabel)
#Combining subject of test and training
newsubject<-rbind(trainsubject,testsubject)
#Combining reading,label and subject to form combined data set
data<-cbind(newlabel,newsubject,newset)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.

#Reading header name to find files with mean() and std()
name <- read.table(file.path(path,"features.txt"),header =F)
#Obtaining position of names with mean() and std()
nameindex<-grep("mean\\(\\)|std\\(\\)",name[,2])
#Selecting files with mean() and std()
selectset<-newset[,nameindex]
#Adding label and Subject to make complete selection data set with mean() and std()
selectset<-cbind(newlabel,newsubject,selectset)

#3.Uses descriptive activity names to name the activities in the data set

#Reading activity names to make descriptive activity names
activity = read.table(file.path(path, "activity_labels.txt"),header = F)
#Converting to lowercase and replacing special characters with space
activity[,2]<-tolower(gsub("_"," ",activity[,2]))
names(activity)<-c("activityid","activitylabel") 
#Labeling data set
names(data)<-c("activityid","subjectid",as.character(name[,2]))
names(data)<-tolower(names(data))
names(data)<-gsub("-","",names(data))
names(data)<-gsub("\\(|\\)","",names(data))
#Labeling extracted data set
names(selectset)<-c("activityid","subjectid",as.character(name[nameindex,2]))
names(selectset)<-tolower(names(selectset))
names(selectset)<-gsub("-","",names(selectset))
names(selectset)<-gsub("\\(\\)","",names(selectset))

#4.Appropriately labels the data set with descriptive variable names.

#Adding description of activities to full data set and extracted data set
data<-merge(activity,data,by="activityid",all.x=T)
selectset<-merge(activity,selectset,by="activityid",all.x=T)

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#Removing non numeric column from data set
selectset<-selectset[,(!names(selectset) %in% "activitylabel")]
#Grouping data by activity and subject
tidydata<-aggregate(selectset,by=list(selectset$activityid,selectset$subjectid),mean)
#Adding descriptive variable name
tidydata<-merge(activity,tidydata,by="activityid",all.x=T)
#Ordering the tidied data set
tidydata<-tidydata[order(tidydata$activityid,tidydata$subjectid),]
#Writing the data output
write.table(tidydata[,-(3:4)],"./Assignment110620/tidySet.txt",row.names=F)