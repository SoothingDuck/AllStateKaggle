
# Variables
y.letter <- "G"
y.variable <- "real_G"
percent.train <- .8
seed.value <- 42

start.check <- .5
end.check <- .9
step.check <- .2

csv.output.filename <- file.path("DATA","OUTPUT","result_model_G.csv")
RData.output.filename <- file.path("DATA","OUTPUT","first_model_G.RData")

# Formules
formula_1 <- formula(
  paste("I(",y.variable," == \"1\") ~ .", sep = "")
)

formula_2 <- formula(
  paste("I(",y.variable," == \"2\") ~ .", sep = "")
)

formula_3 <- formula(
  paste("I(",y.variable," == \"3\") ~ .", sep = "")
)

formula_4 <- formula(
  paste("I(",y.variable," == \"4\") ~ .", sep = "")
)

# fonctions
source("functions.R")
source("get_data.R")
source(file.path("templates","test_train_skeleton_all_clusters.R"))
source(file.path("templates","glm_skeleton_error_estimate_G.R"))
source(file.path("templates","glm_skeleton_final_training_G.R"))
