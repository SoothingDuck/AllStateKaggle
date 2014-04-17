# Entrainement final
print("Entrainement modele RF final B")
model_rf_final_B <- randomForest(
  formula_rf, 
  data=dataTrainBase,
  ntree=150,
  importance=TRUE,
  do.trace=TRUE
)

prediction_train <- predict(model_rf, newdata=dataTrain)

dataTrainBase$predicted_glm_B <- prediction_train

print(table(dataTrainBase$predicted_glm_B))

# Sauvegarde des modeles
save(model_rf_final_B, file=RData.output.filename)
