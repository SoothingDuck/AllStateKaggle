library(caret)
library(randomForest)

source("get_data.R")

# Separation train, test
trainIndex <- createDataPartition(data$real_A, p = .8,
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

trainIndex <- createDataPartition(data$real_A, p = prob,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
  
# Evaluation modeles
print("Entrainement modele GLM 0")
model_0 <- glm(
  I(real_A == "0") ~ .
  - first_view_C - last_view_C
  - first_view_D - last_view_D
  - first_view_E - last_view_E
  - first_view_F - last_view_F
  - first_view_G - last_view_G
  - first_view_hour
  - minutes_elapsed
  - first_view_married_couple
  - first_view_age_youngest
  - first_view_age_oldest
  - first_view_group_size
  + I(first_view_day == last_view_day)
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 1")
model_1 <- glm(
  I(real_A == "1") ~ . 
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM 2")
model_2 <- glm(
  I(real_A == "2") ~  .
  , family = binomial, data=dataTrain)

# model_rf <- randomForest(
#   last_view_A ~ . - state
#   + I(first_view_day == last_view_day),
#   data=dataTrain,
#   importance=TRUE,
#   do.trace=TRUE,
#   ntree=20
#   )

dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)

dataTest$predicted_glm_A <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1)
# dataTest$predicted_rf_A <- predict(model_rf, newdata=dataTest)

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
  error.glm.train=prediction_error(dataTrain$real_A, dataTrain$predicted_glm_A)
)
)
  
}

print(result)
