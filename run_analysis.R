#Script to process activity data collected at 50Hz from a triaxial acceleromter and from a gyroscope
# both contained in a standard Samsung smart phone.
#The orignal data are 9 files in two folders named Inertial data (3 variables x 3 dimensions (X, Y, Z);
# Since the pupose of these data is to create an activity classifier based on inertial data
# these data are divided into two parts 70% train and 30% test (21 subjects in train a& 9 subjects
# in test); the file structure is the same for both parts of the data.
#
#Each file contains the same number of rows as the 561 col feature data set.
#All of the data files are implicitly keyed on row number.
#In this case the same ID data (subject & activity) works for both the processed (feature) data and 
#the raw (inerial) data.
#Each row of the inertial data set files contain 128 columns which I believe are successive samples
#(@ 50Hz) of the same variable and reresents 2.5 s of time series data. Therefore 50 consecutive 
#rows represent 50 x 2.5 s = 125 s in one of the six activities. (These files are messy in the sense
#that they have the same data in cols & rows) 

#The flow of this script follows the five steps of the assignment.
#The data.frame names start as trex (10299 x 561, merged train & test with col names added)---> 
#trexsub (10299 x 86; selected mean & std cols. ) ----> ltrex (10299 x 88; two ID cols added)
#From this point a function doProject() 
# 1. runs two nested for loops to select a subject x activity group of rows (~50; not the 
#    same in each case)
# 2. calculates the 88 col means as a single col vector
# 3. transposes the col of col means to a row and appends the row to the bottom of the 
#    forming final tidy data set
# 4. adds the prefix Avg to all the cols except the two ID cols
# 5. substitues activity names for numbers (1 to 6) in the activity ID col
# 6. writes the data.frame to a .csv file.


#Import the data into R / Place the data files in the working directory;
#seven files
# features.txt,
#subject_train.txt, X_train.txt, y_train.txt
#subject_test.txt, X_test.txt, y_test.txt

#1. Merge the training and test data sets.
#Read the col names
ft<-read.table("features.txt")

#Read the activity data
trx<-read.table("X_train.txt", colClasses=numeric, col.names=ft$V2)
tex<-read.table("X_test.txt", colClasses=numeric, col.names=ft$V2)

#Combine the activity data by rows; train on top of test

trex<-rbind2(trx,tex)


#Select cols of means & std
mni<-grep("[M|m]ean", colnames(trex))
sti<-grep("std", colnames(trex))
#Subset the data from 561 columns to 86 (53 & 33)
trexsub<-trex[,c(mni,sti)]

#Read the ID colunms of subject and activity
train<-fread("subject_train.txt")
test<-fread("subject_test.txt"
ytrain<-fread(y_train.txt")
ytest<-fread("y_test.txt")

#Combine the subject and activity ID's train on top of test

ttrain<-rbind2(train,test)
ytt<-rbind2(ytrain,ytest)

#Combine the ID columns subject before activity

ttsa<-cbind2(ttrain,ytt)

#Add the ID columns to the subset of data to produce a data.frame of 10,299 rows x 88 cols

ltrex<-cbind2(ttsa,trexsub)

#Check for NA values; if == 0 -> no NA values

Sum(is.na(ltrex))

#The function "doProject" is defined below.
#From the merged data.frame ltrex [10299, 88] it selects 180 groups of subject (30) x activity (6) pairs, 
#calculates #the column means and appends to the tidy data data.frame row by row (in two nested 
#"for"" loops;the outer one for 30 subj, the inner one for six activities) for output.
# It takes two arguments subjects & activities (defualts are 30 & 6)

doProject()

#Now we have the table tidy_activity in the global environment

#Relabel the columns with AVG_; take the colnames from the table, modify them with paste(), 
#and put them back

qq<-colnames(tidy_activity)
qqavg<-paste("Avg", qq[3:88], sep="_")
qqavg[1:2]<-c("Subject", "Activity")
colnames(tidy_activity)<-qqavg

#Write the tidy data set to the file "tidy_Activity.csv"

write.csv(tidy_activity, file="tidy_Activity.csv", row.names=F)

##Done

##Function 'doProject' to extract a set of unique (180 in all) subject and activity (rows; ~350) 
#from the reduced data set of 53 means and 33 stds,  
#calculate the column means, forming a single row, and append them to the tidy data file 
#of 180 observations by 88 data columns (2 cols. ID & 86 cols. of means) being built for output.
# doProject also recodes the six numeric activities to text labels.

doProject<-function(subj=30, activ=6){

  #accMltrex1<-as.data.frame(x[1:88])
  #accMltrex<-as.numeric(accMltrex)
  #accMltrex1<-data.frame()
  
  accMltrex2<-data.frame()
for(i in 1:subj){
  #sb<-i
  #print(sb)
  for(j in 1:activ){
      #av<-j
      #print(sb)
      #print(av)
      sel<-which(ltrex$subj==i&ltrex$activ==j)
      #print(head(sel, n=2))
      avgltrex<-colMeans(ltrex[sel,])
      #print(head(avgltrex, n=4))
      tavgltrex<-t(avgltrex)
      #print(head(tavgltrex, n=1))
      accMltrex2<-rbind2(accMltrex2, tavgltrex)
             }
  #print(head(tavgltrex, n=1))
            }

#accMltrex1<<-rbind2(accMltrex1, accMltrex2)

#Write the data frame to the global environment
tidy_activity<<-accMltrex2

#Recode the activities to text labels

tidy_activity[,2][tidy_activity[,2]==1]<<-"Walking"
tidy_activity[,2][tidy_activity[,2]==2]<<-"Walking upstairs"
tidy_activity[,2][tidy_activity[,2]==3]<<-"Walking downstairs"
tidy_activity[,2][tidy_activity[,2]==4]<<-"Sitting"
tidy_activity[,2][tidy_activity[,2]==5]<<-"Standing"
tidy_activity[,2][tidy_activity[,2]==6]<<-"Laying"
}

