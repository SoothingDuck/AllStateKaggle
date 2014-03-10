library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Suppress real
data <- data[, ! grepl("real_", colnames(data))]

# Separation train, test
set.seed(42)
tmp <- get.base.train.test(data, "next_car_value", .8)

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

tmp <- get.base.train.test(dataTrainBase, "next_car_value", prob)
dataTrain <- tmp$train
  
# Evaluation modeles
print("Entrainement modele GLM a")
formula_a <- formula(
  I(next_car_value == "a") ~ .  
  )

model_a <- glm(
  formula_a
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM b")
formula_b <- formula(
  I(next_car_value == "b") ~ .  
)
model_b <- glm(
  formula_b
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM c")
formula_c <- formula(
  I(next_car_value == "c") ~ .  
)
model_c <- glm(
  formula_c
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM d")
formula_d <- formula(
  I(next_car_value == "d") ~ .  
)
model_d <- glm(
  formula_d
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM e")
formula_e <- formula(
  I(next_car_value == "e") ~ .  
)
model_e <- glm(
  formula_e
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM f")
formula_f <- formula(
  I(next_car_value == "f") ~ .  
)
model_f <- glm(
  formula_f
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM g")
formula_g <- formula(
  I(next_car_value == "g") ~ .  
)
model_g <- glm(
  formula_g
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM h")
formula_h <- formula(
  I(next_car_value == "h") ~ .  
)
model_h <- glm(
  formula_h
  , family = binomial, data=dataTrain)

print("Entrainement modele GLM i")
formula_i <- formula(
  I(next_car_value == "i") ~ .  
)
model_i <- glm(
  formula_i
  , family = binomial, data=dataTrain)

dataTest$predict_glm_a <- predict(model_a, newdata=dataTest)
dataTest$predict_glm_b <- predict(model_b, newdata=dataTest)
dataTest$predict_glm_c <- predict(model_c, newdata=dataTest)
dataTest$predict_glm_d <- predict(model_d, newdata=dataTest)
dataTest$predict_glm_e <- predict(model_e, newdata=dataTest)
dataTest$predict_glm_f <- predict(model_f, newdata=dataTest)
dataTest$predict_glm_g <- predict(model_g, newdata=dataTest)
dataTest$predict_glm_h <- predict(model_h, newdata=dataTest)
dataTest$predict_glm_i <- predict(model_i, newdata=dataTest)

dataTest$predicted_glm_next_car_value <- factor(letters[1:9][max.col(dataTest[,c(
  "predict_glm_a",
  "predict_glm_b",
  "predict_glm_c",
  "predict_glm_d",
  "predict_glm_e",
  "predict_glm_f",
  "predict_glm_g",
  "predict_glm_h",
  "predict_glm_i"
)])])

dataTrain$predict_glm_a <- predict(model_a, newdata=dataTrain)
dataTrain$predict_glm_b <- predict(model_b, newdata=dataTrain)
dataTrain$predict_glm_c <- predict(model_c, newdata=dataTrain)
dataTrain$predict_glm_d <- predict(model_d, newdata=dataTrain)
dataTrain$predict_glm_e <- predict(model_e, newdata=dataTrain)
dataTrain$predict_glm_f <- predict(model_f, newdata=dataTrain)
dataTrain$predict_glm_g <- predict(model_g, newdata=dataTrain)
dataTrain$predict_glm_h <- predict(model_h, newdata=dataTrain)
dataTrain$predict_glm_i <- predict(model_i, newdata=dataTrain)

dataTrain$predicted_glm_next_car_value <- factor(letters[1:9][max.col(dataTrain[,c(
  "predict_glm_a",
  "predict_glm_b",
  "predict_glm_c",
  "predict_glm_d",
  "predict_glm_e",
  "predict_glm_f",
  "predict_glm_g",
  "predict_glm_h",
  "predict_glm_i"
)])])

print("Error GLM Test:")
print(prediction_error(dataTest$next_car_value, dataTest$predicted_glm_next_car_value))

print("Error GLM Train:")
print(prediction_error(dataTrain$next_car_value, dataTrain$predicted_glm_next_car_value))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$next_car_value, dataTest$predicted_glm_next_car_value),
  error.glm.train=prediction_error(dataTrain$next_car_value, dataTrain$predicted_glm_next_car_value),
  error.glm.test.a=prediction_error(dataTest$next_car_value == "a", dataTest$predicted_glm_next_car_value == "a"),
  error.glm.train.a=prediction_error(dataTrain$next_car_value == "a", dataTrain$predicted_glm_next_car_value == "a"),
  error.glm.test.b=prediction_error(dataTest$next_car_value == "b", dataTest$predicted_glm_next_car_value == "b"),
  error.glm.train.b=prediction_error(dataTrain$next_car_value == "b", dataTrain$predicted_glm_next_car_value == "b"),
  error.glm.test.c=prediction_error(dataTest$next_car_value == "c", dataTest$predicted_glm_next_car_value == "c"),
  error.glm.train.c=prediction_error(dataTrain$next_car_value == "c", dataTrain$predicted_glm_next_car_value == "c"),
  error.glm.test.d=prediction_error(dataTest$next_car_value == "d", dataTest$predicted_glm_next_car_value == "d"),
  error.glm.train.d=prediction_error(dataTrain$next_car_value == "d", dataTrain$predicted_glm_next_car_value == "d"),
  error.glm.test.e=prediction_error(dataTest$next_car_value == "e", dataTest$predicted_glm_next_car_value == "e"),
  error.glm.train.e=prediction_error(dataTrain$next_car_value == "e", dataTrain$predicted_glm_next_car_value == "e"),
  error.glm.test.f=prediction_error(dataTest$next_car_value == "f", dataTest$predicted_glm_next_car_value == "f"),
  error.glm.train.f=prediction_error(dataTrain$next_car_value == "f", dataTrain$predicted_glm_next_car_value == "f"),
  error.glm.test.g=prediction_error(dataTest$next_car_value == "g", dataTest$predicted_glm_next_car_value == "g"),
  error.glm.train.g=prediction_error(dataTrain$next_car_value == "g", dataTrain$predicted_glm_next_car_value == "g"),
  error.glm.test.h=prediction_error(dataTest$next_car_value == "h", dataTest$predicted_glm_next_car_value == "h"),
  error.glm.train.h=prediction_error(dataTrain$next_car_value == "h", dataTrain$predicted_glm_next_car_value == "h"),
  error.glm.test.i=prediction_error(dataTest$next_car_value == "i", dataTest$predicted_glm_next_car_value == "i"),
  error.glm.train.i=prediction_error(dataTrain$next_car_value == "i", dataTrain$predicted_glm_next_car_value == "i")
)
)
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_next_car_value.csv"))

# Entrainement final
print("Entrainement modele GLM a final")
model_a_final_next_car_value <- glm(
  formula_a
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM b final")
model_b_final_next_car_value <- glm(
  formula_b
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM c final")
model_c_final_next_car_value <- glm(
  formula_c
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM d final")
model_d_final_next_car_value <- glm(
  formula_d
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM e final")
model_e_final_next_car_value <- glm(
  formula_e
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM f final")
model_f_final_next_car_value <- glm(
  formula_f
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM g final")
model_g_final_next_car_value <- glm(
  formula_g
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM h final")
model_h_final_next_car_value <- glm(
  formula_h
  , family = binomial, data=dataTrainBase)

print("Entrainement modele GLM i final")
model_i_final_next_car_value <- glm(
  formula_i
  , family = binomial, data=dataTrainBase)


# Sauvegarde des modeles
save(
  model_a_final_next_car_value, 
  model_b_final_next_car_value, 
  model_c_final_next_car_value, 
  model_d_final_next_car_value, 
  model_e_final_next_car_value, 
  model_f_final_next_car_value, 
  model_g_final_next_car_value, 
  model_h_final_next_car_value, 
  model_i_final_next_car_value, 
  file=file.path("DATA","OUTPUT","first_model_next_car_value.RData"))

