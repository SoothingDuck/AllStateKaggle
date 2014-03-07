library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "A")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_A", .8)

dataTrainBase <- tmp$train
dataTest <- tmp$test

# Estimation modeles

# Test
list_prob <- c(.8)
prob <- .8

list_prob <- seq(.1, .9, .2)

result <- data.frame()

for(prob in list_prob) {
  
cat("Taille train : ", prob, "\n")

tmp <- get.base.train.test(dataTrainBase, "real_A", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM 0")
model_0 <- glm(
  I(real_A == "0") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 1")
model_1 <- glm(
  I(real_A == "1") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 2")
model_2 <- glm(
  I(real_A == "2") ~  .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  - first_view_duration_previous - last_view_duration_previous - min_cost_view_duration_previous
  , family = binomial, data=dataTrain)

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

write.csv(result, file.path("DATA","OUTPUT","result_model_A.csv"))

# Entrainement final
print("Entrainement modele GLM 0 final")
model_0_final_A <- glm(
  I(real_A == "0") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 1 final")
model_1_final_A <- glm(
  I(real_A == "1") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 2 final")
model_2_final_A <- glm(
  I(real_A == "2") ~  .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  - first_view_duration_previous - last_view_duration_previous - min_cost_view_duration_previous
  , family = binomial, data=dataTrainBase)

# Sauvegarde des modeles
save(model_0_final_A, model_1_final_A, model_2_final_A, file=file.path("DATA","OUTPUT","first_model_A.RData"))
