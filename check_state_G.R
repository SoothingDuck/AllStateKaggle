
# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data.R"))


# Models
load(file=file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_G.RData"))
                    
# Selection variable à estimer
set.seed(42)
tmp <- get.base.train.test(data, "real_G", .5)

dataTrainBase <- tmp$train
dataTest <- tmp$test


dataTrainBase$predicted_G_1 <- predict(model_1_final_G, newdata=dataTrainBase)
dataTrainBase$predicted_G_2 <- predict(model_2_final_G, newdata=dataTrainBase)
dataTrainBase$predicted_G_3 <- predict(model_3_final_G, newdata=dataTrainBase)
dataTrainBase$predicted_G_4 <- predict(model_4_final_G, newdata=dataTrainBase)
dataTrainBase$customer_ID <- rownames(dataTrainBase)

# Check
library(ggplot2)
library(plyr)
library(reshape2)

m <- melt(dataTrainBase, id.vars=c("customer_ID","state","real_G"), measure.vars=c("predicted_G_1","predicted_G_2","predicted_G_3","predicted_G_4"))

ggplot(subset(m, real_G == "1")) + geom_histogram(aes(x=value)) + facet_grid(state + real_G  ~ variable )
