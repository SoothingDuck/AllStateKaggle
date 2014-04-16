library(randomForest)

# Estimation modeles

list_prob <- seq(start.check, end.check, step.check)

result <- data.frame()

for(prob in list_prob) {
  
  cat("Taille train : ", prob, "\n")
  
  tmp <- get.base.train.test(dataTrainBase, y.variable, prob)
  dataTrain <- tmp$train
  
  # Evaluation modeles
  print("Entrainement modele RF")
  model_rf <- randomForest(
    formula_rf, 
    data=dataTrain,
    ntree=70,
    importance=TRUE,
    do.trace=TRUE
  )
    
  prediction_test <- predict(model_rf, newdata=dataTest)
  
  dataTest$predicted_glm_A <- prediction_test
  
  prediction_train <- predict(model_rf, newdata=dataTrain)
  
  dataTrain$predicted_glm_A <- prediction_train
  
  
  print("Error GLM Test:")
  print(prediction_error(dataTest$real_A, dataTest$predicted_glm_A))
  
  print("Error GLM Train:")
  print(prediction_error(dataTrain$real_A, dataTrain$predicted_glm_A))
  
  result <- rbind(result, data.frame(
    size.train=prob, 
    error.glm.test=prediction_error(dataTest$real_A, dataTest$predicted_glm_A),
    error.glm.train=prediction_error(dataTrain$real_A, dataTrain$predicted_glm_A),
    error.glm.test.0=prediction_error(dataTest$real_A == "0", dataTest$predicted_glm_A == "0"),
    error.glm.train.0=prediction_error(dataTrain$real_A == "0", dataTrain$predicted_glm_A == "0"),
    error.glm.test.1=prediction_error(dataTest$real_A == "1", dataTest$predicted_glm_A == "1"),
    error.glm.train.1=prediction_error(dataTrain$real_A == "1", dataTrain$predicted_glm_A == "1"),
    error.glm.test.2=prediction_error(dataTest$real_A == "2", dataTest$predicted_glm_A == "2"),
    error.glm.train.2=prediction_error(dataTrain$real_A == "2", dataTrain$predicted_glm_A == "2")
  )
  )
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, csv.output.filename)

