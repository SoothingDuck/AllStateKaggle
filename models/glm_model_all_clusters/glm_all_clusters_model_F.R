
# Variables
y.letter <- "F"
y.variable <- "real_F"
percent.train <- .8
seed.value <- 42

start.check <- .5
end.check <- .9
step.check <- .2

csv.output.filename <- file.path("DATA","OUTPUT","result_model_glm_all_clusters_F.csv")
RData.output.filename <- file.path("DATA","OUTPUT","first_model_glm_all_clusters_F.RData")

# Formules
formula_0 <- formula(
  I(real_F == 0) ~ 
    state
#   + last_day          
#   + last_group_size              
#   + last_homeowner       
#   + last_car_age               
#   + last_car_value               
#   + last_risk_factor            
#   + last_age_oldest             
#   + last_age_youngest            
#   + last_married_couple         
#   + last_C_previous             
#   + last_duration_previous       
#   + last_cost       
  + last_A              
#   + last_B                       
#   + last_C                    
#   + last_D                 
#   + last_E                       
  + last_F                
#   + last_G               
#   + first_group_size             
#   + first_homeowner     
  + first_car_age     
#   + first_car_value              
#   + first_risk_factor         
#   + first_age_oldest     
#   + first_age_youngest           
#   + first_married_couple      
#   + first_C_previous            
#   + first_duration_previous      
#   + first_cost                  
#   + first_A                     
#   + first_B                      
#   + first_C           
#   + first_D       
#   + first_E                      
#   + first_F                  
#   + first_G                   
#   + before_last_A                
#   + before_last_B               
#   + before_last_C            
#   + before_last_D                
#   + before_last_E          
  + before_last_F       
#   + before_last_G                
#   + nb_minutes              
#   + nb_views                   
#   + ratio_hesitation             
#   + percent_transition_F_0_vers_0 
#   + percent_transition_F_0_vers_1 
#   + percent_transition_F_0_vers_2
#   + percent_transition_F_0_vers_3 
  + percent_transition_F_1_vers_0 
#   + percent_transition_F_1_vers_1
#   + percent_transition_F_1_vers_2 
#   + percent_transition_F_1_vers_3 
  + percent_transition_F_2_vers_0
#   + percent_transition_F_2_vers_1 
#   + percent_transition_F_2_vers_2 
#   + percent_transition_F_2_vers_3
  + percent_transition_F_3_vers_0 
#   + percent_transition_F_3_vers_1 
#   + percent_transition_F_3_vers_2
#   + percent_transition_F_3_vers_3 
#   + percent_transition_G_1_vers_1
#   + percent_transition_G_1_vers_2
#   + percent_transition_G_1_vers_3
#   + percent_transition_G_1_vers_4 
#   + percent_transition_G_2_vers_1
#   + percent_transition_G_2_vers_2 
#   + percent_transition_G_2_vers_3
#   + percent_transition_G_2_vers_4
#   + percent_transition_G_3_vers_1 
#   + percent_transition_G_3_vers_2
#   + percent_transition_G_3_vers_3
#   + percent_transition_G_3_vers_4 
#   + percent_transition_G_4_vers_1 
#   + percent_transition_G_4_vers_2
#   + percent_transition_G_4_vers_3 
#   + percent_transition_G_4_vers_4 
#   + last_hour 
#   + first_hour   
)

