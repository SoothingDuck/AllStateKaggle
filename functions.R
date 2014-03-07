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

