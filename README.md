# The following steps are taken in order to achieve a tidy data set

## 1. The read_table function from the readr package is used to extract data from all relevant files

## 2. The appropriate column names from the "features" file is match to x_test and x_train

## 3. x_test and x_trans respectively are being matched and combined with the subject_test/subject_train and y_test/ytrain data

## 4. (Optional)Added an additional column indicating whether the obs belonged to train and trans

## 5. Combined the train and test data set

## 6. Filtered out statistical columns that does not give the mean or sd with the help of grepl

## 7. Replaced 1:6 with activity names 

## 8. Used gather and extract to seperate the value column to further distill data

## 9. Used dplyr functions to answer Q5