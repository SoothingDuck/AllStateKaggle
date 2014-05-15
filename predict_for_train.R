source("reboot_data.R")

load(file.path("last_model", "model_glm_A_restricted.RData"))

error.pred <- function(real, predict) {
  nb.ko <- sum(real != predict)
  nb.all <- length(real)
  
  return(nb.ko/nb.all)
}

# A
load(file.path("last_model", "model_glm_A_restricted.RData"))

data.train.normalized$predicted_A_0 <- predict(model.A.0.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_A_1 <- predict(model.A.1.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_A_2 <- predict(model.A.2.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_A <- max.col(data.train.normalized[,c("predicted_A_0","predicted_A_1","predicted_A_2")])-1

# B
load(file.path("last_model", "model_glm_B_restricted.RData"))

data.train.normalized$predicted_B_0 <- predict(model.B.0.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_B_1 <- predict(model.B.1.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_B <- max.col(data.train.normalized[,c("predicted_B_0","predicted_B_1")])-1

# C
load(file.path("last_model", "model_glm_C_restricted.RData"))

data.train.normalized$predicted_C_1 <- predict(model.C.1.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_C_2 <- predict(model.C.2.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_C_3 <- predict(model.C.3.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_C_4 <- predict(model.C.4.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_C <- max.col(data.train.normalized[,c("predicted_C_1","predicted_C_2","predicted_C_3","predicted_C_4")])

# D
load(file.path("last_model", "model_glm_D_restricted.RData"))

data.train.normalized$predicted_D_1 <- predict(model.D.1.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_D_2 <- predict(model.D.2.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_D_3 <- predict(model.D.3.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_D <- max.col(data.train.normalized[,c("predicted_D_1","predicted_D_2","predicted_D_3")])

# E
load(file.path("last_model", "model_glm_E_restricted.RData"))

data.train.normalized$predicted_E_0 <- predict(model.E.0.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_E_1 <- predict(model.E.1.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_E <- max.col(data.train.normalized[,c("predicted_E_0","predicted_E_1")]) - 1

# F
load(file.path("last_model", "model_glm_F_restricted.RData"))

data.train.normalized$predicted_F_0 <- predict(model.F.0.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_F_1 <- predict(model.F.1.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_F_2 <- predict(model.F.2.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_F_3 <- predict(model.F.3.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_F <- max.col(data.train.normalized[,c("predicted_F_0","predicted_F_1","predicted_F_2","predicted_F_3")]) - 1

# G
load(file.path("last_model", "model_glm_G_restricted.RData"))

data.train.normalized$predicted_G_1 <- predict(model.G.1.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_G_2 <- predict(model.G.2.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_G_3 <- predict(model.G.3.restricted, newdata=data.train.normalized, type="response")
data.train.normalized$predicted_G_4 <- predict(model.G.4.restricted, newdata=data.train.normalized, type="response")

data.train.normalized$predicted_G <- max.col(data.train.normalized[,c("predicted_G_1","predicted_G_2","predicted_G_3","predicted_G_4")])

