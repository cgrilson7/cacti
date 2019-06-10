# This script downloads the data from the Kaggle competition, using `kaggler`, an R package that interacts with the Kaggle API
# kaggler documentation: https://github.com/mkearney/kaggler

# devtools::install_github("https://github.com/mkearney/kaggler")
# Note: must authorize with API token. Go to https://www.kaggle.com/{username}/account, create new token, save kaggle.json download as ~/.kaggle/kaggle.json

library(kaggler)
library(readr)
comp_id <- 13435
file_list <- kgl_competitions_data_list(comp_id)

my_kgl_competitions_data_download <- function(my_id, my_fileName){
  assign(my_fileName, kgl_competitions_data_download(my_id, my_fileName))
}
lapply(file_list$name, my_kgl_competitions_data_download, my_id = comp_id)
# not working... done manually instead, placed files in input/