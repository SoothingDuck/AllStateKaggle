library(RSQLite)

get.data.train <- function() {
  sqlitedb.filename <- file.path("db", "allstate_data.sqlite3")
  
  drv <- dbDriver("SQLite")
  con <- dbConnect(drv, dbname=sqlitedb.filename)
  
  data <- dbGetQuery(con,
                     "
select 
-- Customer data
T1.customer_ID as customer_ID,
T2.state as state,
-- Last values data
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
coalesce(T1.C_previous, 3) as last_C_previous,
coalesce(T1.duration_previous, 15) as last_duration_previous,
T1.cost as last_cost,
T1.A as last_A,
T1.B as last_B,
T1.C as last_C,
T1.D as last_D,
T1.E as last_E,
T1.F as last_F,
T1.G as last_G,
-- T1.cluster_number as last_cluster_number,

-- First values data
T14.time as first_time,
T14.group_size as first_group_size,
T14.homeowner as first_homeowner,
T14.car_age as first_car_age,
T14.car_value as first_car_value,
T14.risk_factor as first_risk_factor,
T14.age_oldest as first_age_oldest,
T14.age_youngest as first_age_youngest,
T14.married_couple as first_married_couple,
coalesce(T14.C_previous, 3) as first_C_previous,
coalesce(T14.duration_previous, 15) as first_duration_previous,
T14.cost as first_cost,
T14.A as first_A,
T14.B as first_B,
T14.C as first_C,
T14.D as first_D,
T14.E as first_E,
T14.F as first_F,
T14.G as first_G,
-- T14.cluster_number as first_cluster_number,

-- Before last
T12.A as before_last_A,
T12.B as before_last_B,
T12.C as before_last_C,
T12.D as before_last_D,
T12.E as before_last_E,
T12.F as before_last_F,
T12.G as before_last_G,

-- Agg location

--coalesce(T4.A0_count, 2)*1.0/coalesce(T4.total_count, 12) as location_A0_percent,
--coalesce(T4.A1_count, 7)*1.0/coalesce(T4.total_count, 12) as location_A1_percent,
--coalesce(T4.A2_count, 1)*1.0/coalesce(T4.total_count, 12) as location_A2_percent,

--coalesce(T4.B0_count, 6)*1.0/coalesce(T4.total_count, 12) as location_B0_percent,
--coalesce(T4.B1_count, 5)*1.0/coalesce(T4.total_count, 12) as location_B1_percent,

--coalesce(T4.C1_count, 2)*1.0/coalesce(T4.total_count, 12) as location_C1_percent,
--coalesce(T4.C2_count, 2)*1.0/coalesce(T4.total_count, 12) as location_C2_percent,
--coalesce(T4.C3_count, 4)*1.0/coalesce(T4.total_count, 12) as location_C3_percent,
--coalesce(T4.C4_count, 1)*1.0/coalesce(T4.total_count, 12) as location_C4_percent,

--coalesce(T4.D1_count, 1)*1.0/coalesce(T4.total_count, 12) as location_D1_percent,
--coalesce(T4.D2_count, 2)*1.0/coalesce(T4.total_count, 12) as location_D2_percent,
--coalesce(T4.D3_count, 6)*1.0/coalesce(T4.total_count, 12) as location_D3_percent,

--coalesce(T4.E0_count, 6)*1.0/coalesce(T4.total_count, 12) as location_E0_percent,
--coalesce(T4.E1_count, 5)*1.0/coalesce(T4.total_count, 12) as location_E1_percent,

--coalesce(T4.F0_count, 2)*1.0/coalesce(T4.total_count, 12) as location_F0_percent,
--coalesce(T4.F1_count, 2)*1.0/coalesce(T4.total_count, 12) as location_F1_percent,
--coalesce(T4.F2_count, 3)*1.0/coalesce(T4.total_count, 12) as location_F2_percent,
--coalesce(T4.F3_count, 0)*1.0/coalesce(T4.total_count, 12) as location_F3_percent,

--coalesce(T4.G1_count, 0)*1.0/coalesce(T4.total_count, 12) as location_G1_percent,
--coalesce(T4.G2_count, 3)*1.0/coalesce(T4.total_count, 12) as location_G2_percent,
--coalesce(T4.G3_count, 2)*1.0/coalesce(T4.total_count, 12) as location_G3_percent,
--coalesce(T4.G4_count, 0)*1.0/coalesce(T4.total_count, 12) as location_G4_percent,
                     
-- Agg Customer

--coalesce(T10.A0_count, 0)*1.0/coalesce(T10.total_count, 6) customer_A0_percent,
--coalesce(T10.A1_count, 4)*1.0/coalesce(T10.total_count, 6) customer_A1_percent,
--coalesce(T10.A2_count, 0)*1.0/coalesce(T10.total_count, 6) customer_A2_percent,

--coalesce(T10.B0_count, 3)*1.0/coalesce(T10.total_count, 6) customer_B0_percent,
--coalesce(T10.B1_count, 1)*1.0/coalesce(T10.total_count, 6) customer_B1_percent,

--coalesce(T10.C1_count, 0)*1.0/coalesce(T10.total_count, 6) customer_C1_percent,
--coalesce(T10.C2_count, 0)*1.0/coalesce(T10.total_count, 6) customer_C2_percent,
--coalesce(T10.C3_count, 1)*1.0/coalesce(T10.total_count, 6) customer_C3_percent,
--coalesce(T10.C4_count, 0)*1.0/coalesce(T10.total_count, 6) customer_C4_percent,

--coalesce(T10.D1_count, 0)*1.0/coalesce(T10.total_count, 6) customer_D1_percent,
--coalesce(T10.D2_count, 0)*1.0/coalesce(T10.total_count, 6) customer_D2_percent,
--coalesce(T10.D3_count, 4)*1.0/coalesce(T10.total_count, 6) customer_D3_percent,

--coalesce(T10.E0_count, 3)*1.0/coalesce(T10.total_count, 6) customer_E0_percent,
--coalesce(T10.E1_count, 1)*1.0/coalesce(T10.total_count, 6) customer_E1_percent,

--coalesce(T10.F0_count, 0)*1.0/coalesce(T10.total_count, 6) customer_F0_percent,
--coalesce(T10.F1_count, 0)*1.0/coalesce(T10.total_count, 6) customer_F1_percent,
--coalesce(T10.F2_count, 1)*1.0/coalesce(T10.total_count, 6) customer_F2_percent,
--coalesce(T10.F3_count, 0)*1.0/coalesce(T10.total_count, 6) customer_F3_percent,

--coalesce(T10.G1_count, 0)*1.0/coalesce(T10.total_count, 6) customer_G1_percent,
--coalesce(T10.G2_count, 1)*1.0/coalesce(T10.total_count, 6) customer_G2_percent,
--coalesce(T10.G3_count, 0)*1.0/coalesce(T10.total_count, 6) customer_G3_percent,
--coalesce(T10.G4_count, 0)*1.0/coalesce(T10.total_count, 6) customer_G4_percent,

-- Location Customer

--(coalesce(T4.A0_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.A0_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_A0_percent,
--(coalesce(T4.A1_count, 7)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.A1_count, 4)*1.0/coalesce(T10.total_count, 6)) as customer_location_A1_percent,
--(coalesce(T4.A2_count, 1)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.A2_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_A2_percent,

--(coalesce(T4.B0_count, 6)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.B0_count, 3)*1.0/coalesce(T10.total_count, 6)) as customer_location_B0_percent,
--(coalesce(T4.B1_count, 5)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.B1_count, 1)*1.0/coalesce(T10.total_count, 6)) as customer_location_B1_percent,

--(coalesce(T4.C1_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.C1_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_C1_percent,
--(coalesce(T4.C2_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.C2_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_C2_percent,
--(coalesce(T4.C3_count, 4)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.C3_count, 1)*1.0/coalesce(T10.total_count, 6)) as customer_location_C3_percent,
--(coalesce(T4.C4_count, 1)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.C4_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_C4_percent,

--(coalesce(T4.D1_count, 1)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.D1_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_D1_percent,
--(coalesce(T4.D2_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.D2_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_D2_percent,
--(coalesce(T4.D3_count, 6)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.D3_count, 4)*1.0/coalesce(T10.total_count, 6)) as customer_location_D3_percent,

--(coalesce(T4.E0_count, 6)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.E0_count, 3)*1.0/coalesce(T10.total_count, 6)) as customer_location_E0_percent,
--(coalesce(T4.E1_count, 5)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.E1_count, 1)*1.0/coalesce(T10.total_count, 6)) as customer_location_E1_percent,

--(coalesce(T4.F0_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.F0_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_F0_percent,
--(coalesce(T4.F1_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.F1_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_F1_percent,
--(coalesce(T4.F2_count, 3)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.F2_count, 1)*1.0/coalesce(T10.total_count, 6)) as customer_location_F2_percent,
--(coalesce(T4.F3_count, 0)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.F3_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_F3_percent,

--(coalesce(T4.G1_count, 0)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.G1_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_G1_percent,
--(coalesce(T4.G2_count, 3)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.G2_count, 1)*1.0/coalesce(T10.total_count, 6)) as customer_location_G2_percent,
--(coalesce(T4.G3_count, 2)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.G3_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_G3_percent,
--(coalesce(T4.G4_count, 0)*1.0/coalesce(T4.total_count, 12))*(coalesce(T10.G4_count, 0)*1.0/coalesce(T10.total_count, 6)) as customer_location_G4_percent,

-- New values

T13.nb_minutes,
T13.nb_views,
T13.ratio_hesitation,

-- Transitions F
T16.percent_transition_F_0_vers_0,
T16.percent_transition_F_0_vers_1,
T16.percent_transition_F_0_vers_2,
T16.percent_transition_F_0_vers_3,
T16.percent_transition_F_1_vers_0,
T16.percent_transition_F_1_vers_1,
T16.percent_transition_F_1_vers_2,
T16.percent_transition_F_1_vers_3,
T16.percent_transition_F_2_vers_0,
T16.percent_transition_F_2_vers_1,
T16.percent_transition_F_2_vers_2,
T16.percent_transition_F_2_vers_3,
T16.percent_transition_F_3_vers_0,
T16.percent_transition_F_3_vers_1,
T16.percent_transition_F_3_vers_2,
T16.percent_transition_F_3_vers_3,

-- Transitions G
T15.percent_transition_G_1_vers_1,
T15.percent_transition_G_1_vers_2,
T15.percent_transition_G_1_vers_3,
T15.percent_transition_G_1_vers_4,
T15.percent_transition_G_2_vers_1,
T15.percent_transition_G_2_vers_2,
T15.percent_transition_G_2_vers_3,
T15.percent_transition_G_2_vers_4,
T15.percent_transition_G_3_vers_1,
T15.percent_transition_G_3_vers_2,
T15.percent_transition_G_3_vers_3,
T15.percent_transition_G_3_vers_4,
T15.percent_transition_G_4_vers_1,
T15.percent_transition_G_4_vers_2,
T15.percent_transition_G_4_vers_3,
T15.percent_transition_G_4_vers_4,

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
customer_agg T10 on (T1.customer_ID = T10.customer_ID)
inner join
(
  select
  A.customer_ID,
  case
    when max(A.shopping_pt) = 1 then 1
    else max(A.shopping_pt)-1
  end as shopping_pt_before_last
  from
  transactions A,
  customers B
  where
  A.customer_ID = B.customer_ID
  and
  B.dataset = 'train'
  and
  A.record_type = 0
  group by 1
) T11 on (T1.customer_ID = T11.customer_ID)
inner join
transactions T12 on (T11.customer_ID = T12.customer_id and T12.shopping_pt = T11.shopping_pt_before_last)
inner join
(
  select
  customer_ID,
  min(time) as min_time,
  max(time) as max_time,
  (substr(max(time),1,2)*60 + substr(max(time),4,2)) - (substr(min(time),1,2)*60 + substr(min(time),4,2)) as nb_minutes,
  count(*) as nb_views,
  (((substr(max(time),1,2)*60 + substr(max(time),4,2)) - (substr(min(time),1,2)*60 + substr(min(time),4,2)))*1.0)/count(*) as ratio_hesitation
  from transactions
  where
  record_type = 0
  group by 1
) T13 on (T1.customer_ID = T13.customer_ID)
inner join 
transactions T14 on (T1.customer_ID = T14.customer_ID and T14.shopping_pt = 1)
inner join
transitions_G T15 on (T1.location = T15.location)
inner join
transitions_F T16 on (T1.location = T16.location)
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
