# Fit model 
checkpoint_dir <- "checkpoints"
dir.create(checkpoint_dir, showWarnings = FALSE)
filepath <- file.path(checkpoint_dir, "weights.{epoch:02d}-{val_loss:.2f}.hdf5")

# Create checkpoint callback
cp_callback <- callback_model_checkpoint(
  filepath = filepath,
  save_weights_only = TRUE
)

hist <- model %>% fit_generator(
  generator = train_batches,
  
  steps_per_epoch = as.integer(train_batches$n / batch_size), 
  epochs = epochs, 
  
  validation_data = valid_batches,
  validation_steps = as.integer(valid_batches$n / batch_size),
  
  callbacks=list(cp_callback),
  
  verbose = 2
)

plot(hist)