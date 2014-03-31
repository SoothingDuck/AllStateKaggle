# Entrainement final
print("Entrainement modele GLM 1 final")
model_1_final_C <- glm(
  formula_1
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 2 final")
model_2_final_C <- glm(
  formula_2
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 3 final")
model_3_final_C <- glm(
  formula_3
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 4 final")
model_4_final_C <- glm(
  formula_4
  , family = binomial, data=dataTrainBase)

dataTrainBase$predict_glm_1 <- predict(model_1_final_C, newdata=dataTrainBase)
dataTrainBase$predict_glm_2 <- predict(model_2_final_C, newdata=dataTrainBase)
dataTrainBase$predict_glm_3 <- predict(model_3_final_C, newdata=dataTrainBase)
dataTrainBase$predict_glm_4 <- predict(model_4_final_C, newdata=dataTrainBase)

dataTrainBase$predicted_glm_C <- factor(max.col(dataTrainBase[,c("predict_glm_1","predict_glm_2", "predict_glm_3", "predict_glm_4")]))

print(table(dataTrainBase$predicted_glm_C))

# Sauvegarde des modeles
save(model_1_final_C, model_2_final_C, model_3_final_C, model_4_final_C, file=RData.output.filename)
