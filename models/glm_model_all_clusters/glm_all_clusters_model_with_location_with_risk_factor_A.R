
print("Calcul model A...")

# Variables
y.letter <- "A"
y.variable <- "real_A"
percent.train <- .8
seed.value <- 42

start.check <- .5
end.check <- .9
step.check <- .2

type <- "with_location_with_risk_factor"

csv.output.filename <- file.path("DATA","OUTPUT",paste("result_model_glm_all_clusters", type,",A.csv", sep = "_"))
RData.output.filename <- file.path("DATA","OUTPUT",paste("first_model_glm_all_clusters", type, "A.RData", sep = "_"))

# Formules
formula_0 <- formula(
  paste("I(",y.variable," == \"0\") ~ .", sep = "")
)

formula_1 <- formula(
  paste("I(",y.variable," == \"1\") ~ .", sep = "")
)

formula_2 <- formula(
  paste("I(",y.variable," == \"2\") ~ .", sep = "")
)

# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates",paste("get_data_glm_model", type, ".R", sep = "_")))
source(file.path("templates","test_train_skeleton_all_clusters.R"))
source(file.path("templates","glm_skeleton_error_estimate_A.R"))
source(file.path("templates","glm_skeleton_final_training_A.R"))
