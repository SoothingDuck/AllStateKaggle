library(stringr)

source("get_data_test.R")
source("get_data_train.R")

normalize.data <- function(data) {
  rownames(data) <- as.character(data$customer_ID)
  data <- data[,colnames(data) != "customer_ID"]
  
  # state factor
  data$state <- factor(data$state)
  
  # day
  # data$first_view_day <- factor(data$first_view_day)
  data$last_view_day <- factor(data$last_view_day)
  # data$min_cost_view_day <- factor(data$min_cost_view_day)
  
  # time
  data$first_view_hour <- as.numeric(str_sub(data$first_view_time, 0, 2))
  data$minutes_elapsed <- (as.numeric(str_sub(data$last_view_time, 0, 2))*60 + as.numeric(str_sub(data$last_view_time, 4, 6))) - (as.numeric(str_sub(data$first_view_time, 0, 2))*60 + as.numeric(str_sub(data$first_view_time, 4, 6)))
  data <- data[,! colnames(data) %in% c("first_view_time","last_view_time","min_cost_view_time")]
  
  # homeowner
  data$first_view_homeowner <- factor(ifelse(data$first_view_homeowner == 1, "Yes", "No"))
  data$last_view_homeowner <- factor(ifelse(data$last_view_homeowner == 1, "Yes", "No"))
  data$min_cost_view_homeowner <- factor(ifelse(data$min_cost_view_homeowner == 1, "Yes", "No"))
  
  # car_value
  data$first_view_car_value <- factor(data$first_view_car_value)
  data$last_view_car_value <- factor(data$last_view_car_value)
  data$min_cost_view_car_value <- factor(data$min_cost_view_car_value)
  
  # risk_factor
  data$first_view_risk_factor <- factor(data$first_view_risk_factor)
  data$last_view_risk_factor <- factor(data$last_view_risk_factor)
  data$min_cost_view_risk_factor <- factor(data$min_cost_view_risk_factor)
  
  # married_couple
  data$first_view_married_couple <- factor(ifelse(data$first_view_married_couple == 1, "Yes", "No"))
  data$last_view_married_couple <- factor(ifelse(data$last_view_married_couple == 1, "Yes", "No"))
  data$min_cost_view_married_couple <- factor(ifelse(data$min_cost_view_married_couple == 1, "Yes", "No"))
  
  # C_previous
  data$first_view_C_previous <- factor(data$first_view_C_previous)
  data$last_view_C_previous <- factor(data$last_view_C_previous)
  data$min_cost_view_C_previous <- factor(data$min_cost_view_C_previous)
  
  # duration_previous
  # data$first_view_duration_previous <- factor(data$first_view_duration_previous)
  # data$last_view_duration_previous <- factor(data$last_view_duration_previous)
  # data$min_cost_view_duration_previous <- factor(data$min_cost_view_duration_previous)
  
  # A
  data$first_view_A <- factor(data$first_view_A)
  data$last_view_A <- factor(data$last_view_A)
  data$min_cost_view_A <- factor(data$min_cost_view_A)
  
  # B
  data$first_view_B <- factor(data$first_view_B)
  data$last_view_B <- factor(data$last_view_B)
  data$min_cost_view_B <- factor(data$min_cost_view_B)
  
  # C
  data$first_view_C <- factor(data$first_view_C)
  data$last_view_C <- factor(data$last_view_C)
  data$min_cost_view_C <- factor(data$min_cost_view_C)
  
  # D
  data$first_view_D <- factor(data$first_view_D)
  data$last_view_D <- factor(data$last_view_D)
  data$min_cost_view_D <- factor(data$min_cost_view_D)
  
  # E
  data$first_view_E <- factor(data$first_view_E)
  data$last_view_E <- factor(data$last_view_E)
  data$min_cost_view_E <- factor(data$min_cost_view_E)
  
  # F
  data$first_view_F <- factor(data$first_view_F)
  data$last_view_F <- factor(data$last_view_F)
  data$min_cost_view_F <- factor(data$min_cost_view_F)
  
  # G
  data$first_view_G <- factor(data$first_view_G)
  data$last_view_G <- factor(data$last_view_G)
  data$min_cost_view_G <- factor(data$min_cost_view_G)
  
  # ABCDEF
  # data$first_view_ABCDEF <- factor(data$first_view_ABCDEF)
  # data$last_view_ABCDEF <- factor(data$last_view_ABCDEF)
  # data$min_cost_view_ABCDEF <- factor(data$min_cost_view_ABCDEF)
  
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

