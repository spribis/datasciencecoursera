setwd("Coursera/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset")

## Read in data
activity_labels <- read.table("activity_labels.txt")
features <- read.table("features.txt",colClasses=c("integer","character"))
trainsubject_train <- read.table("train/subject_train.txt",colClasses="factor")
trainy_train <- read.table("train/y_train.txt")
trainX_train <- read.table("train/X_train.txt")
testsubject_test <- read.table("test/subject_test.txt",colClasses="factor")
testy_test <- read.table("test/y_test.txt")
testX_test <- read.table("test/X_test.txt")

## 1. Bind data
testyx <- cbind(set=rep("test",2947), subject=testsubject_test$V1,
                activity=testy_test$V1, testX_test)
trainyx <- cbind(set=rep("train",7352), subject=trainsubject_train$V1,
                activity=trainy_train$V1, trainX_train)
testtrain <- rbind(testyx,trainyx)

## 4. Give titles to data columns
names(testtrain) <- c("set","subject","activity",features$V2)

## 2. Pick out only means and standard deviations
almost <- testtrain[,c(1:3,3+c(1:6,41:46,81:86,121:126,161:166,201:202,214:215,
                               227:228,240:241,253:254,266:271,345:350,424:429,
                               503:504,516:517,529:530,542:543))]

## 3. Merge data activity labels
final <- merge(activity_labels,almost,by.y="activity",by.x="V1")
final <- final[,2:70]
names(final)[1] <- "activity"

## 5. Average each variable
library(reshape2)
finalmelt <- melt(final,id=c("subject","activity","set"),measure.vars=names(final)[4:69])
finalmean <- dcast(finalmelt, set + subject + activity ~ variable,mean)

## Write the data to a file
setwd("../../")
write.table(finalmean, "Course3ProjSolution.txt", row.names=FALSE)