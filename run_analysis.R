install.packages(readr)
install.packages(dplyr)
library(readr)
library(dplyr)
read.table("features.txt") -> features

#reading test files
read_table("test/X_test.txt", col_names = F) -> x_test
read_table("test/y_test.txt", col_names = F) -> y_test
read_table("test/subject_test.txt", col_names = F) -> subject_test

#reading train files
read_table("train/x_train.txt", col_names = F) -> x_train
read_table("train/y_train.txt", col_names = F) -> y_train
read_table("train/subject_train.txt", col_names = F) -> subject_train

#naming data
colnames(x_test) <- features[,2]
colnames(x_train) <- features[,2]

#merging and extracting relevant data
cbind(x_test, activity = y_test$X1, subject_id = subject_test$X1) -> test_comb
cbind(x_train, activity = y_train$X1, subject_id = subject_train$X1) -> train_comb
test_comb$test_train <- "test" 
train_comb$test_train <- "train"
rbind(test_comb, train_comb) -> comb
comb1 <- comb[,grepl("mean\\(\\)", names(comb)) | grepl("std\\(\\)", names(comb))]
comb1 <- cbind(comb1, activity = comb$activity, test_train = comb$test_train, subject_id = comb$subject_id)

#Adding Activity Names
comb1$activity[comb1$activity == 1] <- "walking"
comb1$activity[comb1$activity == 2] <- "walking_upstairs"
comb1$activity[comb1$activity == 3] <- "walking_downstairs"
comb1$activity[comb1$activity == 4] <- "sitting"
comb1$activity[comb1$activity == 5] <- "standing"
comb1$activity[comb1$activity == 6] <- "laying"

#tidying data
tidycomb <- comb1 %>%
  gather(key, value, -activity, -test_train, -subject_id) %>%
  extract(col = key, into = c("study","stat","xyz"), "^(.*)\\-(.*)\\(\\)-(.$)")

#Output Data
write.table(tidycomb, "tidydata.txt")

#Q5 - Second data set
Q5 <- tidycomb %>%
  filter(stat == "mean") %>%
  group_by(subject_id, activity, xyz) %>%
  summarize(mean(value))
