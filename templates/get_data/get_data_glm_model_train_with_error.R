library(RSQLite)

get.data.glm.model.train <- function() {
  sqlitedb.filename <- file.path("db", "allstate_data.sqlite3")
  
  drv <- dbDriver("SQLite")
  con <- dbConnect(drv, dbname=sqlitedb.filename)
  
  data <- dbGetQuery(con,
                     "
select 
customer_ID,
state,
day,
group_size,
homeowner,
car_age,
car_value,
risk_factor,
age_youngest,
age_oldest,
married_couple,
C_previous,
duration_previous,
last_cost,
shopping_pt_2_cost,
shopping_pt_3_cost,
shopping_pt_min_cost_cost,
last_A,
last_B,
last_C,
last_D,
last_E,
last_F,
last_G,
shopping_pt_2_A,
shopping_pt_2_B,
shopping_pt_2_C,
shopping_pt_2_D,
shopping_pt_2_E,
shopping_pt_2_F,
shopping_pt_2_G,
shopping_pt_3_A,
shopping_pt_3_B,
shopping_pt_3_C,
shopping_pt_3_D,
shopping_pt_3_E,
shopping_pt_3_F,
shopping_pt_3_G,
shopping_pt_min_cost_A,
shopping_pt_min_cost_B,
shopping_pt_min_cost_C,
shopping_pt_min_cost_D,
shopping_pt_min_cost_E,
shopping_pt_min_cost_F,
shopping_pt_min_cost_G,
A0_count,
A1_count,
A2_count,
B0_count,
B1_count,
C1_count,
C2_count,
C3_count,
C4_count,
D1_count,
D2_count,
D3_count,
E0_count,
E1_count,
F0_count,
F1_count,
F2_count,
F3_count,
G1_count,
G2_count,
G3_count,  
G4_count,
real_A,
real_B,
real_C,
real_D,
real_E,
real_F,
real_G 
from
data_train_model_glm_first_with_error
                     ")
  
  dbDisconnect(con)

  return(data)
}