formula_1 <- formula(
  I(real_F == 1) ~ 
  state
#   + last_day          
#   + last_group_size              
#   + last_homeowner       
#   + last_car_age               
#   + last_car_value               
#   + last_risk_factor            
#   + last_age_oldest             
#   + last_age_youngest            
#   + last_married_couple         
#   + last_C_previous             
#   + last_duration_previous       
  + last_cost       
  + last_A              
#   + last_B                       
#   + last_C                    
#   + last_D                 
#   + last_E                       
  + last_F                
#   + last_G               
#   + first_group_size             
#   + first_homeowner     
#   + first_car_age     
#   + first_car_value              
#   + first_risk_factor         
#   + first_age_oldest     
#   + first_age_youngest           
#   + first_married_couple      
#   + first_C_previous            
#   + first_duration_previous      
#   + first_cost                  
#   + first_A                     
#   + first_B                      
#   + first_C           
#   + first_D       
#   + first_E                      
#   + first_F                  
#   + first_G                   
#   + before_last_A                
#   + before_last_B               
#   + before_last_C            
#   + before_last_D                
#   + before_last_E          
  + before_last_F       
#   + before_last_G                
#   + nb_minutes              
  + nb_views                   
#   + ratio_hesitation             
#   + percent_transition_F_0_vers_0 
  + percent_transition_F_0_vers_1 
#   + percent_transition_F_0_vers_2
#   + percent_transition_F_0_vers_3 
#   + percent_transition_F_1_vers_0 
  + percent_transition_F_1_vers_1
#   + percent_transition_F_1_vers_2 
#   + percent_transition_F_1_vers_3 
#   + percent_transition_F_2_vers_0
  + percent_transition_F_2_vers_1 
#   + percent_transition_F_2_vers_2 
#   + percent_transition_F_2_vers_3
#   + percent_transition_F_3_vers_0 
  + percent_transition_F_3_vers_1 
#   + percent_transition_F_3_vers_2
#   + percent_transition_F_3_vers_3 
#   + percent_transition_G_1_vers_1
#   + percent_transition_G_1_vers_2
#   + percent_transition_G_1_vers_3
#   + percent_transition_G_1_vers_4 
#   + percent_transition_G_2_vers_1
#   + percent_transition_G_2_vers_2 
#   + percent_transition_G_2_vers_3
#   + percent_transition_G_2_vers_4
#   + percent_transition_G_3_vers_1 
#   + percent_transition_G_3_vers_2
#   + percent_transition_G_3_vers_3
#   + percent_transition_G_3_vers_4 
#   + percent_transition_G_4_vers_1 
#   + percent_transition_G_4_vers_2
#   + percent_transition_G_4_vers_3 
#   + percent_transition_G_4_vers_4 
#   + last_hour 
#   + first_hour   
)

formula_2 <- formula(
  I(real_F == 2) ~ 
  state
#   + last_day          
#   + last_group_size              
#   + last_homeowner       
#   + last_car_age               
#   + last_car_value               
#   + last_risk_factor            
#   + last_age_oldest             
#   + last_age_youngest            
#   + last_married_couple         
#   + last_C_previous             
#   + last_duration_previous       
#   + last_cost       
#   + last_A              
#   + last_B                       
#   + last_C                    
#   + last_D                 
#   + last_E                       
  + last_F                
#   + last_G               
#   + first_group_size             
#   + first_homeowner     
#   + first_car_age     
#   + first_car_value              
#   + first_risk_factor         
#   + first_age_oldest     
#   + first_age_youngest           
#   + first_married_couple      
#   + first_C_previous            
#   + first_duration_previous      
#   + first_cost                  
#   + first_A                     
#   + first_B                      
#   + first_C           
#   + first_D       
#   + first_E                      
#   + first_F                  
#   + first_G                   
#   + before_last_A                
#   + before_last_B               
#   + before_last_C            
#   + before_last_D                
#   + before_last_E          
  + before_last_F       
#   + before_last_G                
#   + nb_minutes              
#   + nb_views                   
#   + ratio_hesitation             
#   + percent_transition_F_0_vers_0 
#   + percent_transition_F_0_vers_1 
  + percent_transition_F_0_vers_2
#   + percent_transition_F_0_vers_3 
#   + percent_transition_F_1_vers_0 
#   + percent_transition_F_1_vers_1
  + percent_transition_F_1_vers_2 
#   + percent_transition_F_1_vers_3 
#   + percent_transition_F_2_vers_0
#   + percent_transition_F_2_vers_1 
  + percent_transition_F_2_vers_2 
#   + percent_transition_F_2_vers_3
#   + percent_transition_F_3_vers_0 
#   + percent_transition_F_3_vers_1 
  + percent_transition_F_3_vers_2
#   + percent_transition_F_3_vers_3 
#   + percent_transition_G_1_vers_1
#   + percent_transition_G_1_vers_2
#   + percent_transition_G_1_vers_3
#   + percent_transition_G_1_vers_4 
#   + percent_transition_G_2_vers_1
#   + percent_transition_G_2_vers_2 
#   + percent_transition_G_2_vers_3
#   + percent_transition_G_2_vers_4
#   + percent_transition_G_3_vers_1 
#   + percent_transition_G_3_vers_2
#   + percent_transition_G_3_vers_3
#   + percent_transition_G_3_vers_4 
#   + percent_transition_G_4_vers_1 
#   + percent_transition_G_4_vers_2
#   + percent_transition_G_4_vers_3 
#   + percent_transition_G_4_vers_4 
#   + last_hour 
#   + first_hour   
)

