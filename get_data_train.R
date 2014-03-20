library(RSQLite)

get.data.train <- function() {
  sqlitedb.filename <- "allstate_data.sqlite3"
  
  drv <- dbDriver("SQLite")
  con <- dbConnect(drv, dbname=sqlitedb.filename)
  
  data <- dbGetQuery(con,
                     "
select 
T1.customer_ID as customer_ID,
T2.state as state,
T1.day as last_day,
T1.time as last_time,
T1.group_size as last_group_size,
T1.homeowner as last_homeowner,
T1.car_age as last_car_age,
T1.car_value as last_car_value,
T1.risk_factor as last_risk_factor,
T1.age_oldest as last_age_oldest,
T1.age_youngest as last_age_youngest,
T1.married_couple as last_married_couple,
--T1.C_previous as last_C_previous,
--T1.duration_previous as last_duration_previous,
T1.cost as last_cost,
T1.A as last_A,
T1.B as last_B,
T1.C as last_C,
T1.D as last_D,
T1.E as last_E,
T1.F as last_F,
T1.G as last_G,
-- Agg
T4.A_proba_1 as location_A_proba_1,
T4.A_proba_2 as location_A_proba_2,
T4.A_proba_3 as location_A_proba_3,
T4.B_proba_1 as location_B_proba_1,
T4.B_proba_2 as location_B_proba_2,
T4.C_proba_1 as location_C_proba_1,
T4.C_proba_2 as location_C_proba_2,
T4.C_proba_3 as location_C_proba_3,
T4.C_proba_4 as location_C_proba_4,
T4.D_proba_1 as location_D_proba_1,
T4.D_proba_2 as location_D_proba_2,
T4.D_proba_3 as location_D_proba_3,
T4.E_proba_1 as location_E_proba_1,
T4.E_proba_2 as location_E_proba_2,
T4.F_proba_1 as location_F_proba_1,
T4.F_proba_2 as location_F_proba_2,
T4.F_proba_3 as location_F_proba_3,
T4.F_proba_4 as location_F_proba_4,
T4.G_proba_1 as location_G_proba_1,
T4.G_proba_2 as location_G_proba_2,
T4.G_proba_3 as location_G_proba_3,
T4.G_proba_4 as location_G_proba_4,
-- Estimation G
--coalesce(T5.count_G1, 0) as ABCDEF_count_G1,
--coalesce(T5.count_G2, 0) as ABCDEF_count_G2,
--coalesce(T5.count_G3, 0) as ABCDEF_count_G3,
--coalesce(T5.count_G4, 0) as ABCDEF_count_G4,
--coalesce(T5.percent_G1, 0) as ABCDEF_percent_G1,
--coalesce(T5.percent_G2, 0) as ABCDEF_percent_G2,
--coalesce(T5.percent_G3, 0) as ABCDEF_percent_G3,
--coalesce(T5.percent_G4, 0) as ABCDEF_percent_G4,
-- Location agg
coalesce(T6.nb_vente,24) as location_nb_vente,
-- location big
--case
--  when T8.location is null then 'SmallLocation'
--  when T8.nb_achat < 80 then 'SmallLocation'
--  else T8.location
--end as big_location,
-- Customer Agg
coalesce(T7.nb_view, 6) as customer_nb_view,
-- Objectifs
T3.A as real_A,
T3.B as real_B,
T3.C as real_C,
T3.D as real_D,
T3.E as real_E,
T3.F as real_F,
T3.G as real_G
from
transactions T1 inner join
customers T2 on (T1.customer_ID = T2.customer_ID and T2.dataset = 'train') inner join
transactions T3 on (T1.customer_ID = T3.customer_ID) left outer join
location_agg T4 on (T1.location = T4.location) left outer join
ABCDEF_agg T5 on (
T1.A || T1.B || T1.C || T1.D || T1.E || T1.F = T5.ABCDEF
) left outer join
(
  select
  location,
  count(*) as nb_vente
  from transactions
  where record_type = 1
  group by 1
) T6 on (T1.location = T6.location)
inner join
(
  select
  customer_ID,
  count(*) as nb_view
  from transactions
  where record_type = 0
  group by 1
) T7 on (T1.customer_ID = T7.customer_ID)
left outer join
(
  select
  location,
  count(*) as nb_achat
  from transactions
  where record_type = 1
  group by 1
) T8 on (T1.location = T8.location)
inner join
(
  select
  customer_ID,
  error_A,
  error_B,
  error_C,
  error_D,
  error_E,
  error_F,
  error_G,
  error_A+error_B+error_C+error_D+error_E+error_F+error_G as total_error
  from
  (
  select
  T1.customer_ID,
  case when T1.A = T2.A then 0 else 1 end as error_A,
  case when T1.B = T2.B then 0 else 1 end as error_B,
  case when T1.C = T2.C then 0 else 1 end as error_C,
  case when T1.D = T2.D then 0 else 1 end as error_D,
  case when T1.E = T2.E then 0 else 1 end as error_E,
  case when T1.F = T2.F then 0 else 1 end as error_F,
  case when T1.G = T2.G then 0 else 1 end as error_G
  from
  transactions T1 inner join
  transactions T2 on (T1.customer_ID = T2.customer_ID and T1.record_type = 0 and T2.record_type=1)
  where
  T1.shopping_pt = (T2.shopping_pt - 1)
  ) A
) T9 on (T1.customer_ID = T9.customer_ID and T9.total_error <= 2)
where
T1.record_type = 0
and
T3.record_type = 1
and
T1.shopping_pt = (T3.shopping_pt-1)
                     ")
  
  dbDisconnect(con)

  return(data)
}
