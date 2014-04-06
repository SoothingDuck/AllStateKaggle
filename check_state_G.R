
# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data.R"))

stop("to finish")

# Models
load(file=file.path("DATA", "OUTPUT", ""))
                    
# Selection variable à estimer
set.seed(42)
tmp <- get.base.train.test(data, "real_G", .5)

dataTrainBase <- tmp$train
dataTest <- tmp$test



source(file.path("templates","glm_skeleton_final_training_G.R"))