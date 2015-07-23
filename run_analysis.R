run_analysis <- function() {
      #load dplyr
      #NOTE: assumes dplyr has been installed
      library(dplyr)
      
      #read in ancillary data (activity, subject and feature IDs)
      #NOTE: assumes all data files are in the working directory
      testAct<-read.table("y_test.txt", col.names="activity", colClasses="integer")
      testSubject<-read.table("subject_test.txt", col.names="subject", colClasses="integer")
      features<-read.table("features.txt")
      featureNames<-features[,2]
      trainAct<-read.table("y_train.txt", col.names="activity", colClasses="integer")
      trainSubject<-read.table("subject_train.txt", col.names="subject", colClasses="integer")
      
      #read in main data for both test and training sets
      Xtest<-read.table("X_test.txt")
      Xtrain<-read.table("X_train.txt")
      
      #assign feature names to columns
      names(Xtest)=featureNames
      names(Xtrain)=featureNames
      
      #remove duplicated columns
      testData<-Xtest[,!duplicated(colnames(Xtest))]
      trainData<-Xtrain[,!duplicated(colnames(Xtrain))]
      
      #create full data frames with subject ID, activity ID, and features data
      test<-cbind(testSubject,testAct,testData)
      train<-cbind(trainSubject,trainAct,trainData)
      
      #create columns in each data frame to identify whether it is the test or training dataset
      test$dataset="TEST"
      train$dataset="TRAIN"
      names(test$dataset)="dataset"
      names(train$dataset)="dataset"
      
      #bind test and training datasets together
      fullData<-rbind(test,train)
      
      #select only data on means and standard deviations
      phoneData<-select(fullData, dataset, subject, activity, contains("mean()"),contains("std()"))
      
      #replace numbered activity IDs with activity names
      phoneData[phoneData$activity==1,]$activity="walking"
      phoneData[phoneData$activity==2,]$activity="walking upstairs"
      phoneData[phoneData$activity==3,]$activity="walking downstairs"
      phoneData[phoneData$activity==4,]$activity="sitting"
      phoneData[phoneData$activity==5,]$activity="standing"
      phoneData[phoneData$activity==6,]$activity="laying"
      
      #clean up variable names
      names(phoneData)<-gsub("-", "_", names(phoneData))
      names(phoneData)<-gsub("BodyBody", "Body", names(phoneData))
      names(phoneData)<-gsub("fB", "transformed_B", names(phoneData))
      names(phoneData)<-gsub("tB", "B", names(phoneData))
      names(phoneData)<-gsub("fG", "transformed_G", names(phoneData))
      names(phoneData)<-gsub("tG", "G", names(phoneData))
      names(phoneData)<-gsub("\\()", "", names(phoneData))
      names(phoneData)<-gsub("std", "standard_deviation", names(phoneData))
      names(phoneData)<-gsub("X", "on_xaxis", names(phoneData))
      names(phoneData)<-gsub("Y", "on_yaxis", names(phoneData))
      names(phoneData)<-gsub("Z", "on_zaxis", names(phoneData))
      names(phoneData)<-gsub("Acc", "Acceleration_", names(phoneData))
      names(phoneData)<-gsub("Body", "Body_", names(phoneData))
      names(phoneData)<-gsub("Gyro", "Gyroscope_", names(phoneData))
      names(phoneData)<-gsub("Mag", "Magnitude_", names(phoneData))
      names(phoneData)<-gsub("Jerk", "Jerk_", names(phoneData))
      names(phoneData)<-gsub("Gravity", "Gravity_", names(phoneData))
      names(phoneData)<-gsub("__", "_", names(phoneData))
      names(phoneData)<-tolower(names(phoneData))
      
      #create new data frame with means of each feature by subject and activity, split into test and training sets
      phoneDataMeans <-phoneData %>% group_by(dataset, subject, activity) %>% summarise_each(funs(mean))
      
      #save final data frame and print it
      write.table(phoneDataMeans, "phoneDataMeans.txt", quote=TRUE, col.names=TRUE, row.names=FALSE, sep="\t")
}       