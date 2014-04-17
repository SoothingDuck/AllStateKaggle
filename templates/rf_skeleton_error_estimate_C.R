
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
  
  dataTest$predicted_glm_C <- prediction_test
  
  prediction_train <- predict(model_rf, newdata=dataTrain)
  
  dataTrain$predicted_glm_C <- prediction_train
  
  print("Error RF Test:")
  print(prediction_error(dataTest$real_C, dataTest$predicted_glm_C))
  
  print("Error RF Train:")
  print(prediction_error(dataTrain$real_C, dataTrain$predicted_glm_C))
  
  df.importance <- data.frame(model_rf$importance)
  write.csv(x=df.importance, file=file.path("DATA","OUTPUT","model_rf_importance_C.csv"))
    
  result <- rbind(result, data.frame(
    size.train=prob, 
    error.glm.test=prediction_error(dataTest$real_C, dataTest$predicted_glm_C),
    error.glm.train=prediction_error(dataTrain$real_C, dataTrain$predicted_glm_C),
    error.glm.test.0=prediction_error(dataTest$real_C == "0", dataTest$predicted_glm_C == "0"),
    error.glm.train.0=prediction_error(dataTrain$real_C == "0", dataTrain$predicted_glm_C == "0"),
    error.glm.test.1=prediction_error(dataTest$real_C == "1", dataTest$predicted_glm_C == "1"),
    error.glm.train.1=prediction_error(dataTrain$real_C == "1", dataTrain$predicted_glm_C == "1")
  )
  )
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, csv.output.filename)

