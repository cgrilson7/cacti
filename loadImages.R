train_img_dir <- "~/cacti/input/train/"
valid_img_dir <- "~/cacti/input/valid/"
train_data_gen <- image_data_generator(rescale=1/255) # many more options for augmentation of the images, just rescaling here so that values in each channel lie between 0 and 1
valid_data_gen <- train_data_gen # for now, the same as the train image_data_generator

# Target size of images after loading/augmenting
img_width <- 32
img_height <- 32
img_dims <- c(img_width, img_height)

train <- flow_images_from_directory(train_img_dir,
                                    train_data_gen,
                                    target_size=img_dims,
                                    color_mode="rgb",
                                    class_mode="binary",
                                    seed=42)
table(factor(train$classes))

valid <- flow_images_from_directory(valid_img_dir,
                                    valid_data_gen,
                                    target_size=img_dims,
                                    color_mode="rgb",
                                    class_mode="binary",
                                    seed=42)
table(factor(valid$classes))