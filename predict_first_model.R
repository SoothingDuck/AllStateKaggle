library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "real_E", .8)

dataTrainBase <- tmp$train
dataTest <- tmp$test

data <- dataTest

# Funcions
predict_A <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_A.RData"))
  
  tmp <- data.frame(
    predict_glm_0 = predict(model_0_final_A, newdata=data),
    predict_glm_1 = predict(model_1_final_A, newdata=data),
    predict_glm_2 = predict(model_2_final_A, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1))
  
}

predict_B <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_B.RData"))
  
  tmp <- data.frame(
    predict_glm_0 = predict(model_0_final_B, newdata=data),
    predict_glm_1 = predict(model_1_final_B, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_0","predict_glm_1")])-1))
  
}

predict_C <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_C.RData"))
  
  tmp <- data.frame(
    predict_glm_1 = predict(model_1_final_C, newdata=data),
    predict_glm_2 = predict(model_2_final_C, newdata=data),
    predict_glm_3 = predict(model_3_final_C, newdata=data),
    predict_glm_4 = predict(model_4_final_C, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_1","predict_glm_2", "predict_glm_3", 'predict_glm_4')])))
  
}

predict_D <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_D.RData"))
  
  tmp <- data.frame(
    predict_glm_1 = predict(model_1_final_D, newdata=data),
    predict_glm_2 = predict(model_2_final_D, newdata=data),
    predict_glm_3 = predict(model_3_final_D, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_1","predict_glm_2", "predict_glm_3")])))
  
}

predict_E <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_E.RData"))
  
  tmp <- data.frame(
    predict_glm_0 = predict(model_0_final_E, newdata=data),
    predict_glm_1 = predict(model_1_final_E, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_0","predict_glm_1")])-1))
  
}

predict_F <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_F.RData"))
  
  tmp <- data.frame(
    predict_glm_0 = predict(model_0_final_F, newdata=data),
    predict_glm_1 = predict(model_1_final_F, newdata=data),
    predict_glm_2 = predict(model_2_final_F, newdata=data),
    predict_glm_3 = predict(model_3_final_F, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_0","predict_glm_1","predict_glm_2","predict_glm_3")])-1))
  
}

predict_G <- function(data) {
  load(file=file.path("DATA","OUTPUT","first_model_G.RData"))
  
  tmp <- data.frame(
    predict_glm_1 = predict(model_1_final_G, newdata=data),
    predict_glm_2 = predict(model_2_final_G, newdata=data),
    predict_glm_3 = predict(model_3_final_G, newdata=data),
    predict_glm_4 = predict(model_4_final_G, newdata=data)
  )
  
  return(factor(max.col(tmp[,c("predict_glm_1","predict_glm_2","predict_glm_3","predict_glm_4")])))
  
}

# Prediction globale
print("predicting A...")
dataTest$predicted_A <- predict_A(dataTest)
print("predicting B...")
dataTest$predicted_B <- predict_B(dataTest)
print("predicting C...")
dataTest$predicted_C <- predict_C(dataTest)
print("predicting D...")
dataTest$predicted_D <- predict_D(dataTest)
print("predicting E...")
dataTest$predicted_E <- predict_E(dataTest)
print("predicting F...")
dataTest$predicted_F <- predict_F(dataTest)
print("predicting G...")
dataTest$predicted_G <- predict_G(dataTest)

dataTest$real_ABCDEF <- paste(
  as.character(dataTest$real_A),
  as.character(dataTest$real_B),
  as.character(dataTest$real_C),
  as.character(dataTest$real_D),
  as.character(dataTest$real_E),
  as.character(dataTest$real_F),
  sep=""
  )

dataTest$predicted_ABCDEF <- paste(
  as.character(dataTest$predicted_A),
  as.character(dataTest$predicted_B),
  as.character(dataTest$predicted_C),
  as.character(dataTest$predicted_D),
  as.character(dataTest$predicted_E),
  as.character(dataTest$predicted_F),
  sep=""
)

dataTest$real_ABCDEFG <- paste(
  as.character(dataTest$real_A),
  as.character(dataTest$real_B),
  as.character(dataTest$real_C),
  as.character(dataTest$real_D),
  as.character(dataTest$real_E),
  as.character(dataTest$real_F),
  as.character(dataTest$real_G),
  sep=""
)

dataTest$predicted_ABCDEFG <- paste(
  as.character(dataTest$predicted_A),
  as.character(dataTest$predicted_B),
  as.character(dataTest$predicted_C),
  as.character(dataTest$predicted_D),
  as.character(dataTest$predicted_E),
  as.character(dataTest$predicted_F),
  as.character(dataTest$predicted_G),
  sep=""
)

cat("prediction error ABCDEF  : ", prediction_error(dataTest$real_ABCDEF, dataTest$predicted_ABCDEF))

cat("prediction error ABCDEFG : ", prediction_error(dataTest$real_ABCDEFG, dataTest$predicted_ABCDEFG))
