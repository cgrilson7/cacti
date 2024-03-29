# This script downloads the data from the Kaggle competition
# Note: must authorize with API token. Go to https://www.kaggle.com/{username}/account, create new token, save kaggle.json download as ~/.kaggle/kaggle.json
# Uses the 'kaggler' package to get the list of all competition data files
    # kaggler documentation: https://github.com/mkearney/kaggler
    # devtools::install_github("https://github.com/mkearney/kaggler")

get_kaggle_dataset <- function(comp_id, dest_folder_path){
  # Create dir to hold files
  if(!dir.exists(dest_folder_path)) dir.create(dest_folder_path)
  # Check if files are already there
  comp_files_list <- kaggler::kgl_competitions_data_list(comp_id)
  if(all(file.exists(paste0("input/", comp_files_list$name)))){
    stop(paste0("Files already present in ", dest_folder_path))
  }
  # If not, download them!
  system(
    # Invoke two OS commands (assuming Mac/Linux):
    paste(
      # 1. Get to where we want to put the files
      paste0("cd ", dest_folder_path), 
      # 2. Run kaggle API command to download all competition files
      paste0("kaggle competitions download -c ", comp_name), 
      # Concatenate to one line, separating commands by ';'
      sep="; "
    )
  )
  # If there are any zip files, unzip them
  zip_files <- dir(path=dest_folder_path, full.names=TRUE) %>% grep(".zip", ., value=T)
  if(length(zip_files) > 0){
    for(zf in zip_files) unzip(zf)
  }
  # Show the structure new directory (downloaded files and .zip file contents)
  print(dir(dest_folder_path))
}
