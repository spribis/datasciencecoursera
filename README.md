## The Purpose

# The script is designed to take the data from the following source file

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# and obtain the average (mean) value of each of the mean and standard deviation variables by subject and activity.  It creates a single tidy data set in which each variable and activity is labeled.


## The Design

# The script first reads in each of the 8 required files as data frames.  It then creates an additional variable called "set" that indicates which set the subject's data was partitioned into, while aligning the subject and activity data with the data values, and then it appends the train data to the test data.  Next, it uses the "features" data to assign the variables their names, and then subsets only the variables of interest (mean and standard deviation).  Then it merges with the activity labels, and finally uses the melt and dcast functions in the reshape2 package to compute the mean of each of the desired variables by subject and activity, and writes that data frame to a table.