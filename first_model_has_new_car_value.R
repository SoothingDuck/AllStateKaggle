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
list_prob <- c(.8)
prob <- .8

list_prob <- seq(.3, .9, .1)

# Formules
formula_has_new_car_value <- formula(
  I(as.character(next_car_value) != as.character(last_view_car_value)) ~ .
  - first_view_duration_previous
  - last_view_duration_previous
  - min_cost_view_duration_previous
)

# Calcul
result <- data.frame()

for(prob in list_prob) {
  
  cat("Taille train : ", prob, "\n")
  
  tmp <- get.base.train.test(dataTrainBase, "next_car_value", prob)
  dataTrain <- tmp$train
  
  # Evaluation modeles
  print("Entrainement modele GLM has_new")
  model_has_new_car_value <- glm(
    formula_has_new_car_value
    , family = binomial, data=dataTrain)
    
  dataTest$predict_glm_has_new_car_value <- (predict(model_has_new_car_value, newdata=dataTest) > 0)
  
  dataTrain$predict_glm_has_new_car_value <- (predict(model_has_new_car_value, newdata=dataTrain) > 0)
    
  print("Error GLM Test:")
  print(prediction_error(as.character(dataTest$next_car_value) != as.character(dataTest$last_view_car_value), dataTest$predict_glm_has_new_car_value))
  
  print("Error GLM Train:")
  print(prediction_error(as.character(dataTrain$next_car_value) != as.character(dataTrain$last_view_car_value), dataTrain$predict_glm_has_new_car_value))
  
  result <- rbind(result, data.frame(
    size.train=prob, 
    error.glm.test=prediction_error(as.character(dataTest$next_car_value) != as.character(dataTest$last_view_car_value), dataTest$predict_glm_has_new_car_value),
    error.glm.train=prediction_error(as.character(dataTrain$next_car_value) != as.character(dataTrain$last_view_car_value), dataTrain$predict_glm_has_new_car_value)
  )
  )
  
}

# Sauvegarde CR erreurs
print(result)

write.csv(result, file.path("DATA","OUTPUT","result_model_has_new_car_value.csv"))

# Entrainement final
print("Entrainement modele GLM has new car final")
model_final_has_new_car_value <- glm(
  formula_has_new_car_value
  , family = binomial, data=dataTrainBase)



# Sauvegarde des modeles
save(
  model_final_has_new_car_value, 
  file=file.path("DATA","OUTPUT","first_model_has_new_car_value.RData"))

