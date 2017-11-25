#run_analysis
#import data

#activitiy labels
activity_labels <- read.delim("UCI HAR Dataset/data/activity_labels.txt",header=FALSE,sep="")
#features
features <- read.delim("UCI HAR Dataset/data/features.txt",header=FALSE,sep="")

#test data set
#volunteers/subject test
subject_test <- read.delim("UCI HAR Dataset/data/subject_test.txt",header=FALSE,sep="")
#test set
X_test <- read.delim("UCI HAR Dataset/data/X_test.txt",header=FALSE,sep="")
#activities test
Y_test <- read.delim("UCI HAR Dataset/data/Y_test.txt",header=FALSE,sep="")


#train data set
#volunteers/subject train
subject_train <- read.delim("UCI HAR Dataset/data/subject_train.txt",header=FALSE,sep="")
#train set
X_train <- read.delim("UCI HAR Dataset/data/X_train.txt",header=FALSE,sep="")
#activities train
Y_train <- read.delim("UCI HAR Dataset/data/Y_train.txt",header=FALSE,sep="")

#merge the data
subject <- rbind(subject_test,subject_train)
X <- rbind(X_test,X_train)
Y <- rbind(Y_test,Y_train)
#delete unused data
rm(subject_test,subject_train)
rm(X_test,X_train,Y_test,Y_train)

#dataset
complete_data <- cbind(Y,subject,X)

#dataset with means & standard deviation
features_mean_sd <- complete_data[,c(1:8,123:128,268:273,426:431)]

#descriptive activities
features_activities <- features_mean_sd
features_activities[,1] <- activity_labels[,2][match(unlist(features_activities[,1]), activity_labels[,1])]

#variable names
features2 <- as.character(features[c(1:6,121:126,266:271,424:429),2])
names(features_activities)[1:2] <- c("activities","subject")
names(features_activities)[3:length(features_activities[1,])] <- features2

#mean for each activity and each subject
group_mean <- features_activities
activity_mean <- aggregate(group_mean[,3:26], list(group_mean$activities), mean)
activity_mean
subject_mean <- aggregate(group_mean[,3:26], list(group_mean$subject), mean)
subject_mean

write.table(activity_mean,file="activity_mean.txt",row.name=FALSE)
write.table(subject_mean,file="subject_mean.txt",row.names = FALSE)
