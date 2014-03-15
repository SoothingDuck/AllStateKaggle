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

# Test
list_prob <- c(.5)
prob <- .5

list_prob <- seq(.1, .9, .1)

result <- data.frame()

tmp <- get.base.train.test(dataTrainBase, "real_G", prob)
dataTrain <- tmp$train

# Chargement des modèles
load(file=file.path("DATA","OUTPUT","first_model_G.RData"))

rm(list=c("model_1_final_G", "model_3_final_G", "model_4_final_G"))
dataTest$predict_glm_2 <- predict(model_2_final_G, newdata=dataTest)
dataTrain$predict_glm_2 <- predict(model_2_final_G, newdata=dataTrain)

# Différenciation
good.set <- (((dataTest$predict_glm_2 > 0) & (dataTest$real_G == "2")) | ((dataTest$predict_glm_2 <= 0) & (dataTest$real_G != "2")))

good.prediction.set <- dataTest[good.set,]
bad.prediction.set <- dataTest[! good.set,]
