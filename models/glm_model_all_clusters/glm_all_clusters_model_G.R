
# Variables
y.letter <- "G"
y.variable <- "real_G"
percent.train <- .8
seed.value <- 42

start.check <- .5
end.check <- .9
step.check <- .2

csv.output.filename <- file.path("DATA","OUTPUT","result_model_glm_all_clusters_G.csv")
RData.output.filename <- file.path("DATA","OUTPUT","first_model_glm_all_clusters_G.RData")

# Formules
formula_1 <- formula(
  I(real_G == 1) ~ .
  - percent_transition_G_1_vers_1
  #- percent_transition_G_1_vers_2
  #- percent_transition_G_1_vers_3
  #- percent_transition_G_1_vers_4
  - percent_transition_G_2_vers_1
  #- percent_transition_G_2_vers_2
  #- percent_transition_G_2_vers_3
  #- percent_transition_G_2_vers_4
  - percent_transition_G_3_vers_1
  #- percent_transition_G_3_vers_2
  #- percent_transition_G_3_vers_3
  #- percent_transition_G_3_vers_4
  - percent_transition_G_4_vers_1
  #- percent_transition_G_4_vers_2
  #- percent_transition_G_4_vers_3
  #- percent_transition_G_4_vers_4
)

formula_2 <- formula(
  I(real_G == 2) ~ .
  #- percent_transition_G_1_vers_1
  - percent_transition_G_1_vers_2
  #- percent_transition_G_1_vers_3
  #- percent_transition_G_1_vers_4
  #- percent_transition_G_2_vers_1
  - percent_transition_G_2_vers_2
  #- percent_transition_G_2_vers_3
  #- percent_transition_G_2_vers_4
  #- percent_transition_G_3_vers_1
  - percent_transition_G_3_vers_2
  #- percent_transition_G_3_vers_3
  #- percent_transition_G_3_vers_4
  #- percent_transition_G_4_vers_1
  - percent_transition_G_4_vers_2
  #- percent_transition_G_4_vers_3
  #- percent_transition_G_4_vers_4
)

formula_3 <- formula(
  I(real_G == 3) ~ .
  #- percent_transition_G_1_vers_1
  #- percent_transition_G_1_vers_2
  - percent_transition_G_1_vers_3
  #- percent_transition_G_1_vers_4
  #- percent_transition_G_2_vers_1
  #- percent_transition_G_2_vers_2
  - percent_transition_G_2_vers_3
  #- percent_transition_G_2_vers_4
  #- percent_transition_G_3_vers_1
  #- percent_transition_G_3_vers_2
  - percent_transition_G_3_vers_3
  #- percent_transition_G_3_vers_4
  #- percent_transition_G_4_vers_1
  #- percent_transition_G_4_vers_2
  - percent_transition_G_4_vers_3
  #- percent_transition_G_4_vers_4
)

formula_4 <- formula(
  I(real_G == 4) ~ .
  - percent_transition_G_1_vers_1
  - percent_transition_G_1_vers_2
  - percent_transition_G_1_vers_3
  #- percent_transition_G_1_vers_4
  - percent_transition_G_2_vers_1
  - percent_transition_G_2_vers_2
  - percent_transition_G_2_vers_3
  #- percent_transition_G_2_vers_4
  - percent_transition_G_3_vers_1
  - percent_transition_G_3_vers_2
  - percent_transition_G_3_vers_3
  #- percent_transition_G_3_vers_4
  - percent_transition_G_4_vers_1
  - percent_transition_G_4_vers_2
  - percent_transition_G_4_vers_3
  #- percent_transition_G_4_vers_4
)

# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data.R"))
source(file.path("templates","test_train_skeleton_all_clusters.R"))
source(file.path("templates","glm_skeleton_error_estimate_G.R"))
source(file.path("templates","glm_skeleton_final_training_G.R"))
