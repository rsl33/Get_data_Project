Get_data_Project
================

Run_analysis, etc.

The goal of this project is to transform a given data set into a tidy data set complete with README file, code book,
and R processing script, Run_analysis.R.
 
Get_data_Project
================

Run_analysis, etc.

The goal of this project is to transform a given data set into a tidy data set complete with README file (this file), code book, and processing 
script in R. These three files are contained in this repo.
This file gives an overview of prerequisites to accomplish the task with the R script provided here some orientation about how the given 
data were transformed into a tidy data set according to the instructions.
The code book provides some explanation of from where these data came and what they mean.

The script run_analysis.R included in this repo has comments that describe how each step was accomplished.
The output file is 180 rows (one obs. for each subj/activity pair) by 88 columns (means of means & means of standard deviations from the original
processed data set) and called "tidy_activity.csv"

For the processing R script "run_analysis.R" to run the following files from the given data set must be present in your working R directory.

1. features.txt
2. subject_BLANK.txt
3. X_BLANK.txt
4. y_BLANK.txt

Where BLANK = "train" or "test"; seven files in all.


The specific instruction were as follows: (complete assignment found below)

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

These data were collected to develop a human activity (such as walking, upstairs, downstairs, etc.) classifer based on 
3D data from the two sensors in the smart phone worn at the waist of the subjects.

The processed data given for further processing consist of three files, including a single column of subject ID numbers, a single column of 
activity codes (1-6), and a table of 561 columns comprising the features derived from the 9 variables of raw data.
The raw data consist of three inertial variables in three dimensions of physical space (X,Y,Z); hence 9 files.
These are total acceleration, body, acceleration (total-gravity), and gyroscopic angular momentum.
The files of the data set are implicitly keyed by row number; (i.e. related files have the same number of rows and correspond to the same
observation across files).
These data on 30 subjects and six activities were separated into two parts; one to train the classifier (21 subjects) and the other to test 
the classifier (9 subjects), see conference paper ref(Davide Anguita1, Alessandro Ghio, Luca Oneto, Xavier Parra2, and Jorge L. Reyes-Ortiz1,2,
Human Activity Recognition on Smartphones Using a Multiclass Hardware-Friendly Support Vector Machine,  in J. Bravo, R. Herv´as, and M. Rodr´ıguez
(Eds.): IWAAL 2012, LNCS 7657, pp. 216–223, 2012.). 

The deatiled description of these data are not complete and are also not detailed in the above reference article, so I will provide by best guess 
about the interpretation of these data.

Perhaps another publication of these results has a more detailed description of the data collection and methods. 

The training set consists of 7352 rows and the test set has 2947; there are a different number of rows for each subject 
I presume indicating that each subject performed the activity for a slightly different amount of time.
There are no missing values. 
The raw data consist of two sets of nine files each with one variable and the corresponding number of rows.
There are 128 columns in each file which I believe correspond to a sampling window in one of the processing techniques.
Since the data are sampled at 50Hz I presume this corresponds to 2.5 s of real time per row. Since each subject/activity pair corresponds 
to ~50 rows this implies a subject did an activity for about 125 s or 2 min; which seems reasonable.
Not all subjects have the same number of rows and there is no missing data.
Since each raw data file is one variable it should be just a single column even though there is an experimental design reason to make 
it 128 columns; the size of the windowed sample.

There is not much description of how the investigators went from 9 variables to 561 features of the original processed data set.
Our job was to extract the variables that were means or standard deviations and then construct a dataset with the means for those 
180 subject/activity pairs. As it turned out the processing creates a 10299 x 561 table, subsets 86 columns, and and by taking group means,
reduces it to a 180 x 88 table (two ID columns added) table of means)

The specific tasks are as follows:

 You should create one R script called run_analysis.R that does the following. 

    1. Merges the training and the test sets to create one data set.
    2. Extracts only the measurements on the mean and standard deviation for each measurement. 
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names. 
    5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

The script run_analysis.R included in this repo has comments that describe how each step was accomplished.
The output file is 180 rows by 88 columns and called "tidy_activity.csv"


For the script to run the following files from the given data set must be present in your working R directory.

1. features.txt
2. subject_blank.txt
3. X_blank.txt
4. y_blank.txt

Where blank = train or test; seven files in all.

Note: There are some ambiguities in both the data description and in the project assignment.
For example one might be interested in the mean of variables for a specific activity across all subjects (i.a table of 6 rows).
Something like this and other data format can easily be obtained from the tidy data set provided by this project.

