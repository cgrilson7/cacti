# importData
metadata <- read_csv("~/cacti/input/train.csv")

# Split original "train" into train and validation sets
train_rows <- caret::createDataPartition(metadata$has_cactus, p = 0.8, list=FALSE)
train_files <- metadata[train_rows,]
train_files_0 <- train_files[train_files$has_cactus == 0,] # 0 = FALSE = no cacti
train_files_1 <- train_files[train_files$has_cactus == 1,] # 1 = TRUE = yes cacti

valid_files <- metadata[-train_rows,]
valid_files_0 <- valid_files[valid_files$has_cactus == 0,]
valid_files_1 <- valid_files[valid_files$has_cactus == 1,]

# Move train files around
# First, specify "train" as the base dir to hold both classes of train data
train_img_dir <- "~/cacti/input/train/" # base directory (original)
train_0_dir <- "~/cacti/input/train/0/" # directory for train images without cacti
if(!dir.exists(train_0_dir)) dir.create(train_0_dir)
filesstrings::move_files(paste0(train_img_dir, train_files_0$id), train_0_dir)

train_1_dir <- "~/cacti/input/train/1/" # directory for train images without cacti
if(!dir.exists(train_1_dir)) dir.create(train_1_dir)
filesstrings::move_files(paste0(train_img_dir, train_files_1$id), train_1_dir)

# Move validation files around
# First, make a "valid/" base dir to hold both classes of validation data
valid_img_dir <- "~/cacti/input/valid/"
if(!dir.exists(valid_img_dir)) dir.create(valid_img_dir)

# Move the '0' (non-cactus) validation files to a new '0' folder
valid_0_dir <- "~/cacti/input/valid/0/"
if(!dir.exists(valid_0_dir)) dir.create(valid_0_dir)
filesstrings::move_files(paste0(train_img_dir, valid_files_0$id), valid_0_dir)

# Move the '1' (yes-cactus) validation files to a new '0' folder
valid_1_dir <- "~/cacti/input/valid/1/"
if(!dir.exists(valid_1_dir)) dir.create(valid_1_dir)
filesstrings::move_files(paste0(train_img_dir, valid_files_1$id), valid_1_dir)