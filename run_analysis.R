
# Welcome
# I might have a few errors so keep cool!

	# OKAY -- STEP ONE MERGE THE DATA
		x_train <- read.table("train/X_train.txt")
		y_train <- read.table("train/y_train.txt")
		subject_train <- read.table("train/subject_train.txt")

		x_test <- read.table("test/X_test.txt")
		y_test <- read.table("test/y_test.txt")
		subject_test <- read.table("test/subject_test.txt")

	# Stil going well -- need to create the X, Y and SUBJECT data so that I'm good to go
		x_data <- rbind(x_train, x_test)
		y_data <- rbind(y_train, y_test)
 
		subject_data <- rbind(subject_train, subject_test)
 
	#YAY NO ERRORS

# Next STEP TWO: Lets get the mean and standard dev.
	features <- read.table("features.txt")
	mean_and_std_features <- grep("-(mean|std)\\(\\)", features[, 2])
	x_data <- x_data[, mean_and_std_features]
	names(x_data) <- features[mean_and_std_features, 2]

# Okay that worked ... STEP THREE: Now I need to name the activities
	activities <- read.table("activity_labels.txt")
	y_data[, 1] <- activities[y_data[, 1], 2]
	names(y_data) <- "activity"
 
# Still going strong -- Now step 4: is to label the data via descriptive form
	names(subject_data) <- "subject"
	all_data <- cbind(x_data, y_data, subject_data)

# FINALLY, Step 5:I need to create a second independent data set.
	averages_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
	write.table(averages_data, "averages_data.txt", row.name=FALSE)

# Hope you enjoyed!!
