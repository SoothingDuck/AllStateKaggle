
# Estimation modeles

list_prob <- c(.9)

result <- data.frame()

load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_A.RData"))
load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_B.RData"))
load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_C.RData"))
load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_D.RData"))
load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_E.RData"))
load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_F.RData"))
load(file.path("DATA", "OUTPUT", "first_model_glm_all_clusters_G.RData"))

for(prob in list_prob) {
  
  cat("Taille train : ", prob, "\n")
  
  trainIndex <- createDataPartition(data$state, p = prob,
                                    list = FALSE,
                                    times = 1)
  
  dataTrain=data[trainIndex,]
  dataTest=data[-trainIndex,]
  
  # Evaluation modeles A
  cat("prediction A test\n")
  dataTest$predict_glm_A_0 <- predict(model_0_final_A, newdata=dataTest)
  dataTest$predict_glm_A_1 <- predict(model_1_final_A, newdata=dataTest)
  dataTest$predict_glm_A_2 <- predict(model_2_final_A, newdata=dataTest)
  
  dataTest$predicted_glm_A <- factor(max.col(dataTest[,c("predict_glm_A_0","predict_glm_A_1", "predict_glm_A_2")])-1)
  
  cat("prediction A train\n")
  dataTrain$predict_glm_A_0 <- predict(model_0_final_A, newdata=dataTrain)
  dataTrain$predict_glm_A_1 <- predict(model_1_final_A, newdata=dataTrain)
  dataTrain$predict_glm_A_2 <- predict(model_2_final_A, newdata=dataTrain)
  
  dataTrain$predicted_glm_A <- factor(max.col(dataTrain[,c("predict_glm_A_0","predict_glm_A_1", "predict_glm_A_2")])-1)

  # Evaluation modeles B
  cat("prediction B test\n")
  dataTest$predict_glm_B_0 <- predict(model_0_final_B, newdata=dataTest)
  dataTest$predict_glm_B_1 <- predict(model_1_final_B, newdata=dataTest)
  
  dataTest$predicted_glm_B <- factor(max.col(dataTest[,c("predict_glm_B_0","predict_glm_B_1")])-1)
  
  cat("prediction B train\n")
  dataTrain$predict_glm_B_0 <- predict(model_0_final_B, newdata=dataTrain)
  dataTrain$predict_glm_B_1 <- predict(model_1_final_B, newdata=dataTrain)
  
  dataTrain$predicted_glm_B <- factor(max.col(dataTrain[,c("predict_glm_B_0","predict_glm_B_1")])-1)
  
  # Evaluation modeles C
  cat("prediction C test\n")
  dataTest$predict_glm_C_1 <- predict(model_1_final_C, newdata=dataTest)
  dataTest$predict_glm_C_2 <- predict(model_2_final_C, newdata=dataTest)
  dataTest$predict_glm_C_3 <- predict(model_3_final_C, newdata=dataTest)
  dataTest$predict_glm_C_4 <- predict(model_4_final_C, newdata=dataTest)
  
  dataTest$predicted_glm_C <- factor(max.col(dataTest[,c("predict_glm_C_1","predict_glm_C_2","predict_glm_C_3","predict_glm_C_4")]))
  
  cat("prediction C train\n")
  dataTrain$predict_glm_C_1 <- predict(model_1_final_C, newdata=dataTrain)
  dataTrain$predict_glm_C_2 <- predict(model_2_final_C, newdata=dataTrain)
  dataTrain$predict_glm_C_3 <- predict(model_3_final_C, newdata=dataTrain)
  dataTrain$predict_glm_C_4 <- predict(model_4_final_C, newdata=dataTrain)
  
  dataTrain$predicted_glm_C <- factor(max.col(dataTrain[,c("predict_glm_C_1","predict_glm_C_2","predict_glm_C_3","predict_glm_C_4")]))
    
  # Evaluation modeles D
  cat("prediction D test\n")
  dataTest$predict_glm_D_1 <- predict(model_1_final_D, newdata=dataTest)
  dataTest$predict_glm_D_2 <- predict(model_2_final_D, newdata=dataTest)
  dataTest$predict_glm_D_3 <- predict(model_3_final_D, newdata=dataTest)
  
  dataTest$predicted_glm_D <- factor(max.col(dataTest[,c("predict_glm_D_1","predict_glm_D_2","predict_glm_D_3")]))
  
  cat("prediction D train\n")
  dataTrain$predict_glm_D_1 <- predict(model_1_final_D, newdata=dataTrain)
  dataTrain$predict_glm_D_2 <- predict(model_2_final_D, newdata=dataTrain)
  dataTrain$predict_glm_D_3 <- predict(model_3_final_D, newdata=dataTrain)
  
  dataTrain$predicted_glm_D <- factor(max.col(dataTrain[,c("predict_glm_D_1","predict_glm_D_2","predict_glm_D_3")]))
  
  # Evaluation modeles E
  cat("prediction E test\n")
  dataTest$predict_glm_E_0 <- predict(model_0_final_E, newdata=dataTest)
  dataTest$predict_glm_E_1 <- predict(model_1_final_E, newdata=dataTest)
  
  dataTest$predicted_glm_E <- factor(max.col(dataTest[,c("predict_glm_E_0","predict_glm_E_1")])-1)
  
  cat("prediction E train\n")
  dataTrain$predict_glm_E_0 <- predict(model_0_final_E, newdata=dataTrain)
  dataTrain$predict_glm_E_1 <- predict(model_1_final_E, newdata=dataTrain)
  
  dataTrain$predicted_glm_E <- factor(max.col(dataTrain[,c("predict_glm_E_0","predict_glm_E_1")])-1)
  
  # Evaluation modeles F
  cat("prediction F test\n")
  dataTest$predict_glm_F_0 <- predict(model_0_final_F, newdata=dataTest)
  dataTest$predict_glm_F_1 <- predict(model_1_final_F, newdata=dataTest)
  dataTest$predict_glm_F_2 <- predict(model_2_final_F, newdata=dataTest)
  dataTest$predict_glm_F_3 <- predict(model_3_final_F, newdata=dataTest)
  
  dataTest$predicted_glm_F <- factor(max.col(dataTest[,c("predict_glm_F_0","predict_glm_F_1","predict_glm_F_2","predict_glm_F_3")])-1)
  
  cat("prediction F train\n")
  dataTrain$predict_glm_F_0 <- predict(model_0_final_F, newdata=dataTrain)
  dataTrain$predict_glm_F_1 <- predict(model_1_final_F, newdata=dataTrain)
  dataTrain$predict_glm_F_2 <- predict(model_2_final_F, newdata=dataTrain)
  dataTrain$predict_glm_F_3 <- predict(model_3_final_F, newdata=dataTrain)
  
  dataTrain$predicted_glm_F <- factor(max.col(dataTrain[,c("predict_glm_F_0","predict_glm_F_1","predict_glm_F_2","predict_glm_F_3")])-1)
  
  # Evaluation modeles G
  cat("prediction G test\n")
  dataTest$predict_glm_G_1 <- predict(model_1_final_G, newdata=dataTest)
  dataTest$predict_glm_G_2 <- predict(model_2_final_G, newdata=dataTest)
  dataTest$predict_glm_G_3 <- predict(model_3_final_G, newdata=dataTest)
  dataTest$predict_glm_G_4 <- predict(model_4_final_G, newdata=dataTest)
  
  dataTest$predicted_glm_G <- factor(max.col(dataTest[,c("predict_glm_G_1","predict_glm_G_2","predict_glm_G_3","predict_glm_G_4")]))
  
  cat("prediction G train\n")
  dataTrain$predict_glm_G_1 <- predict(model_1_final_G, newdata=dataTrain)
  dataTrain$predict_glm_G_2 <- predict(model_2_final_G, newdata=dataTrain)
  dataTrain$predict_glm_G_3 <- predict(model_3_final_G, newdata=dataTrain)
  dataTrain$predict_glm_G_4 <- predict(model_4_final_G, newdata=dataTrain)
  
  dataTrain$predicted_glm_G <- factor(max.col(dataTrain[,c("predict_glm_G_1","predict_glm_G_2","predict_glm_G_3","predict_glm_G_4")]))
  
  # ABCDEFG
  dataTest$real_ABCDEFG <- with(dataTest, paste(
    as.character(real_A),
    as.character(real_B),
    as.character(real_C),
    as.character(real_D),
    as.character(real_E),
    as.character(real_F),
    as.character(real_G),
    sep=""
  )
  )

  dataTest$predicted_glm_ABCDEFG <- with(dataTest, paste(
    as.character(predicted_glm_A),
    as.character(predicted_glm_B),
    as.character(predicted_glm_C),
    as.character(predicted_glm_D),
    as.character(predicted_glm_E),
    as.character(predicted_glm_F),
    as.character(predicted_glm_G),
    sep=""
    )
  )
  
  dataTrain$real_ABCDEFG <- with(dataTrain, paste(
    as.character(real_A),
    as.character(real_B),
    as.character(real_C),
    as.character(real_D),
    as.character(real_E),
    as.character(real_F),
    as.character(real_G),
    sep=""
  )
  )
  
  dataTrain$predicted_glm_ABCDEFG <- with(dataTrain, paste(
    as.character(predicted_glm_A),
    as.character(predicted_glm_B),
    as.character(predicted_glm_C),
    as.character(predicted_glm_D),
    as.character(predicted_glm_E),
    as.character(predicted_glm_F),
    as.character(predicted_glm_G),
    sep=""
  )
  )
  
  # Error
  print("Error GLM Test ABCDEFG:")
  print(prediction_error(dataTest$real_ABCDEFG, dataTest$predicted_glm_ABCDEFG))
  
  print("Error GLM Train ABCDEFG:")
  print(prediction_error(dataTrain$real_ABCDEFG, dataTrain$predicted_glm_ABCDEFG))
    
}


