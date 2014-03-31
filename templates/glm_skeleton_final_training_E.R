# Entrainement final
print("Entrainement modele GLM 0 final")
model_0_final_E <- glm(
  formula_0
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 1 final")
model_1_final_E <- glm(
  formula_1
  , family = binomial, data=dataTrainBase)


dataTrainBase$predict_glm_0 <- predict(model_0_final_E, newdata=dataTrainBase)
dataTrainBase$predict_glm_1 <- predict(model_1_final_E, newdata=dataTrainBase)

dataTrainBase$predicted_glm_E <- factor(max.col(dataTrainBase[,c("predict_glm_0","predict_glm_1")])-1)

print(table(dataTrainBase$predicted_glm_E))

# Sauvegarde des modeles
save(model_0_final_E, model_1_final_E, file=RData.output.filename)
