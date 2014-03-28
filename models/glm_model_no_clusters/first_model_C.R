library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "C")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_C", .8)

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

tmp <- get.base.train.test(dataTrainBase, "real_C", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM 1")
formula_1 <- formula(
  I(real_C == "1") ~ .
  )

model_1 <- glm(
  formula_1
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 2")
formula_2 <- formula(
  I(real_C == "2") ~ .
  )

model_2 <- glm(
  formula_2
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 3")
formula_3 <- formula(
  I(real_C == "3") ~ .
  )

model_3 <- glm(
  formula_3
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 4")
formula_4 <- formula(
  I(real_C == "4") ~ .
  )

model_4 <- glm(
  formula_4
  , family = binomial, data=dataTrain)

dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)
dataTest$predict_glm_3 <- predict(model_3, newdata=dataTest)
dataTest$predict_glm_4 <- predict(model_4, newdata=dataTest)

dataTest$predicted_glm_C <- factor(max.col(dataTest[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")]))

dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)
dataTrain$predict_glm_2 <- predict(model_2, newdata=dataTrain)
dataTrain$predict_glm_3 <- predict(model_3, newdata=dataTrain)
dataTrain$predict_glm_4 <- predict(model_4, newdata=dataTrain)

dataTrain$predicted_glm_C <- factor(max.col(dataTrain[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")]))


print("Error GLM Test:")
print(prediction_error(dataTest$real_C, dataTest$predicted_glm_C))

print("Error GLM Train:")
print(prediction_error(dataTrain$real_C, dataTrain$predicted_glm_C))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$real_C, dataTest$predicted_glm_C),
  error.glm.train=prediction_error(dataTrain$real_C, dataTrain$predicted_glm_C),
  error.glm.test.1=prediction_error(dataTest$real_C == "1", dataTest$predicted_glm_C == "1"),
  error.glm.train.1=prediction_error(dataTrain$real_C == "1", dataTrain$predicted_glm_C == "1"),
  error.glm.test.2=prediction_error(dataTest$real_C == "2", dataTest$predicted_glm_C == "2"),
  error.glm.train.2=prediction_error(dataTrain$real_C == "2", dataTrain$predicted_glm_C == "2"),
  error.glm.test.3=prediction_error(dataTest$real_C == "3", dataTest$predicted_glm_C == "3"),
  error.glm.train.3=prediction_error(dataTrain$real_C == "3", dataTrain$predicted_glm_C == "3"),
  error.glm.test.4=prediction_error(dataTest$real_C == "4", dataTest$predicted_glm_C == "4"),
  error.glm.train.4=prediction_error(dataTrain$real_C == "4", dataTrain$predicted_glm_C == "4")
)
)
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_C.csv"))

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

# Sauvegarde des modeles
save(model_1_final_C, model_2_final_C, model_3_final_C, model_4_final_C, file=file.path("DATA","OUTPUT","first_model_C.RData"))
