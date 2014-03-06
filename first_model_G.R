library(caret)
library(randomForest)

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "G")

# Separation train, test
trainIndex <- createDataPartition(data$real_G, p = .8,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
dataTest <- data[-trainIndex,]


# Estimation modeles
prediction_error <- function(true_data, predicted_data) {
  
  ok_prediction <- sum(true_data == predicted_data)
  ko_prediction <- sum(true_data != predicted_data)
  
  return ((ko_prediction)/(ok_prediction+ko_prediction))
}

# Test
list_prob <- c(.8)
prob <- .8

list_prob <- seq(.2, .8, .1)

result <- data.frame()

for(prob in list_prob) {
  
cat("Taille train : ", prob, "\n")

trainIndex <- createDataPartition(data$real_G, p = prob,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
  
# Evaluation modeles
print("Entrainement modele GLM 1")
model_1 <- glm(
  I(real_G == "1") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 2")
model_2 <- glm(
  I(real_G == "2") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 3")
model_3 <- glm(
  I(real_G == "3") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 4")
model_4 <- glm(
  I(real_G == "4") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)
dataTest$predict_glm_3 <- predict(model_3, newdata=dataTest)
dataTest$predict_glm_4 <- predict(model_4, newdata=dataTest)

dataTest$predicted_glm_G <- factor(max.col(dataTest[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")])+1)

dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)
dataTrain$predict_glm_2 <- predict(model_2, newdata=dataTrain)
dataTrain$predict_glm_3 <- predict(model_3, newdata=dataTrain)
dataTrain$predict_glm_4 <- predict(model_4, newdata=dataTrain)

dataTrain$predicted_glm_G <- factor(max.col(dataTrain[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")])+1)


print("Error GLM Test:")
print(prediction_error(dataTest$real_G, dataTest$predicted_glm_G))

print("Error GLM Train:")
print(prediction_error(dataTrain$real_G, dataTrain$predicted_glm_G))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$real_G, dataTest$predicted_glm_G),
  error.glm.train=prediction_error(dataTrain$real_G, dataTrain$predicted_glm_G)
)
)
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_G.csv"))

# Entrainement final
print("Entrainement modele GLM 1 final")
model_1_final_G <- glm(
  I(real_G == "1") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=data)

print("Entrainement modele GLM 2 final")
model_2_final_G <- glm(
  I(real_G == "2") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=data)

print("Entrainement modele GLM 3 final")
model_3_final_G <- glm(
  I(real_G == "3") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=data)

print("Entrainement modele GLM 4 final")
model_4_final_G <- glm(
  I(real_G == "4") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=data)

# Sauvegarde des modeles
save(model_1_final_G, model_2_final_G, model_3_final_G, model_4_final_G, file=file.path("DATA","OUTPUT","first_model_G.RData"))
