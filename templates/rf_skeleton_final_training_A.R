# Entrainement final
print("Entrainement modele RF final A")
model_rf_final_A <- randomForest(
  formula_rf, 
  data=dataTrainBase,
  ntree=150,
  importance=TRUE,
  do.trace=TRUE
)

prediction_train <- predict(model_rf, newdata=dataTrain)

dataTrainBase$predicted_glm_A <- prediction_train

print(table(dataTrainBase$predicted_glm_A))

# Sauvegarde des modeles
save(model_rf_final_A, file=RData.output.filename)
