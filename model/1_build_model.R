# Fit and train LeNet-5-based model ---------------------------------------
# As detailed in Lopez-Jimenez et al (2019) - the study from which this dataset comes

batch_size <- 32
epochs <- 50

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