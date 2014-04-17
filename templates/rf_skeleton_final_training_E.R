# Entrainement final
print("Entrainement modele RF final E")
model_rf_final_E <- randomForest(
  formula_rf, 
  data=dataTrainBase,
  ntree=150,
  importance=TRUE,
  do.trace=TRUE
)

prediction_train <- predict(model_rf, newdata=dataTrain)

dataTrainBase$predicted_glm_E <- prediction_train

print(table(dataTrainBase$predicted_glm_E))

# Sauvegarde des modeles
save(model_rf_final_E, file=RData.output.filename)
