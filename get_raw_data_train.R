library(RSQLite)

get.raw.data.train <- function() {
  sqlitedb.filename <- "allstate_data.sqlite3"
  
  drv <- dbDriver("SQLite")
  con <- dbConnect(drv, dbname=sqlitedb.filename)
  
  data <- dbGetQuery(con,
                     "
select
T2.state,
T1.customer_ID,
T1.shopping_pt,
T3.shopping_pt as shopping_pt_final,
T1.day,
T3.day as day_final,
T1.time,
T3.time as time_final,
T1.location,
T3.location as location_final,
T1.group_size,
T3.group_size as group_size_final,
T1.homeowner,
T3.homeowner as homeowner_final,
T1.car_age,
T3.car_age as car_age_final,
T1.car_value,
T3.car_value as car_value_final,
T1.risk_factor,
T3.risk_factor as risk_factor_final,
T1.age_oldest,
T3.age_oldest as age_oldest_final,
T1.age_youngest,
T3.age_youngest as age_youngest_final,
T1.married_couple,
T3.married_couple as married_couple_final,
T1.C_previous,
T3.C_previous as C_previous_final,
T1.duration_previous,
T3.duration_previous as duration_previous_final,
T1.A,
T3.A as A_final,
T1.B,
T3.B as B_final,
T1.C,
T3.C as C_final,
T1.D,
T3.D as D_final,
T1.E,
T3.E as E_final,
T1.F,
T3.F as F_final,
T1.G,
T3.G as G_final,
T1.cost,
T3.cost as cost_final,
T1.line_number,
T3.line_number as line_number_final
from
transactions T1,
customers T2,
transactions T3
where
T1.customer_ID = T2.customer_ID
and
T2.customer_ID = T3.customer_ID
and
T2.dataset = 'train'
and
T1.record_type = 0
and
T3.record_type = 1
                     ")
  
  dbDisconnect(con)

  return(data)
}
