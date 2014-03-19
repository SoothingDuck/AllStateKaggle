library(stringr)

source("get_data_test.R")
source("get_data_train.R")

normalize.data <- function(data) {
  rownames(data) <- as.character(data$customer_ID)
  data <- data[,colnames(data) != "customer_ID"]
  
  # state factor
  data$state <- factor(data$state)
  
  # day
  data$last_day <- factor(data$last_day)
  
  # time
  data$last_hour <- as.numeric(str_sub(data$last_time, 0, 2))
  data <- data[,! colnames(data) %in% c("last_time")]
  
  # group_size
  data$last_group_size <- factor(data$last_group_size)
  
  # homeowner
  data$last_homeowner <- factor(ifelse(data$last_homeowner == 1, "Yes", "No"))
  
  # car_age
  ## factor ????
  
  # car_value
  data$last_car_value <- factor(data$last_car_value)
  
  # risk_factor
  data$last_risk_factor <- factor(ifelse(is.na(data$last_risk_factor), "Not Available", data$last_risk_factor))
  
  # married_couple
  data$last_married_couple <- factor(ifelse(data$last_married_couple == 1, "Yes", "No"))
  
  # C_previous
  data$last_C_previous <- factor(ifelse(is.na(data$last_C_previous), "Not Available", data$last_C_previous))
  
  # duration_previous
  data$last_duration_previous <- factor(ifelse(is.na(data$last_duration_previous), "Not Available", data$last_duration_previous))
  
  # A
  data$last_A <- factor(data$last_A)
  data$location_A_proba_1 <- factor(data$location_A_proba_1)
  data$location_A_proba_2 <- factor(data$location_A_proba_2)
  data$location_A_proba_3 <- factor(data$location_A_proba_3)  
  
  # B
  data$last_B <- factor(data$last_B)
  data$location_B_proba_1 <- factor(data$location_B_proba_1)
  data$location_B_proba_2 <- factor(data$location_B_proba_2)
  
  # C
  data$last_C <- factor(data$last_C)
  data$location_C_proba_1 <- factor(data$location_C_proba_1)
  data$location_C_proba_2 <- factor(data$location_C_proba_2)
  data$location_C_proba_3 <- factor(data$location_C_proba_3)
  data$location_C_proba_4 <- factor(data$location_C_proba_4)
  
  # D
  data$last_D <- factor(data$last_D)
  data$location_D_proba_1 <- factor(data$location_D_proba_1)
  data$location_D_proba_2 <- factor(data$location_D_proba_2)
  data$location_D_proba_3 <- factor(data$location_D_proba_3)
  
  # E
  data$last_E <- factor(data$last_E)
  data$location_E_proba_1 <- factor(data$location_E_proba_1)
  data$location_E_proba_2 <- factor(data$location_E_proba_2)
  
  # F
  data$last_F <- factor(data$last_F)
  data$location_F_proba_1 <- factor(data$location_F_proba_1)
  data$location_F_proba_2 <- factor(data$location_F_proba_2)
  data$location_F_proba_3 <- factor(data$location_F_proba_3)
  data$location_F_proba_4 <- factor(data$location_F_proba_4)
  
  # G
  data$last_G <- factor(data$last_G)
  data$location_G_proba_1 <- factor(data$location_G_proba_1)
  data$location_G_proba_2 <- factor(data$location_G_proba_2)
  data$location_G_proba_3 <- factor(data$location_G_proba_3)
  data$location_G_proba_4 <- factor(data$location_G_proba_4)

  # Suppression NA Location
  data <- data[! is.na(data$location_G_proba_4),]
  
  return(data)
}

normalize.train.data <- function(data) {
  
  data <- normalize.data(data)

  data$real_A <- factor(data$real_A)
  data$real_B <- factor(data$real_B)
  data$real_C <- factor(data$real_C)
  data$real_D <- factor(data$real_D)
  data$real_E <- factor(data$real_E)
  data$real_F <- factor(data$real_F)
  data$real_G <- factor(data$real_G)

  # data$next_car_value <- factor(data$next_car_value)
  # data$real_ABCDEF <- factor(data$real_ABCDEF)
  
  return(data)
}

normalize.test.data <- function(data) {
  
  data <- normalize.data(data)
  
  return(data)
  
}

# Préparation des données
data <- get.data.train()
data <- normalize.train.data(data)

# functions
select.final.variable <- function(data, letter) {
  col <- ! (grepl("real",colnames(data)) & ! grepl(paste("real",letter, sep="_"), colnames(data)))
  return(data[,col])
}

