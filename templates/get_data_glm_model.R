library(stringr)

source(file.path("templates", "get_data_glm_model_test.R"))
source(file.path("templates", "get_data_glm_model_train.R"))

normalize.data <- function(data) {
  rownames(data) <- as.character(data$customer_ID)
  data <- data[,colnames(data) != "customer_ID"]
  
  # state factor
  data$state <- factor(data$state)
  
  # day
  data$day <- factor(data$day)
    
  # group_size
  data$group_size <- factor(data$group_size, ordered=TRUE)
  
  # homeowner
  data$homeowner <- factor(ifelse(data$homeowner == 1, "Yes", "No"))
  
  # car_age
  data$car_age <- data$car_age
  data$car_age_cut <- cut(data$car_age, breaks=c(seq(-0.1,30,5), Inf))
  
  # car_value
  data$car_value <- factor(ifelse(data$car_value == "", "NotAvailable", data$car_value))
  
  # risk_factor
  data$risk_factor <- factor(ifelse(is.na(data$risk_factor), "NotAvailable", data$risk_factor))
  
  # age_youngest
  data$age_youngest <- data$age_youngest
  data$age_youngest_cut <- cut(data$age_youngest, breaks=c(0, seq(20,70,10), Inf))
    
  # age_oldest
  data$age_oldest <- data$age_oldest
  data$age_oldest_cut <- cut(data$age_oldest, breaks=c(0, seq(20,70,10), Inf))
  
  # married_couple
  data$married_couple <- factor(ifelse(data$married_couple == 1, "Yes", "No"))
  
  # C_previous
  data$C_previous <- factor(ifelse(is.na(data$C_previous), "NotAvailable", data$C_previous))
  
  # duration_previous
  data$duration_previous <- data$duration_previous
  data$duration_previous_cut <- cut(data$duration_previous, breaks=c(seq(-0.1,15,2.5), Inf))
  
  # last_cost
  data$last_cost <- data$last_cost
  data$last_cost_cut <- cut(data$last_cost, breaks=c(0,seq(550, 750, 20), Inf))
  
  # A
  data$last_A <- factor(data$last_A)
  data$shopping_pt_2_A <- factor(data$shopping_pt_2_A)
  data$shopping_pt_3_A <- factor(data$shopping_pt_3_A)
  data$shopping_pt_min_cost_A <- factor(data$shopping_pt_min_cost_A)
  
  # B
  data$last_B <- factor(data$last_B)
  data$shopping_pt_2_B <- factor(data$shopping_pt_2_B)
  data$shopping_pt_3_B <- factor(data$shopping_pt_3_B)
  data$shopping_pt_min_cost_B <- factor(data$shopping_pt_min_cost_B)
  
  # C
  data$last_C <- factor(data$last_C)
  data$shopping_pt_2_C <- factor(data$shopping_pt_2_C)
  data$shopping_pt_3_C <- factor(data$shopping_pt_3_C)
  data$shopping_pt_min_cost_C <- factor(data$shopping_pt_min_cost_C)
  
  # D
  data$last_D <- factor(data$last_D)
  data$shopping_pt_2_D <- factor(data$shopping_pt_2_D)
  data$shopping_pt_3_D <- factor(data$shopping_pt_3_D)
  data$shopping_pt_min_cost_D <- factor(data$shopping_pt_min_cost_D)
  
  # E
  data$last_E <- factor(data$last_E)
  data$shopping_pt_2_E <- factor(data$shopping_pt_2_E)
  data$shopping_pt_3_E <- factor(data$shopping_pt_3_E)
  data$shopping_pt_min_cost_E <- factor(data$shopping_pt_min_cost_E)
  
  # F
  data$last_F <- factor(data$last_F)
  data$shopping_pt_2_F <- factor(data$shopping_pt_2_F)
  data$shopping_pt_3_F <- factor(data$shopping_pt_3_F)
  data$shopping_pt_min_cost_F <- factor(data$shopping_pt_min_cost_F)
  
  # G
  data$last_G <- factor(data$last_G)
  data$shopping_pt_2_G <- factor(data$shopping_pt_2_G)
  data$shopping_pt_3_G <- factor(data$shopping_pt_3_G)
  data$shopping_pt_min_cost_G <- factor(data$shopping_pt_min_cost_G)
  
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
train.data <- get.data.glm.model.train()
train.data <- normalize.train.data(train.data)

test.data <- get.data.glm.model.test()
test.data <- normalize.test.data(test.data)

# functions
select.final.variable <- function(data, letter) {
  col <- ! (grepl("real",colnames(data)) & ! grepl(paste("real",letter, sep="_"), colnames(data)))
  return(data[,col])
}

