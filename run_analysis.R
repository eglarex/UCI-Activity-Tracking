##########################
##########################
###
###The Run Analysis
###
###Script
###
###Tidy ups the UCI set
###
##########################
##########################
library(XML)
library(httr)
library(qpcR)
library(httr)
library(rvest)
library(V8)
library(gdata)
library(dplyr)
library(readr)
library(tidyr)

run_analysis<-function(){

  directory_test<-"R_wd\\UCI HAR Dataset\\test\\"
  directory_train<-"R_wd\\UCI HAR Dataset\\train\\"
  directory_signals<-"R_wd\\UCI HAR Dataset\\train\\Inertial Signals"
  features<-"R_wd\\UCI HAR Dataset\\features.txt"
  activities<-"R_wd\\UCI HAR Dataset\\activity_labels.txt"
  subject_train<-"R_wd\\UCI HAR Dataset\\train\\subject_train.txt"
  subject_test<-"R_wd\\UCI HAR Dataset\\test\\subject_test.txt"
  file_test_x<-"X_test.txt"
  file_test_y<-"y_test.txt"
  file_train_x<-"X_train.txt"
  file_train_y<-"y_train.txt"
  file_train_signal_x<-"body_acc_x_train.txt"
  xx<-tbl_df(read.table("R_wd\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_x_train.txt",header=TRUE))
  test_x<-paste(directory_test,file_test_x,sep="")
  test_y<-paste(directory_test,file_test_y,sep="")
  train_x<-paste(directory_train,file_train_x,sep="")
  train_y<-paste(directory_train,file_train_y,sep="")
  
  ttx<-tbl_df(read.table(test_x,header=T))
  tty<-tbl_df(read.table(test_y,header=T))
  trx<-tbl_df(read.table(train_x,header=T))
  try<-tbl_df(read.table(train_y,header=T))
  subject_tr<-tbl_df(read.table(subject_train,header=T))
  subject_tt<-tbl_df(read.table(subject_test,header=T))
  
  features_label<-tbl_df(read.table(features))
  activities_label<-as.data.frame(read.table(activities))
  
  names(subject_tt)<-"SubjectNames"
  names(subject_tr)<-"SubjectNames"
  subject_all<-rbind(subject_tt,subject_tr)
  names(subject_all)
  
  
  names(ttx)<-make.names(t(features_label[,2]),unique=TRUE,allow_ = TRUE)
  names(trx)<-make.names(t(features_label[,2]),unique=TRUE,allow_ = TRUE)
  set_x<-rbind(ttx,trx)
  names(set_x)<-names(ttx)
  set_y<-rbind(tty,try)
  
  names(set_y)<-"Activity"
  for(i in 1:6){set_y[set_y$Activity==i,1]=as.character(activities_label[i,2])}
  set_all<-cbind(set_x,set_y)
  set_all<-cbind(subject_all,set_all)
  set_all<-tbl_df(set_all)
  
  set_independent<-group_by(select(set_all,contains("mean"),contains("std"),"Activity", "SubjectNames"),Activity,SubjectNames) 
  
  for(i in 1:86){
    name <- paste0('Average.',names(set_independent)[i]);
    avg <- paste0('mean(',names(set_independent)[i],',na.rm=TRUE)');
    summ<-as.data.frame(summarise_(set_independent,.dots=setNames(avg,name)))
    if(i==1){
      set_old<-summ
    }
    else{
      set_old<-cbind(set_old,summ[3],row.names=NULL) 
    }
  }
  write.table(set_old,file="result.csv",row.names = FALSE)
  }
