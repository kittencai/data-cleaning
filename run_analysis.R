# Getting and cleaning data
# Project

setwd("F:/self-learning/data science/data clean/assign/UCI HAR Dataset")

# load variable
feature<-read.table("features.txt")
activity_labels<-read.table("activity_labels.txt")

# load data
train<-read.table("./train/X_train.txt",header=F,col.names=feature[,2])
test<-read.table("./test/X_test.txt",header=F,col.names=feature[,2])
train[7353:10299,]<-test

# select mean and std
data<-train[,1:6]
data[,7:12]<-train[,41:46]
data[,13:18]<-train[,81:86]
data[,19:24]<-train[,121:126]
data[,25:30]<-train[,161:166]
data[,31:32]<-train[,201:202]
data[,33:34]<-train[,214:215]
data[,35:36]<-train[,227:228]
data[,37:38]<-train[,240:241]
data[,39:40]<-train[,253:254]
data[,41:46]<-train[,266:271]
data[,47:52]<-train[,345:350]
data[,53:58]<-train[,424:429]
data[,59:60]<-train[,503:504]
data[,61:62]<-train[,516:517]
data[,63:64]<-train[,529:530]
data[,65:66]<-train[,542:543]


# name activity
train_activity<-read.table("./train/y_train.txt")
test_activity<-read.table("./test/y_test.txt")
train_activity[7353:10299,]<-test_activity
data$activity<-0
for (i in 1:10299){
    if (train_activity[i,]=="1"){
        data[i,]$activity<-"WALKING"
    }else if (train_activity[i,]=="2"){
        data[i,]$activity<-"WALKING_UPSTAIRS"
    }else if (train_activity[i,]=="3"){
        data[i,]$activity<-"WALKING_DOWNSTAIRS"
    }else if (train_activity[i,]=="4"){
        data[i,]$activity<-"SITTING"
    }else if (train_activity[i,]=="5"){
        data[i,]$activity<-"STANDING"
    }else {
        data[i,]$activity<-"LAYING"
    }
}


# name subject
data$subject<-0
train_subject<-read.table("./train/subject_train.txt")
test_subject<-read.table("./test/subject_test.txt")
train_subject[7353:10299,]<-test_subject
for (i in 1:10299){
    data[i,]$subject<-train_subject[i,]
}


# new dataset
data_classify<-aggregate(.~activity+subject,data=data, FUN=mean)
write.table(data_classify,file="dataset.txt",row.names=FALSE)

