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
real_A,
real_B,
real_C,
real_D,
real_E,
real_F,
real_G 
from
data_train_model_glm_first_no_error
                     ")
  
  dbDisconnect(con)

  return(data)
}
