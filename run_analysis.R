run_analysis<-function(dataFolder){
    # 
    #     You should create one R script called run_analysis.R that does 
    #            the following. 
    #     1. Merges the training and the test sets to create one data set.
    #     2. Extracts only the measurements on the mean and standard 
    #           deviation for each measurement. 
    #     3. Uses descriptive activity names to name the activities in  
    #           the data set
    #     4. Appropriately labels the data set with descriptive variable 
    #         names. 
    #     5. From the data set in step 4, creates a second, independent 
    #           tidy data set with the average of each variable for each 
    #           activity and each subject.    
    
    ##################################################################    
    #this loads in all the relavent data files from the dataset
    dataFolder="UCI HAR Dataset"
    
    library(dplyr)
    
    features<-read.table(paste(dataFolder, '/','features.txt',sep = ""))
    activity_labels<-read.table('activity_labels.txt')
    train_subject<-read.table('train/subject_train.txt')
    train_set<-read.table('train/X_train.txt')
    train_labels<-read.table('train/y_train.txt')
    test_set<-read.table('test/X_test.txt')
    test_labels<-read.table('test/y_test.txt')
    test_subject<- read.table('test/subject_test.txt')
    
    ##################################################################
        #1. Merges the training and the test sets to create one data set.
    
    train_set_comb<-cbind(train_subject,train_labels,train_set)
    test_set_comb<-cbind(test_subject,test_labels,test_set)
    final_comb_full<-rbind(train_set_comb,test_set_comb)
    ##################################################################    
    #2. Extracts only the measurements on the mean and standard 
    #    deviation for each measurement. 
    
    #this finds the column counts that match mean and std
    # this pulls the mean() values
    feature_subset<-features[grep("mean()", features[,2],fixed = TRUE), ]
    
    # this pulls the std() values and adds it to the mean
    feature_subset<-rbind(feature_subset,features[grep("std()", features[,2],fixed = TRUE), ])
    
    #this creates a new column that transposes the column numbers over 2 
    # to mimic the merged dataset and sorted
    
    feature_subset$transform <- feature_subset$V1 + 2
    feature_subset<-feature_subset[order(feature_subset$transform),]
    
    final_comb_mean_std_subset<-final_comb_full[,c(1,2,feature_subset$transform)]
    
    ##################################################################
    #3. Uses descriptive activity names to name the activities in  
    #    the data set
    
    #this matches the second column based on actvity labels table
    hold<-left_join(final_comb_mean_std_subset,activity_labels,by=c("V1.1" ="V1"))

    # this replaces the numbers in the second column with the values
    hold[,c("V1.1")]<-hold[,c("V2.y")]
    
    #this creats the finsl table
    final_comb_mean_std_subset<-hold[,1:68]
    
    ##################################################################
    #4. Appropriately labels the data set with descriptive variable 
    #  names. 
    
    colnames(final_comb_mean_std_subset)<-c("Subject","Activity",as.character(feature_subset$V2))

    
    ##################################################################
    # 5. From the data set in step 4, creates a second, independent 
    # tidy data set with the average of each variable for each 
    # activity and each subject.    

    data_summary <- final_comb_mean_std_subset %>%
        group_by(Subject,Activity) %>%
        summarise_each(funs(mean))
    
    write.table(data_summary,file="sumarized_tidy_dataset.txt",row.names = FALSE)
    
}