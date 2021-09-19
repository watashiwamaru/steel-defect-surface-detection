# Library

# Data wrangling
library(tidyverse)
library(tidyr)

# Image manipulation
library(imager)

# Deep learning
library(keras)

library(tensorflow)

library(caret)

library(shinydashboard)

library(shinythemes)

library(shiny)

library(rsconnect)

options(scipen = 999)

target_size <- c(256,256, 4)

categories <- c(1, 2, 3, 4)


train_list <- list.files("train/")
train_path <- paste0("train/", train_list)
train_name <- map(train_path, 
                  function(x) paste0(x, list.files(x))) %>% 
  unlist()

# test_path <-  paste0("D:/Algoritma Data Science Learning/DCD12/defect_detection/test")

model <- load_model_hdf5("www/model_keras.hdf5")


image_prep <- function(x) {
  arrays <- lapply(x, function(path) {
    img <- image_load(path, target_size = target_size,
                      grayscale = F # Set FALSE if image is RGB
    )

    x <- image_to_array(img)
    x <- array_reshape(x, c(1, dim(x)))
    x <- x/255 # rescale image pixel
  })
  do.call(abind::abind, c(arrays, list(along = 1)))
}
