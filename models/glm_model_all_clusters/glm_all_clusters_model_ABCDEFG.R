
# Variables
percent.train <- .8

start.check <- .5
end.check <- .9
step.check <- .2

csv.output.filename <- file.path("DATA","OUTPUT","result_model_glm_all_clusters_ABCDEFG.csv")

# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data_3.R"))
source(file.path("templates","glm_skeleton_error_estimate_ABCDEFG.R"))
