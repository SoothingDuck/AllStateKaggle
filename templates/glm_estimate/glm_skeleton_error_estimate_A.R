
# Estimation modeles

list_prob <- seq(start.check, end.check, step.check)

result <- data.frame()

for(prob in list_prob) {
  
  cat("Taille train : ", prob, "\n")
  
  tmp <- get.base.train.test(dataTrainBase, y.variable, prob)
  dataTrain <- tmp$train
  
  formula_0 <- formula(
    I(real_A == 0) ~
      state
    + car_age
    + car_value
    + risk_factor
    + last_cost
    + last_A
    #+ age_youngest
    + age_oldest
    #+ last_F
    + shopping_pt_2_A
    #+ shopping_pt_2_F
    + shopping_pt_3_A
    #+ shopping_pt_3_F
    + shopping_pt_min_cost_A
    #+ shopping_pt_min_cost_F
    + A0_location_pct
  )
  
  # Evaluation modeles  
  print("Entrainement modele GLM 0")
  model_0 <- glm(
    formula_0
    , family = binomial, data=dataTrain, trace = TRUE)
    
  print("Entrainement modele GLM 1")
  formula_1 <- formula(
    I(real_A == 1) ~ 
    A1_location_pct
    + shopping_pt_min_cost_F
    + shopping_pt_min_cost_A
    + shopping_pt_3_F
    + shopping_pt_3_A
    + shopping_pt_2_F
    + shopping_pt_2_A
    + last_F
    + last_E
    + last_A
    + last_cost
    + duration_previous
    + age_oldest
    + car_age
    + state
    + day*last_A
  )
  
  model_1 <- glm(
    formula_1
    , family = binomial, data=dataTrain, trace = TRUE)
  
  print("Entrainement modele GLM 2")
  formula_2 <- formula(
    I(real_A == 2) ~ .
  )

  model_2 <- glm(
    formula_2
    , family = binomial, data=dataTrain, trace = TRUE)
  
  
  dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
  dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
  dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)
  
  dataTest$predicted_glm_A <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1)
  
  dataTrain$predict_glm_0 <- predict(model_0, newdata=dataTrain)
  dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)
  dataTrain$predict_glm_2 <- predict(model_2, newdata=dataTrain)
  
  dataTrain$predicted_glm_A <- factor(max.col(dataTrain[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1)
  
  
  print("Error GLM Test:")
  print(prediction_error(dataTest$real_A, dataTest$predicted_glm_A))
  
  print("Error GLM Train:")
  print(prediction_error(dataTrain$real_A, dataTrain$predicted_glm_A))
  
  result <- rbind(result, data.frame(
    size.train=prob, 
    error.glm.test=prediction_error(dataTest$real_A, dataTest$predicted_glm_A),
    error.glm.train=prediction_error(dataTrain$real_A, dataTrain$predicted_glm_A),
    error.glm.test.0=prediction_error(dataTest$real_A == "0", dataTest$predicted_glm_A == "0"),
    error.glm.train.0=prediction_error(dataTrain$real_A == "0", dataTrain$predicted_glm_A == "0"),
    error.glm.test.1=prediction_error(dataTest$real_A == "1", dataTest$predicted_glm_A == "1"),
    error.glm.train.1=prediction_error(dataTrain$real_A == "1", dataTrain$predicted_glm_A == "1"),
    error.glm.test.2=prediction_error(dataTest$real_A == "2", dataTest$predicted_glm_A == "2"),
    error.glm.train.2=prediction_error(dataTrain$real_A == "2", dataTrain$predicted_glm_A == "2")
  )
  )
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, csv.output.filename)

