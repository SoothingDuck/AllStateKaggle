
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
  
  dataTest$predicted_glm_F <- prediction_test
  
  prediction_train <- predict(model_rf, newdata=dataTrain)
  
  dataTrain$predicted_glm_F <- prediction_train
  
  print("Error RF Test:")
  print(prediction_error(dataTest$real_F, dataTest$predicted_glm_F))
  
  print("Error RF Train:")
  print(prediction_error(dataTrain$real_F, dataTrain$predicted_glm_F))
  
  df.importance <- data.frame(model_rf$importance)
  write.csv(x=df.importance, file=file.path("DATA","OUTPUT","model_rf_importance_F.csv"))
  
  result <- rbind(result, data.frame(
    size.train=prob, 
    error.glm.test=prediction_error(dataTest$real_F, dataTest$predicted_glm_F),
    error.glm.train=prediction_error(dataTrain$real_F, dataTrain$predicted_glm_F),
    error.glm.test.0=prediction_error(dataTest$real_F == "0", dataTest$predicted_glm_F == "0"),
    error.glm.train.0=prediction_error(dataTrain$real_F == "0", dataTrain$predicted_glm_F == "0"),
    error.glm.test.1=prediction_error(dataTest$real_F == "1", dataTest$predicted_glm_F == "1"),
    error.glm.train.1=prediction_error(dataTrain$real_F == "1", dataTrain$predicted_glm_F == "1"),
    error.glm.test.2=prediction_error(dataTest$real_F == "2", dataTest$predicted_glm_F == "2"),
    error.glm.train.2=prediction_error(dataTrain$real_F == "2", dataTrain$predicted_glm_F == "2"),
    error.glm.test.3=prediction_error(dataTest$real_F == "3", dataTest$predicted_glm_F == "3"),
    error.glm.train.3=prediction_error(dataTrain$real_F == "3", dataTrain$predicted_glm_F == "3")
  )
  )
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, csv.output.filename)

