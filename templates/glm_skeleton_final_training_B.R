# Entrainement final
print("Entrainement modele GLM 0 final")
model_0_final_B <- glm(
  formula_0
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 1 final")
model_1_final_B <- glm(
  formula_1
  , family = binomial, data=dataTrainBase)


dataTrainBase$predict_glm_0 <- predict(model_0_final_B, newdata=dataTrainBase)
dataTrainBase$predict_glm_1 <- predict(model_1_final_B, newdata=dataTrainBase)

dataTrainBase$predicted_glm_B <- factor(max.col(dataTrainBase[,c("predict_glm_0","predict_glm_1")])-1)

print(table(dataTrainBase$predicted_glm_B))

# Sauvegarde des modeles
save(model_0_final_B, model_1_final_B, file=RData.output.filename)
