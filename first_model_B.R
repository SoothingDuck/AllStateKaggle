library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "B")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_B", .8)

dataTrainBase <- tmp$train
dataTest <- tmp$test


# Estimation modeles

# Test
list_prob <- c(.8)
prob <- .8

list_prob <- seq(.1, .9, .1)

result <- data.frame()

for(prob in list_prob) {
  
cat("Taille train : ", prob, "\n")

tmp <- get.base.train.test(dataTrainBase, "real_B", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM 0")
formula_0 <- formula(
  I(real_B == "0") ~ .
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
  I(real_B == "1") ~ .
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

dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)

dataTest$predicted_glm_B <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1")])-1)

dataTrain$predict_glm_0 <- predict(model_0, newdata=dataTrain)
dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)

dataTrain$predicted_glm_B <- factor(max.col(dataTrain[,c("predict_glm_0","predict_glm_1")])-1)


print("Error GLM Test:")
print(prediction_error(dataTest$real_B, dataTest$predicted_glm_B))

print("Error GLM Train:")
print(prediction_error(dataTrain$real_B, dataTrain$predicted_glm_B))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$real_B, dataTest$predicted_glm_B),
  error.glm.train=prediction_error(dataTrain$real_B, dataTrain$predicted_glm_B),
  error.glm.test.0=prediction_error(dataTest$real_B == "0", dataTest$predicted_glm_B == "0"),
  error.glm.train.0=prediction_error(dataTrain$real_B == "0", dataTrain$predicted_glm_B == "0"),
  error.glm.test.1=prediction_error(dataTest$real_B == "1", dataTest$predicted_glm_B == "1"),
  error.glm.train.1=prediction_error(dataTrain$real_B == "1", dataTrain$predicted_glm_B == "1")
)
)
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_B.csv"))

# Entrainement final
print("Entrainement modele GLM 0 final")
model_0_final_B <- glm(
  formula_0
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 1 final")
model_1_final_B <- glm(
  formula_1
  , family = binomial, data=dataTrainBase)

# Sauvegarde des modeles
save(model_0_final_B, model_1_final_B, file=file.path("DATA","OUTPUT","first_model_B.RData"))

