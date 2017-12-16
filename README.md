# UCI-Activity-Tracking

 You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
 
 [Line 1: Line 51] of the run_analysis.R Script the script will first read test set of X and y, training set of X and y, Subject Names of test and training set, feature label and activity label into the memory using read.table().

[Line 53:Line 56] the Subject name of test and training set is combined and asisgned with a column name "SubjectNames".

[Line 59:Line 63] training set and test set of X are joint with rbind() so are the training set and test set of y.

[Line 65:Line 69] the combined y is assigned with the column name "Activity", transformed from numberic value into activity labels using a for loop and then appended to the combined X variables. The subject is added to the first column of the combined dataset with the name set_all.

[Line 71] a new dataset named set_independent is created using group_by() and select() as a dataset contains only mean and std variables and grouped into Activity and Subject Names.

[Line 73:Line 83] the average of each variable in the set_indenpendent dataset is calculated using summarise_(), mean() and a for loop.
