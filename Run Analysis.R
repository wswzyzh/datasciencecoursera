##Getting and Cleaning Data Project
##read train data and combine
x_train = read.table(file.choose(), header = F)
x_test = read.table(file.choose(), header = F)
mydata.x = rbind(x_train, x_test)
y_train = read.table(file.choose(), header = F)
y_test = read.table(file.choose(), header = F)
mydata.y = rbind(y_train, y_test)
subject_train = read.table(file.choose(), header = F)
subject_test = read.table(file.choose(), header = F)
subject = rbind(subject_train, subject_test)
##read feature and decide variable names
feature = read.table(file.choose(), header = F)
featureSelected = grep(".*mean.*|.*std.*", feature[,2])
featureName = feature[featureSelected, 2]
featureName = gsub('[-()]', '', featureName)
mydata.x = mydata.x[,featureSelected]
##cbind subject, activity, and mydata.x
mydata = cbind(subject, mydata.y, mydata.x)
colnames(mydata) = c("subject", "activity", featureName)
##activity label
activity_label = read.table(file.choose(), header = F)
mydata$activity = factor(mydata$activity, levels = activity_label[,1], labels = activity_label[,2])
mydata$subject <- as.factor(mydata$subject)
##Split and calculate mean
mydata.split <- split(mydata[,1:79],mydata[,80:81])
split.mean <- sapply(mydata.split,colMeans)
mydata.mean <- unlist(split.mean)
write.table(mydata.mean, "tidy.txt", row.names = FALSE)
##
install.packages("reshape")
library(reshape)
mydata.melted <- melt(mydata, id = c("subject", "activity"))
mydata.mean <- dcast(mydata.melted, subject + activity ~ variable, mean)
write.table(mydata.mean, "tidy.txt", row.names = FALSE)
setwd("/Users/zihangyu/Desktop")
