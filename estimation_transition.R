# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data_3.R"))

# model trans
p <- .9

trainIndex <- createDataPartition(data$state, p = p,
                                  list = FALSE,
                                  times = 1)

train.data=data[trainIndex,]
test.data=data[-trainIndex,]

# estimate G
load(file.path("DATA","TRANSITION", "transition_1_vers_1_G.RData"))
model_G_1_1 <- model
load(file.path("DATA","TRANSITION", "transition_1_vers_2_G.RData"))
model_G_1_2 <- model
load(file.path("DATA","TRANSITION", "transition_1_vers_3_G.RData"))
model_G_1_3 <- model
load(file.path("DATA","TRANSITION", "transition_1_vers_4_G.RData"))
model_G_1_4 <- model

load(file.path("DATA","TRANSITION", "transition_2_vers_1_G.RData"))
model_G_2_1 <- model
load(file.path("DATA","TRANSITION", "transition_2_vers_2_G.RData"))
model_G_2_2 <- model
load(file.path("DATA","TRANSITION", "transition_2_vers_3_G.RData"))
model_G_2_3 <- model
load(file.path("DATA","TRANSITION", "transition_2_vers_4_G.RData"))
model_G_2_4 <- model

load(file.path("DATA","TRANSITION", "transition_3_vers_1_G.RData"))
model_G_3_1 <- model
load(file.path("DATA","TRANSITION", "transition_3_vers_2_G.RData"))
model_G_3_2 <- model
load(file.path("DATA","TRANSITION", "transition_3_vers_3_G.RData"))
model_G_3_3 <- model
load(file.path("DATA","TRANSITION", "transition_3_vers_4_G.RData"))
model_G_3_4 <- model

load(file.path("DATA","TRANSITION", "transition_4_vers_1_G.RData"))
model_G_4_1 <- model
load(file.path("DATA","TRANSITION", "transition_4_vers_2_G.RData"))
model_G_4_2 <- model
load(file.path("DATA","TRANSITION", "transition_4_vers_3_G.RData"))
model_G_4_3 <- model
load(file.path("DATA","TRANSITION", "transition_4_vers_4_G.RData"))
model_G_4_4 <- model

# Eval transition vers
evaluation.transition.G <- function(data) {
  data$transition_G_vers_1 <- NA
  data$transition_G_vers_2 <- NA
  data$transition_G_vers_3 <- NA
  data$transition_G_vers_4 <- NA
  
  cat("Evaluation transitions G vers 1...\n")
  data$transition_G_vers_1[data$last_G == 1] <- predict(model_G_1_1, newdata=data[data$last_G == 1,])
  data$transition_G_vers_1[data$last_G == 2] <- predict(model_G_2_1, newdata=data[data$last_G == 2,])
  data$transition_G_vers_1[data$last_G == 3] <- predict(model_G_3_1, newdata=data[data$last_G == 3,])
  data$transition_G_vers_1[data$last_G == 4] <- predict(model_G_4_1, newdata=data[data$last_G == 4,])
  
  cat("Evaluation transitions G vers 2...\n")
  data$transition_G_vers_2[data$last_G == 1] <- predict(model_G_1_2, newdata=data[data$last_G == 1,])
  data$transition_G_vers_2[data$last_G == 2] <- predict(model_G_2_2, newdata=data[data$last_G == 2,])
  data$transition_G_vers_2[data$last_G == 3] <- predict(model_G_3_2, newdata=data[data$last_G == 3,])
  data$transition_G_vers_2[data$last_G == 4] <- predict(model_G_4_2, newdata=data[data$last_G == 4,])
  
  cat("Evaluation transitions G vers 3...\n")
  data$transition_G_vers_3[data$last_G == 1] <- predict(model_G_1_3, newdata=data[data$last_G == 1,])
  data$transition_G_vers_3[data$last_G == 2] <- predict(model_G_2_3, newdata=data[data$last_G == 2,])
  data$transition_G_vers_3[data$last_G == 3] <- predict(model_G_3_3, newdata=data[data$last_G == 3,])
  data$transition_G_vers_3[data$last_G == 4] <- predict(model_G_4_3, newdata=data[data$last_G == 4,])
  
  cat("Evaluation transitions G vers 4...\n")  
  data$transition_G_vers_4[data$last_G == 1] <- predict(model_G_1_4, newdata=data[data$last_G == 1,])
  data$transition_G_vers_4[data$last_G == 2] <- predict(model_G_2_4, newdata=data[data$last_G == 2,])
  data$transition_G_vers_4[data$last_G == 3] <- predict(model_G_3_4, newdata=data[data$last_G == 3,])
  data$transition_G_vers_4[data$last_G == 4] <- predict(model_G_4_4, newdata=data[data$last_G == 4,])
  
  cat("Prediction G...\n")
  data$prediction_G <- factor(max.col(data[,c("transition_G_vers_1","transition_G_vers_2", "transition_G_vers_3", "transition_G_vers_4")]))
  
  return(data)
}

train.data <- evaluation.transition.G(train.data)

# transition_1_vers_1_G.RData
# transition_1_vers_2_G.RData
# transition_1_vers_3_G.RData
# transition_1_vers_4_G.RData
# transition_2_vers_1_G.RData
# transition_2_vers_2_G.RData
# transition_2_vers_3_G.RData
# transition_2_vers_4_G.RData
# transition_3_vers_1_G.RData
# transition_3_vers_2_G.RData
# transition_3_vers_3_G.RData
# transition_3_vers_4_G.RData
# transition_4_vers_1_G.RData
# transition_4_vers_2_G.RData
# transition_4_vers_3_G.RData
# transition_4_vers_4_G.RData
