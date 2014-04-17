
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
    ntree=150,
    importance=TRUE,
    do.trace=TRUE
  )
  
  prediction_test <- predict(model_rf, newdata=dataTest)
  
  dataTest$predicted_glm_E <- prediction_test
  
  prediction_train <- predict(model_rf, newdata=dataTrain)
  
  dataTrain$predicted_glm_E <- prediction_train
  
  print("Error RF Test:")
  print(prediction_error(dataTest$real_E, dataTest$predicted_glm_E))
  
  print("Error RF Train:")
  print(prediction_error(dataTrain$real_E, dataTrain$predicted_glm_E))
  
  result <- rbind(result, data.frame(
    size.train=prob, 
    error.glm.test=prediction_error(dataTest$real_E, dataTest$predicted_glm_E),
    error.glm.train=prediction_error(dataTrain$real_E, dataTrain$predicted_glm_E),
    error.glm.test.0=prediction_error(dataTest$real_E == "0", dataTest$predicted_glm_E == "0"),
    error.glm.train.0=prediction_error(dataTrain$real_E == "0", dataTrain$predicted_glm_E == "0"),
    error.glm.test.1=prediction_error(dataTest$real_E == "1", dataTest$predicted_glm_E == "1"),
    error.glm.train.1=prediction_error(dataTrain$real_E == "1", dataTrain$predicted_glm_E == "1")
  )
  )
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, csv.output.filename)

