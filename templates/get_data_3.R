library(stringr)

source(file.path("templates", "get_data_test.R"))
source(file.path("templates", "get_data_train_3.R"))

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
#   data$first_hour <- as.numeric(str_sub(data$first_time, 0, 2))
#   data <- data[,! colnames(data) %in% c("first_time")]
  
  # group_size
  # data$last_group_size <- factor(data$last_group_size, ordered=TRUE)
  
  # homeowner
  data$last_homeowner <- factor(ifelse(data$last_homeowner == 1, "Yes", "No"))
#   data$first_homeowner <- factor(ifelse(data$first_homeowner == 1, "Yes", "No"))
  
  # car_age
  # data$last_car_age <- factor(data$last_car_age)
  
  # car_value
  data$last_car_value <- factor(data$last_car_value)
#   data$first_car_value <- factor(data$first_car_value)
  
  # big_location
  # data$big_location <- factor(data$big_location)
  
  # risk_factor
  data$last_risk_factor <- factor(ifelse(is.na(data$last_risk_factor), "Not Available", data$last_risk_factor))
#   data$first_risk_factor <- factor(ifelse(is.na(data$first_risk_factor), "Not Available", data$first_risk_factor))
  
  # married_couple
  data$last_married_couple <- factor(ifelse(data$last_married_couple == 1, "Yes", "No"))
#   data$first_married_couple <- factor(ifelse(data$first_married_couple == 1, "Yes", "No"))
  
  # C_previous
  # data$last_C_previous <- factor(ifelse(is.na(data$last_C_previous), "Not Available", data$last_C_previous))
  
  # duration_previous
  # data$last_duration_previous <- factor(ifelse(is.na(data$last_duration_previous), "Not Available", data$last_duration_previous))
  
  # A
#   data$first_A <- factor(data$first_A)
  data$last_A <- factor(data$last_A)
#   data$before_last_A <- factor(data$before_last_A)
  #data$same_A <- (data$first_A == data$last_A)
  
  # B
#   data$first_B <- factor(data$first_B)
  data$last_B <- factor(data$last_B)
#   data$before_last_B <- factor(data$before_last_B)
  #data$same_B <- (data$first_B == data$last_B)
  
  # C
#   data$first_C <- factor(data$first_C)
  data$last_C <- factor(data$last_C)
#   data$before_last_C <- factor(data$before_last_C)
  #data$same_C <- (data$first_C == data$last_C)
  
  # D
#   data$first_D <- factor(data$first_D)
  data$last_D <- factor(data$last_D)
#   data$before_last_D <- factor(data$before_last_D)
  #data$same_D <- (data$first_D == data$last_D)
  
  # E
#   data$first_E <- factor(data$first_E)
  data$last_E <- factor(data$last_E)
#   data$before_last_E <- factor(data$before_last_E)
  #data$same_E <- (data$first_E == data$last_E)
  
  # F
#   data$first_F <- factor(data$first_F)
  data$last_F <- factor(data$last_F)
#   data$before_last_F <- factor(data$before_last_F)
  #data$same_F <- (data$first_F == data$last_F)
  
  # G
#   data$first_G <- factor(data$first_G)
  data$last_G <- factor(data$last_G)
#   data$before_last_G <- factor(data$before_last_G)
  #data$same_G <- (data$first_G == data$last_G)
  
  # Suppression NA Location
  # data <- data[! is.na(data$location_G_proba_4),]
  
  # last_cluster_number
  # data$last_cluster_number <- factor(data$last_cluster_number)
  # data$cluster_number <- factor(data$first_cluster_number)
  # data <- data[,! colnames(data) %in% c("last_cluster_number", "first_cluster_number")]
  
  
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