formula_3 <- formula(
  I(real_F == 3) ~ 
  state
#   + last_day          
#   + last_group_size              
#   + last_homeowner       
#   + last_car_age               
#   + last_car_value               
#   + last_risk_factor            
#   + last_age_oldest             
#   + last_age_youngest            
#   + last_married_couple         
#   + last_C_previous             
#   + last_duration_previous       
#   + last_cost       
#   + last_A              
#   + last_B                       
#   + last_C                    
#   + last_D                 
#   + last_E                       
  + last_F                
#   + last_G               
#   + first_group_size             
#   + first_homeowner     
#   + first_car_age     
#   + first_car_value              
#   + first_risk_factor         
#   + first_age_oldest     
#   + first_age_youngest           
#   + first_married_couple      
#   + first_C_previous            
#   + first_duration_previous      
#   + first_cost                  
#   + first_A                     
#   + first_B                      
#   + first_C           
#   + first_D       
#   + first_E                      
#   + first_F                  
#   + first_G                   
#   + before_last_A                
#   + before_last_B               
#   + before_last_C            
#   + before_last_D                
#   + before_last_E          
#   + before_last_F       
#   + before_last_G                
#   + nb_minutes              
#   + nb_views                   
#   + ratio_hesitation             
  + percent_transition_F_0_vers_0 
  + percent_transition_F_0_vers_1 
  + percent_transition_F_0_vers_2
#   + percent_transition_F_0_vers_3 
  + percent_transition_F_1_vers_0 
  + percent_transition_F_1_vers_1
  + percent_transition_F_1_vers_2 
#   + percent_transition_F_1_vers_3 
  + percent_transition_F_2_vers_0
  + percent_transition_F_2_vers_1 
  + percent_transition_F_2_vers_2 
#   + percent_transition_F_2_vers_3
  + percent_transition_F_3_vers_0 
  + percent_transition_F_3_vers_1 
  + percent_transition_F_3_vers_2
#   + percent_transition_F_3_vers_3 
#   + percent_transition_G_1_vers_1
#   + percent_transition_G_1_vers_2
#   + percent_transition_G_1_vers_3
#   + percent_transition_G_1_vers_4 
#   + percent_transition_G_2_vers_1
#   + percent_transition_G_2_vers_2 
#   + percent_transition_G_2_vers_3
#   + percent_transition_G_2_vers_4
#   + percent_transition_G_3_vers_1 
#   + percent_transition_G_3_vers_2
#   + percent_transition_G_3_vers_3
#   + percent_transition_G_3_vers_4 
#   + percent_transition_G_4_vers_1 
#   + percent_transition_G_4_vers_2
#   + percent_transition_G_4_vers_3 
#   + percent_transition_G_4_vers_4 
#   + last_hour 
#   + first_hour   
)

# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data.R"))
source(file.path("templates","test_train_skeleton_all_clusters.R"))
source(file.path("templates","glm_skeleton_error_estimate_F.R"))
source(file.path("templates","glm_skeleton_final_training_F.R"))
