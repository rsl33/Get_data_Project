## SHORT README

This README assumes the reader has done the course project and is very familiar with the data set.
 
The project starts with a given (messy, semi messy) data set and we are required to extract a subset of the data and
do a simple calculation of means creating a tidy data set in the sense of the course and in the sense of Hadly Wickham.

To describe how the script run_analysis.R works to accomplish the assignment I will first describe the staring point.

Six measured variables from two 3D sensors and 3 more calculated variables(subtracting acceleration due to gravity) 
are processed into 561 feature vectors for each 2.56s of the study.
The data are presented as rows of 561 features that represent sequential 2.56 s epochs of subjects performing one of six
activities. Since the subjects perform the activities for approximately two min., each subject/activity pair is a sequence of
about 50 rows.
Since the goal for which these data were collected is to develop an automatic activity classifier the data are divided into a 
training and test set as is usually done, and this is how these data are left in the data set.

The assignment only requires that we work with the 561 feature data set X_[train/test].txt and ID files; not the raw inertial data
X_train.txt has multiple rows with the same identifier values (subject, activity), row number could be considered a legitimate
time variable since it corresponds to a distinct observation.
In any event collapsing the groups of like subject activity pairs into a single row of means makes the output 
table unquestionably tidy.

The use of sophisticated melt() and dcast() functions was not necessary given the mostly tidy structure of these data.
All that should be necessary is keeping the implies key of row number consistent when "merging" rows and columns.
After reading (read.table, casting as numeric ), merging train & test with rbind2() and checking for NA or other non numbers,
grep is used to identify all the feature names with either mean or std.
(There are 33 mean/std pairs and 20 more features that have mean in the name like Mean frequency (13)from the frequency domain analysis
or from the angle function between two vectors(7).)
So rather than 66 cols I have 86 cols of "mean" features. The instructions were mnot clear on this so I chose to include the extra cols.
After adding the column names the combination of grep() and which() were used to create a selection index vector used to subset the cols. 
of the feature table.
Following this the  combined subject/activity columns were added with cbind2().
Now the 10299 by 88 subset table is ready for processing.
Defined in the script is a function doProject() that sets up an output data.frame and appends rows of colMeans() for each group of
subject activity pairs to produce a 180 by 88 output table written to the global environment.
It adds a column N_obs to indicate the number of observations on which the means are based (should be multiplied by 128 to get the original number of samples)
It also correctly labels the cols, and recodes the activity numbers for test-based labels.
Finally it writes the data to a csv file.

Details are found in the comments of the script.

In R-studio one "sources" the script and runs it step by step.





 
 
