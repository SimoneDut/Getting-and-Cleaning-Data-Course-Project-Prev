# Code Book
  
## Variables in the final dataset
  
- `subject`  
An ID from 1 to 30 indicating the volunteer (the experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years)
  
- `activity`  
`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`, indicating one of the 6 activities performed
  
- `other columns`  
The average of the variable indicated in the column name, calculated for each `subject` and each `activity`.  
To decode the variable names:
    - `time`: time domain signals
    - `frequency`: frequency domain signals
    - `body`: body motion components
    - `gravity`: gravitational components
    - `accelerometer`: accelerometer signals
    - `gyroscope`: gyroscope signals
    - `jerk`: derivative of linear acceleration (`accelerometer`) or angular velocity (`gyroscope`) with respect to time
    - `mean`: the mean
    - `standard deviation`: the standard deviation
    - `X` / `Y` / `Z`: the axis that the variable refers to
    - `magnitude`: the magnitude of 3D signals calculated using the Euclidean norm
  
## Final dataset
  
- The final tidy dataset is stored in the file `output.txt`
  
## Transformations performed
  
#### Preprocessing
- Downloading and unzipping the raw data file, if necessary
- Reading the files: importing the raw data as data.frame objects from the .txt files included within the raw data zip file
  
#### Main transformations
1. Merge the training and the test sets to create one data set
2. Extract only the measurements on the mean and standard deviation for each measurement (plus subject and activity)
3. Use descriptive activity names to name the activities in the data set, by replacing the numeric coding with the 6 names describing each activity
4. Appropriately labels the data set with descriptive variable names:
    - Correcting the mistakenly labeled `BodyBody` to `Body`
    - Replacing the initial `t` and `f` with `time` and `frequency` respectively
    - Replacing `Body`, `Gravity`, `Acc`, `Gyro`, `Jerk` and `Mag` with `body`,  `gravity`, `accelerometer`, `gyroscope`, `jerk`, `magnitude` respectively, adding a space before each word
    - Replacing `-mean()` and `-std()` with `mean` and `standard deviation` respectively, adding a space before each word
    - Replacing `-X`, `-Y` and `-Z` with `X`, `Y` and `Z` respectively, adding a space before each word
5. Create a second, independent tidy data set with the average of each variable for each activity and each subject
  
#### Prostprocessing
- Output the final data set as `output.txt` with the option `row.name = FALSE`