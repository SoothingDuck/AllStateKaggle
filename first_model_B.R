library(caret)
library(randomForest)

# Chargement des données d'entrainement
source("get_data.R")

# Selection variable à estimer
data <- select.final.variable(data, "B")

# Separation train, test
trainIndex <- createDataPartition(data$real_B, p = .8,
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

trainIndex <- createDataPartition(data$real_B, p = prob,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
  
# Evaluation modeles
print("Entrainement modele GLM 0")
model_0 <- glm(
  I(real_B == "0") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 1")
model_1 <- glm(
  I(real_B == "1") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
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
  I(real_B == "0") ~ .
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=data)

print("Entrainement modele GLM 1 final")
model_1_final_B <- glm(
  I(real_B == "1") ~ . 
  + I(first_view_day == last_view_day) 
  - first_view_day - last_view_day - min_cost_view_day
  , family = binomial, data=data)

# Sauvegarde des modeles
save(model_0_final_B, model_1_final_B, file=file.path("DATA","OUTPUT","first_model_B.RData"))
