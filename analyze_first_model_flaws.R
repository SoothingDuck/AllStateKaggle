library(caret)
library(randomForest)

# fonctions
source("functions.R")

# Chargement des données d'entrainement
source("get_data.R")

# Lecteur data
dataTrainBase <- read.csv(file=gzfile(file.path("DATA","train_first_model_prediction.csv.gz")))
dataTestBase <- read.csv(file=gzfile(file.path("DATA","test_first_model_prediction.csv.gz")))

# check
dataTrainBase <- compute.ABCDEF(dataTrainBase)
dataTestBase <- compute.ABCDEF(dataTestBase)

dataTrainBase <- compute.ABCDEFG(dataTrainBase)
dataTestBase <- compute.ABCDEFG(dataTestBase)
