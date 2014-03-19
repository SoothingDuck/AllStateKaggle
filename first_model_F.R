library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "F")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_F", .8)

dataTrainBase <- tmp$train
dataTest <- tmp$test


# Estimation modeles

# Test
list_prob <- c(.8)
prob <- .8

list_prob <- seq(.1, .5, .2)

result <- data.frame()

for(prob in list_prob) {
  
cat("Taille train : ", prob, "\n")

tmp <- get.base.train.test(dataTrainBase, "real_F", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM 0")
formula_0 <- formula(
  I(real_F == "0") ~ .
  - location_A_proba_3
  - location_B_proba_2
  - location_C_proba_4
  - location_D_proba_3
  - location_E_proba_2
  - location_F_proba_4
  - location_G_proba_4
  
)

model_0 <- glm(
  formula_0
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 1")
formula_1 <- formula(
  I(real_F == "1") ~ .
  - location_A_proba_3
  - location_B_proba_2
  - location_C_proba_4
  - location_D_proba_3
  - location_E_proba_2
  - location_F_proba_4
  - location_G_proba_4
  
)

model_1 <- glm(
  formula_1
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 2")
formula_2 <- formula(
  I(real_F == "2") ~ .
  - location_A_proba_3
  - location_B_proba_2
  - location_C_proba_4
  - location_D_proba_3
  - location_E_proba_2
  - location_F_proba_4
  - location_G_proba_4
  
)

model_2 <- glm(
  formula_2
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 3")
formula_3 <- formula(
  I(real_F == "3") ~ .
  - location_A_proba_3
  - location_B_proba_2
  - location_C_proba_4
  - location_D_proba_3
  - location_E_proba_2
  - location_F_proba_4
  - location_G_proba_4
  
)

model_3 <- glm(
  formula_3
  , family = binomial, data=dataTrain)

dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)
dataTest$predict_glm_3 <- predict(model_3, newdata=dataTest)

dataTest$predicted_glm_F <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1","predict_glm_2","predict_glm_3")])-1)

dataTrain$predict_glm_0 <- predict(model_0, newdata=dataTrain)
dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)
dataTrain$predict_glm_2 <- predict(model_2, newdata=dataTrain)
dataTrain$predict_glm_3 <- predict(model_3, newdata=dataTrain)

dataTrain$predicted_glm_F <- factor(max.col(dataTrain[,c("predict_glm_0","predict_glm_1","predict_glm_2","predict_glm_3")])-1)


print("Error GLM Test:")
print(prediction_error(dataTest$real_F, dataTest$predicted_glm_F))

print("Error GLM Train:")
print(prediction_error(dataTrain$real_F, dataTrain$predicted_glm_F))

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

write.csv(result, file.path("DATA","OUTPUT","result_model_F.csv"))

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

# Sauvegarde des modeles
save(model_0_final_F, model_1_final_F, model_2_final_F, model_3_final_F,file=file.path("DATA","OUTPUT","first_model_F.RData"))
