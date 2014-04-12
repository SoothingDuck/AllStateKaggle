library(caret)

get.train.test.transition.A <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_A == debut)
  
  trainIndex <- createDataPartition(data$real_A == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_A == fin)
  test$y <- with(test, real_A == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_A", colnames(train))]
  test <- test[, ! grepl("last_A", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_G_", colnames(train))]
  test <- test[, ! grepl("percent_transition_G_", colnames(test))]
  
  return(list(train=train, test=test))
  
}


get.train.test.transition.B <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_B == debut)
  
  trainIndex <- createDataPartition(data$real_B == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_B == fin)
  test$y <- with(test, real_B == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_B", colnames(train))]
  test <- test[, ! grepl("last_B", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_G_", colnames(train))]
  test <- test[, ! grepl("percent_transition_G_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

get.train.test.transition.C <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_C == debut)
  
  trainIndex <- createDataPartition(data$real_C == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_C == fin)
  test$y <- with(test, real_C == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_C", colnames(train))]
  test <- test[, ! grepl("last_C", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_G_", colnames(train))]
  test <- test[, ! grepl("percent_transition_G_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

get.train.test.transition.D <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_D == debut)
  
  trainIndex <- createDataPartition(data$real_D == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_D == fin)
  test$y <- with(test, real_D == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_D", colnames(train))]
  test <- test[, ! grepl("last_D", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_G_", colnames(train))]
  test <- test[, ! grepl("percent_transition_G_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

get.train.test.transition.E <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_E == debut)
  
  trainIndex <- createDataPartition(data$real_E == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_E == fin)
  test$y <- with(test, real_E == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_E", colnames(train))]
  test <- test[, ! grepl("last_E", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_G_", colnames(train))]
  test <- test[, ! grepl("percent_transition_G_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

get.train.test.transition.F <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_F == debut)
  
  trainIndex <- createDataPartition(data$real_F == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_F == fin)
  test$y <- with(test, real_F == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_F", colnames(train))]
  test <- test[, ! grepl("last_F", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_G_", colnames(train))]
  test <- test[, ! grepl("percent_transition_G_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

get.train.test.transition.G <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_G == debut)
  
  trainIndex <- createDataPartition(data$real_G == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_G == fin)
  test$y <- with(test, real_G == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_G", colnames(train))]
  test <- test[, ! grepl("last_G", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

get.base.train.test <- function(data, column.name, p) {
  trainIndex <- createDataPartition(data[,c(column.name)], p = p,
                                    list = FALSE,
                                    times = 1)
  
  return(list(
    train=data[trainIndex,],
    test=data[-trainIndex,]
  ))
  
}

prediction_error <- function(true_data, predicted_data) {
  
  ok_prediction <- sum(true_data == predicted_data)
  ko_prediction <- sum(true_data != predicted_data)
  
  return ((ko_prediction)/(ok_prediction+ko_prediction))
}


num.errors <- function(vector_A, vector_B) {
  nchar_A <- nchar(vector_A)[1]
  nchar_B <- nchar(vector_B)[1]
  
  stopifnot(nchar_A == nchar_B)
  stopifnot(length(vector_A) == length(vector_B))
  
  tmp <- rep(0, length(vector_A))
  
  for(i in 1:nchar_A) {
    tmp <- tmp + ifelse(substr(vector_A,i,i) == substr(vector_B,i,i), 0, 1)
  }
  
  return(tmp)
}

compute.ABCDEF <- function(data) {
  
  data$predicted_ABCDEF <- paste(
    as.character(data$predicted_A),
    as.character(data$predicted_B),
    as.character(data$predicted_C),
    as.character(data$predicted_D),
    as.character(data$predicted_E),
    as.character(data$predicted_F),
    sep = ""
  )
  
  data$real_ABCDEF <- paste(
    as.character(data$real_A),
    as.character(data$real_B),
    as.character(data$real_C),
    as.character(data$real_D),
    as.character(data$real_E),
    as.character(data$real_F),
    sep = ""
  )
  
  return(data)
}

compute.ABCDEFG <- function(data) {
  
  data$predicted_ABCDEFG <- paste(
    as.character(data$predicted_A),
    as.character(data$predicted_B),
    as.character(data$predicted_C),
    as.character(data$predicted_D),
    as.character(data$predicted_E),
    as.character(data$predicted_F),
    as.character(data$predicted_G),
    sep = ""
  )
  
  data$real_ABCDEFG <- paste(
    as.character(data$real_A),
    as.character(data$real_B),
    as.character(data$real_C),
    as.character(data$real_D),
    as.character(data$real_E),
    as.character(data$real_F),
    as.character(data$real_G),
    sep = ""
  )
  
  return(data)
}
