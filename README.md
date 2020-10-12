# open_image_google_ai_converter
This script takes the output of [OIDv6](https://github.com/DmitryRyumin/OIDv6) and creates Google Vision AutoML compatible CSV files.

Requirements:
You need to install the dimensions gem ("gem install dimensions")


Usage:
./open_image_google_ai_converter.rb path_to_oidv6_dataset_folder your_google_storage_bucket_name

It wil spit out the CSV file that you can upload to Google AutoML Vision models along with the pictures.
It will basically create this format:

TRAIN,GOOGLE_BUCKET_URL_TO_PICTURE,LABEL,COORDINATES IN WEIRD 0-1 format


Example:
```
% ./open_image_google_ai_converter.rb ~/Downloads/dataset mygooglebucketname
TRAIN,gs://mygooglebucketname/squirrel_054016f3c062db4c.jpg,squirrel,0.37,0.05,,,0.91,0.86,,
TRAIN,gs://mygooglebucketname/bird_015999b27fffd5f8.jpg,bird,0.01,0.37,,,0.59,0.9,,
TRAIN,gs://mygooglebucketname/bird_015999b27fffd5f8.jpg,bird,0.38,0.13,,,0.71,0.63,,
TRAIN,gs://mygooglebucketname/bird_015999b27fffd5f8.jpg,bird,0.61,0.34,,,1.0,0.83,,
TRAIN,gs://mygooglebucketname/squirrel_1bf428228cf859f9.jpg,squirrel,0.49,0.54,,,0.68,0.71,,
TRAIN,gs://mygooglebucketname/dog_023452f5cfc72239.jpg,dog,0.18,0.58,,,0.43,0.83,,
TRAIN,gs://mygooglebucketname/dog_023452f5cfc72239.jpg,dog,0.39,0.53,,,0.65,0.83,,
TRAIN,gs://mygooglebucketname/dog_023452f5cfc72239.jpg,dog,0.4,0.24,,,0.49,0.36,,
TRAIN,gs://mygooglebucketname/dog_023452f5cfc72239.jpg,dog,0.49,0.22,,,0.59,0.35,,
TRAIN,gs://mygooglebucketname/dog_023452f5cfc72239.jpg,dog,0.59,0.22,,,0.68,0.33,,
[...]
```
