# model
source("~/cacti/loadImages.R")

train_n <- train$n
valid_n <- valid$n

# Need to tune these hyperparameters!
batch_size <- 32
epochs <- 50

# Following the design of the adapted LeNet-5 model as detailed in Lopez-Jimenez et al (2019)
model <- keras_model_sequential()
model %>%
  layer_conv_2d(filters=6, kernel_size=c(3,3), strides=1, padding="same", input_shape = c(32,32,3)) %>%
  layer_activation("relu") %>%
  layer_max_pooling_2d(pool_size=c(2,2), strides=2) %>%
  
  layer_conv_2d(filters=16, kernel_size=c(5,5), strides=1) %>%
  layer_activation("relu") %>%
  layer_max_pooling_2d(pool_size = c(2,2), strides=2) %>%
  
  layer_flatten() %>%
  
  layer_dense(units=120) %>%
  layer_activation("relu") %>%
  
  layer_dense(units=84) %>%
  layer_activation("relu") %>%
  
  # Paper uses log(softmax) output layer and negative log-likelihood loss; # I'll use sigmoid output and binary cross-entropy loss
  layer_dense(units=1) %>%
  layer_activation("sigmoid")

model %>% compile(
  loss = "binary_crossentropy",
  optimizer = "adam",
  metrics = "accuracy"
)

# fit
hist <- model %>% fit_generator(
  # training data
  generator = train,
  
  # epochs
  steps_per_epoch = as.integer(train_n / batch_size), 
  epochs = epochs, 
  
  # validation data
  validation_data = valid,
  validation_steps = as.integer(valid_n / batch_size),
  
  # print progress
  verbose = 2
)

plot(hist)
# save(model, batch_size, epochs, file = "first_try.Rdata")
