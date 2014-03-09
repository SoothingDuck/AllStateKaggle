library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "G")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_G", .8)

dataTrainBase <- tmp$train
dataTest <- tmp$test


# Estimation modeles

# Test
list_prob <- c(.5)
prob <- .5

list_prob <- seq(.1, .5, .2)

result <- data.frame()

for(prob in list_prob) {
  
cat("Taille train : ", prob, "\n")

tmp <- get.base.train.test(dataTrainBase, "real_G", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM 1")
model_1 <- glm(
  I(real_G == "1") ~ .
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 2")
model_2 <- glm(
  I(real_G == "2") ~ 
  state
  + location_popularity
  + G1_count
  + G2_count
  + G3_count
  + G4_count
  + last_view_car_value
  + last_view_C_previous
  + min_cost_view_cost
  + min_cost_view_A
  + last_view_C
  + last_view_G
  + min_cost_view_G
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 3")
model_3 <- glm(
  I(real_G == "3") ~ . 
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 4")
model_4 <- glm(
  I(real_G == "4") ~ . 
  , family = binomial, data=dataTrain)

dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)
dataTest$predict_glm_3 <- predict(model_3, newdata=dataTest)
dataTest$predict_glm_4 <- predict(model_4, newdata=dataTest)

dataTest$predicted_glm_G <- factor(max.col(dataTest[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")]))

dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)
dataTrain$predict_glm_2 <- predict(model_2, newdata=dataTrain)
dataTrain$predict_glm_3 <- predict(model_3, newdata=dataTrain)
dataTrain$predict_glm_4 <- predict(model_4, newdata=dataTrain)

dataTrain$predicted_glm_G <- factor(max.col(dataTrain[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")]))


print("Error GLM Test:")
print(prediction_error(dataTest$real_G, dataTest$predicted_glm_G))

print("Error GLM Train:")
print(prediction_error(dataTrain$real_G, dataTrain$predicted_glm_G))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$real_G, dataTest$predicted_glm_G),
  error.glm.train=prediction_error(dataTrain$real_G, dataTrain$predicted_glm_G),
  error.glm.test.1=prediction_error(dataTest$real_G == "1", dataTest$predicted_glm_G == "1"),
  error.glm.train.1=prediction_error(dataTrain$real_G == "1", dataTrain$predicted_glm_G == "1"),
  error.glm.test.2=prediction_error(dataTest$real_G == "2", dataTest$predicted_glm_G == "2"),
  error.glm.train.2=prediction_error(dataTrain$real_G == "2", dataTrain$predicted_glm_G == "2"),
  error.glm.test.3=prediction_error(dataTest$real_G == "3", dataTest$predicted_glm_G == "3"),
  error.glm.train.3=prediction_error(dataTrain$real_G == "3", dataTrain$predicted_glm_G == "3"),
  error.glm.test.4=prediction_error(dataTest$real_G == "4", dataTest$predicted_glm_G == "4"),
  error.glm.train.4=prediction_error(dataTrain$real_G == "4", dataTrain$predicted_glm_G == "4")
)
)
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_G_v2.csv"))

stop("Model à ajuster")

# Entrainement final
print("Entrainement modele GLM 1 final")
model_1_final_G <- glm(
  I(real_G == "1") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrainBase)

stop("a modifier")
print("Entrainement modele GLM 2 final")
model_2_final_G <- glm(
  I(real_G == "2") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 3 final")
model_3_final_G <- glm(
  I(real_G == "3") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM 4 final")
model_4_final_G <- glm(
  I(real_G == "4") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrainBase)

# Sauvegarde des modeles
save(model_1_final_G, model_2_final_G, model_3_final_G, model_4_final_G, file=file.path("DATA","OUTPUT","first_model_G.RData"))

rm(list=c(
  "model_1_final_G",
  "model_2_final_G",
  "model_3_final_G",
  "model_4_final_G"  
))

gc(TRUE)
