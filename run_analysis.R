#download file and unzip
if( !file.exists("./UCI HAR Dataset")) 
{ 
        print("downloading HAR dataset...")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        f <- tempfile()
        download.file(fileUrl, destfile = f,method="curl",mode="wb")
        unzip(f)       
}

library(data.table)
library(dplyr)
library(tidyr)
        
# 1. Merges the training and the test sets to create one data set.
print("read subject_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
print("read subject_test.txt")
subject_test  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject       <- rbind(subject_train,subject_test)

print("read y_train.txt")
y_train       <- read.table("./UCI HAR Dataset/train/y_train.txt")
print("read y_test.tt")
y_test        <- read.table("./UCI HAR Dataset/test/y_test.txt")
y             <- rbind(y_train,y_test)

print("read X_train.txt")
x_train       <- data.table(read.table("./UCI HAR Dataset/train/X_train.txt"))
print("read X_test.txt")
x_test        <- data.table(read.table("./UCI HAR Dataset/test/X_test.txt"))                           
x             <- rbindlist(list(x_train,x_test))

data1         <- tbl_dt(cbind(subject=subject[,1],activity=y[,1],x))
rm(subject_train,subject_test,y_train,y_test,x_train,x_test)
print("Training and test data sets merged\n")

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
#read the list of variables for each feature vectors
print("Extracting the measurements on the mean and standard deivations for each measurement")
variables <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors=FALSE)  
#extract functions (mean(),std() etc.) used in the variables
functs    <- sapply(strsplit(variables[,2],"\\-"),function(t){ if(length(t)<2) "NA" else t[2]}) 
# the list of variables names to be extracted ("V1","V2, etc)
idx       <- which( functs %in% c("mean()","std()") )
data2     <- select(data1,subject,activity, one_of(paste("V",idx,sep="")))

# 3.Uses descriptive activity names to name the activities in the data set
print("rename acticity in the dataset")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
data3           <- mutate(data2, activity = activity_labels[match(activity, activity_labels[,1]),2])

# 4.Appropriately labels the data set with descriptive variable names. 
print("lable the data set with descriptive variable naems")
varnames <- gsub("^t","time", variables[idx,2])
varnames <- gsub("^f","freq",varnames)
setnames(data3, 3:ncol(data3), varnames)


# 5. Creates a tidy data with the average of each variable for each activity and each subject.
#reshape data 
print("create tidy data with the average of each variable for each activity and each subject")
data4 <- data3 %>% gather(variable, value, -c(subject, activity)) %>% group_by(subject,activity,variable) %>% summarize(average = mean(value))

# 6. Write data set to a txt file
print("write dataset to HAR_summary.txt")
write.table(data4,file="HAR_summary.txt",row.names=FALSE,quote=FALSE)


