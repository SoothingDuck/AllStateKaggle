library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "E")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_E", .8)

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

tmp <- get.base.train.test(dataTrainBase, "real_E", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM 0")
formula_0 <- formula(
  I(real_E == "0") ~ .  
  )

model_0 <- glm(
  formula_0
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 1")
formula_1 <- formula(
  I(real_E == "1") ~ .  
)

model_1 <- glm(
  formula_1
  , family = binomial, data=dataTrain)

dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)

dataTest$predicted_glm_E <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1")])-1)

dataTrain$predict_glm_0 <- predict(model_0, newdata=dataTrain)
dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)

dataTrain$predicted_glm_E <- factor(max.col(dataTrain[,c("predict_glm_0","predict_glm_1")])-1)


print("Error GLM Test:")
print(prediction_error(dataTest$real_E, dataTest$predicted_glm_E))

print("Error GLM Train:")
print(prediction_error(dataTrain$real_E, dataTrain$predicted_glm_E))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$real_E, dataTest$predicted_glm_E),
  error.glm.train=prediction_error(dataTrain$real_E, dataTrain$predicted_glm_E),
  error.glm.test.0=prediction_error(dataTest$real_E == "0", dataTest$predicted_glm_E == "0"),
  error.glm.train.0=prediction_error(dataTrain$real_E == "0", dataTrain$predicted_glm_E == "0"),
  error.glm.test.1=prediction_error(dataTest$real_E == "1", dataTest$predicted_glm_E == "1"),
  error.glm.train.1=prediction_error(dataTrain$real_E == "1", dataTrain$predicted_glm_E == "1")
)
)
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_E.csv"))

# Entrainement final
print("Entrainement modele GLM 0 final")
model_0_final_E <- glm(
  formula_0
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 1 final")
model_1_final_E <- glm(
  formula_1
  , family = binomial, data=dataTrainBase)

# Sauvegarde des modeles
save(model_0_final_E, model_1_final_E, file=file.path("DATA","OUTPUT","first_model_E.RData"))
