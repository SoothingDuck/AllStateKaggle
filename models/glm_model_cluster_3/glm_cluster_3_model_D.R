
# Variables
y.letter <- "D"
y.variable <- "real_D"
percent.train <- .8
seed.value <- 42

start.check <- .5
end.check <- .9
step.check <- .2

csv.output.filename <- file.path("DATA","OUTPUT","result_model_glm_cluster_3_D.csv")
RData.output.filename <- file.path("DATA","OUTPUT","glm_model_cluster_3_D.RData")

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

# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data.R"))
source(file.path("templates","test_train_skeleton_cluster_3.R"))
source(file.path("templates","glm_skeleton_error_estimate_D.R"))
source(file.path("templates","glm_skeleton_final_training_D.R"))

