library(stringr)

source("get_raw_data_test.R")
source("get_raw_data_train.R")

normalize.raw.data <- function(data) {
  rownames(data) <- paste(as.character(data$customer_ID), as.character(data$line_number), sep="-")
  data <- data[,colnames(data) != "customer_ID"]
  
  # state factor
  data$state <- factor(data$state)
  
  # day
  data$day <- factor(data$day)
  data$day_final <- factor(data$day_final)
  
  # time
  data$hour <- ((as.numeric(str_sub(data$time, 0, 2))*60) + as.numeric(str_sub(data$time, 4, 6)))/60
  data$hour_final <- ((as.numeric(str_sub(data$time_final, 0, 2))*60) + as.numeric(str_sub(data$time_final, 4, 6)))/60
  
  # group_size
  data$group_size <- factor(data$group_size)
  data$group_size_final <- factor(data$group_size_final)
  
  # homeowner
  data$homeowner <- factor(ifelse(data$homeowner == 1, "Yes", "No"))
  data$homeowner_final <- factor(ifelse(data$homeowner_final == 1, "Yes", "No"))

  # car_value
  data$car_value <- factor(data$car_value)
  data$car_value_final <- factor(data$car_value_final)
  
  # risk_factor
  data$risk_factor <- factor(data$risk_factor)
  data$risk_factor_final <- factor(data$risk_factor_final)
  
  # married_couple
  data$married_couple <- factor(ifelse(data$married_couple == 1, "Yes", "No"))
  data$married_couple_final <- factor(ifelse(data$married_couple_final == 1, "Yes", "No"))
  
  # C_previous
  data$C_previous <- factor(data$C_previous)
  data$C_previous_final <- factor(data$C_previous_final)
  
  # duration_previous
  # data$first_view_duration_previous <- factor(data$first_view_duration_previous)
  # data$last_view_duration_previous <- factor(data$last_view_duration_previous)
  # data$min_cost_view_duration_previous <- factor(data$min_cost_view_duration_previous)
  
  # A
  data$A <- factor(data$A)
  data$A_final <- factor(data$A_final)
  
  # B
  data$B <- factor(data$B)
  data$B_final <- factor(data$B_final)
  
  # C
  data$C <- factor(data$C)
  data$C_final <- factor(data$C_final)
  
  # D
  data$D <- factor(data$D)
  data$D_final <- factor(data$D_final)
  
  # E
  data$E <- factor(data$E)
  data$E_final <- factor(data$E_final)

  # F
  data$F <- factor(data$F)
  data$F_final <- factor(data$F_final)

  # G
  data$G <- factor(data$G)
  data$G_final <- factor(data$G_final)

  # order
  data$line_situation <- factor(ifelse(data$line_number == 1, "FIRST",
                                ifelse(data$line_number == (data$line_number_final-1), "LAST", "MIDDLE")
                                ))
  
  return(data)
}

normalize.raw.train.data <- function(data) {
  
  data <- normalize.raw.data(data)

  data$A_final <- factor(data$A_final)
  data$B_final <- factor(data$B_final)
  data$C_final <- factor(data$C_final)
  data$D_final <- factor(data$D_final)
  data$E_final <- factor(data$E_final)
  data$F_final <- factor(data$F_final)
  data$G_final <- factor(data$G_final)

  return(data)
}

normalize.test.data <- function(data) {
  
  data <- normalize.data(data)
  
  return(data)
  
}

# Préparation des données
data.raw <- get.raw.data.train()
data.raw <- normalize.raw.train.data(data.raw)

# functions
select.final.variable <- function(data, letter) {
  col <- ! (grepl("real",colnames(data)) & ! grepl(paste("real",letter, sep="_"), colnames(data)))
  return(data[,col])
}

