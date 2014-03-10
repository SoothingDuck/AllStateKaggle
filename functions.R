library(caret)

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
