# # model A
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_with_location_with_risk_factor_A.R"))
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_with_location_without_risk_factor_A.R"))
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_without_location_with_risk_factor_A.R"))
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_without_location_without_risk_factor_A.R"))

# # model B
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_with_location_with_risk_factor_B.R"))
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_with_location_without_risk_factor_B.R"))
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_without_location_with_risk_factor_B.R"))
# source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_without_location_without_risk_factor_B.R"))

# model C
source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_with_location_with_risk_factor_C.R"))
source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_with_location_without_risk_factor_C.R"))
source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_without_location_with_risk_factor_C.R"))
source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_without_location_without_risk_factor_C.R"))

stop()

source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_D.R"))
rm(list=ls())
gc(TRUE)

source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_E.R"))
rm(list=ls())
gc(TRUE)

source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_F.R"))
rm(list=ls())
gc(TRUE)

source(file.path("models", "glm_model_all_clusters", "glm_all_clusters_model_G.R"))
rm(list=ls())
gc(TRUE)
