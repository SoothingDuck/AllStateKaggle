
# Variables
y.letter <- "F"
y.variable <- "real_F"
percent.train <- .8
seed.value <- 42

start.check <- .5
end.check <- .9
step.check <- .2

csv.output.filename <- file.path("DATA","OUTPUT","result_model_glm_all_clusters_F.csv")
RData.output.filename <- file.path("DATA","OUTPUT","first_model_glm_all_clusters_F.RData")

# Formules
formula_0 <- formula(
  I(real_F == 0) ~ .
  - percent_transition_F_0_vers_3
  - percent_transition_F_1_vers_3
  - percent_transition_F_2_vers_3
  - percent_transition_F_3_vers_3
  
  - percent_transition_G_1_vers_1
  - percent_transition_G_1_vers_2
  - percent_transition_G_1_vers_3
  - percent_transition_G_1_vers_4
  - percent_transition_G_2_vers_1
  - percent_transition_G_2_vers_2
  - percent_transition_G_2_vers_3
  - percent_transition_G_2_vers_4
  - percent_transition_G_3_vers_1
  - percent_transition_G_3_vers_2
  - percent_transition_G_3_vers_3
  - percent_transition_G_3_vers_4
  - percent_transition_G_4_vers_1
  - percent_transition_G_4_vers_2
  - percent_transition_G_4_vers_3
  - percent_transition_G_4_vers_4
  
)

formula_1 <- formula(
  I(real_F == 1) ~ .
  - percent_transition_F_0_vers_3
  - percent_transition_F_1_vers_3
  - percent_transition_F_2_vers_3
  - percent_transition_F_3_vers_3
  
  - percent_transition_G_1_vers_1
  - percent_transition_G_1_vers_2
  - percent_transition_G_1_vers_3
  - percent_transition_G_1_vers_4
  - percent_transition_G_2_vers_1
  - percent_transition_G_2_vers_2
  - percent_transition_G_2_vers_3
  - percent_transition_G_2_vers_4
  - percent_transition_G_3_vers_1
  - percent_transition_G_3_vers_2
  - percent_transition_G_3_vers_3
  - percent_transition_G_3_vers_4
  - percent_transition_G_4_vers_1
  - percent_transition_G_4_vers_2
  - percent_transition_G_4_vers_3
  - percent_transition_G_4_vers_4
)

formula_2 <- formula(
  I(real_F == 2) ~ .
  - percent_transition_F_0_vers_3
  - percent_transition_F_1_vers_3
  - percent_transition_F_2_vers_3
  - percent_transition_F_3_vers_3
  
  - percent_transition_G_1_vers_1
  - percent_transition_G_1_vers_2
  - percent_transition_G_1_vers_3
  - percent_transition_G_1_vers_4
  - percent_transition_G_2_vers_1
  - percent_transition_G_2_vers_2
  - percent_transition_G_2_vers_3
  - percent_transition_G_2_vers_4
  - percent_transition_G_3_vers_1
  - percent_transition_G_3_vers_2
  - percent_transition_G_3_vers_3
  - percent_transition_G_3_vers_4
  - percent_transition_G_4_vers_1
  - percent_transition_G_4_vers_2
  - percent_transition_G_4_vers_3
  - percent_transition_G_4_vers_4
)

formula_3 <- formula(
  I(real_F == 3) ~ .
  - percent_transition_F_0_vers_3
  - percent_transition_F_1_vers_3
  - percent_transition_F_2_vers_3
  - percent_transition_F_3_vers_3
  
  - percent_transition_G_1_vers_1
  - percent_transition_G_1_vers_2
  - percent_transition_G_1_vers_3
  - percent_transition_G_1_vers_4
  - percent_transition_G_2_vers_1
  - percent_transition_G_2_vers_2
  - percent_transition_G_2_vers_3
  - percent_transition_G_2_vers_4
  - percent_transition_G_3_vers_1
  - percent_transition_G_3_vers_2
  - percent_transition_G_3_vers_3
  - percent_transition_G_3_vers_4
  - percent_transition_G_4_vers_1
  - percent_transition_G_4_vers_2
  - percent_transition_G_4_vers_3
  - percent_transition_G_4_vers_4
)

# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data.R"))
source(file.path("templates","test_train_skeleton_all_clusters.R"))
source(file.path("templates","glm_skeleton_error_estimate_F.R"))
source(file.path("templates","glm_skeleton_final_training_F.R"))
