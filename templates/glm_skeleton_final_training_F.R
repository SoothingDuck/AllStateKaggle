# Entrainement final
print("Entrainement modele GLM 0 final")
model_0_final_F <- glm(
  formula_0
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 1 final")
model_1_final_F <- glm(
  formula_1
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 2 final")
model_2_final_F <- glm(
  formula_2
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 3 final")
model_3_final_F <- glm(
  formula_3
  , family = binomial, data=dataTrainBase)


dataTrainBase$predict_glm_0 <- predict(model_0_final_F, newdata=dataTrainBase)
dataTrainBase$predict_glm_1 <- predict(model_1_final_F, newdata=dataTrainBase)
dataTrainBase$predict_glm_2 <- predict(model_2_final_F, newdata=dataTrainBase)
dataTrainBase$predict_glm_3 <- predict(model_3_final_F, newdata=dataTrainBase)

dataTrainBase$predicted_glm_F <- factor(max.col(dataTrainBase[,c("predict_glm_0","predict_glm_1","predict_glm_2","predict_glm_3")]))


# Sauvegarde des modeles
save(model_0_final_F, model_1_final_F, model_2_final_F, model_3_final_F, file=RData.output.filename)
