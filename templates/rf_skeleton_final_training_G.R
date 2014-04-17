# Entrainement final
print("Entrainement modele RF final G")
model_rf_final_G <- randomForest(
  formula_rf, 
  data=dataTrainBase,
  ntree=150,
  importance=TRUE,
  do.trace=TRUE
)

prediction_train <- predict(model_rf, newdata=dataTrain)

dataTrainBase$predicted_glm_G <- prediction_train

print(table(dataTrainBase$predicted_glm_G))

# Sauvegarde des modeles
save(model_rf_final_G, file=RData.output.filename)
