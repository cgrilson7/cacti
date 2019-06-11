# Setup (after cloning from GH)
# Get the data
source("setup/0_get_kaggle_data.R")
get_kaggle_dataset("aerial-cactus-identification", "input/")

# Sort files into training & validation directories
source("setup/1_impose_file_structure.R")
