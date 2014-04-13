library(RSQLite)

get.data.test <- function() {
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

-- New values

T13.nb_minutes,
T13.nb_views,
T13.ratio_hesitation,

-- Transitions F
coalesce(T16.percent_transition_F_0_vers_0, 73.33) as percent_transition_F_0_vers_0,
coalesce(T16.percent_transition_F_0_vers_1, 6.25) as percent_transition_F_0_vers_1,
coalesce(T16.percent_transition_F_0_vers_2, 9.75) as percent_transition_F_0_vers_2,
coalesce(T16.percent_transition_F_0_vers_3, 4.35) as percent_transition_F_0_vers_3,
coalesce(T16.percent_transition_F_1_vers_0, 6.9) as percent_transition_F_1_vers_0,
coalesce(T16.percent_transition_F_1_vers_1, 73.8) as percent_transition_F_1_vers_1,
coalesce(T16.percent_transition_F_1_vers_2, 11.5) as percent_transition_F_1_vers_2,
coalesce(T16.percent_transition_F_1_vers_3, 5) as percent_transition_F_1_vers_3,
coalesce(T16.percent_transition_F_2_vers_0, 6.5) as percent_transition_F_2_vers_0,
coalesce(T16.percent_transition_F_2_vers_1, 9.1) as percent_transition_F_2_vers_1,
coalesce(T16.percent_transition_F_2_vers_2, 76.9) as percent_transition_F_2_vers_2,
coalesce(T16.percent_transition_F_2_vers_3, 4.8) as percent_transition_F_2_vers_3,
coalesce(T16.percent_transition_F_3_vers_0, 16.7) as percent_transition_F_3_vers_0,
coalesce(T16.percent_transition_F_3_vers_1, 16.7) as percent_transition_F_3_vers_1,
coalesce(T16.percent_transition_F_3_vers_2, 25.0) as percent_transition_F_3_vers_2,
coalesce(T16.percent_transition_F_3_vers_3, 25.0) as percent_transition_F_3_vers_3,

-- Transitions G
coalesce(T15.percent_transition_G_1_vers_1, 27.6) as percent_transition_G_1_vers_1,
coalesce(T15.percent_transition_G_1_vers_2, 25.0) as percent_transition_G_1_vers_2,
coalesce(T15.percent_transition_G_1_vers_3, 20.0) as percent_transition_G_1_vers_3,
coalesce(T15.percent_transition_G_1_vers_4, 12.5) as percent_transition_G_1_vers_4,
coalesce(T15.percent_transition_G_2_vers_1,  9.5) as percent_transition_G_2_vers_1,
coalesce(T15.percent_transition_G_2_vers_2, 63.1) as percent_transition_G_2_vers_2,
coalesce(T15.percent_transition_G_2_vers_3,  9.1) as percent_transition_G_2_vers_3,
coalesce(T15.percent_transition_G_2_vers_4,  4.0) as percent_transition_G_2_vers_4,
coalesce(T15.percent_transition_G_3_vers_1,  8.3) as percent_transition_G_3_vers_1,
coalesce(T15.percent_transition_G_3_vers_2, 10.6) as percent_transition_G_3_vers_2,
coalesce(T15.percent_transition_G_3_vers_3, 69.2) as percent_transition_G_3_vers_3,
coalesce(T15.percent_transition_G_3_vers_4,  9.1) as percent_transition_G_3_vers_4,
coalesce(T15.percent_transition_G_4_vers_1, 12.5) as percent_transition_G_4_vers_1,
coalesce(T15.percent_transition_G_4_vers_2, 17.4) as percent_transition_G_4_vers_2,
coalesce(T15.percent_transition_G_4_vers_3, 20.0) as percent_transition_G_4_vers_3,
coalesce(T15.percent_transition_G_4_vers_4, 30.8) as percent_transition_G_4_vers_4

-- Objectifs
--T3.A as real_A,
--T3.B as real_B,
--T3.C as real_C,
--T3.D as real_D,
--T3.E as real_E,
--T3.F as real_F,
--T3.G as real_G
from
transactions T1 inner join
customers T2 on (T1.customer_ID = T2.customer_ID and T2.dataset = 'test') 
--inner join
--transactions T3 on (T1.customer_ID = T3.customer_ID)
inner join
-- last
(
select
customer_ID,
case 
when max(shopping_pt) > 3 then 3 
else max(shopping_pt)
end as last_shopping_pt
from
transactions
where
record_type = 0
group by 1
) T4 on (T1.customer_ID = T4.customer_ID and T1.shopping_pt = T4.last_shopping_pt)
inner join
(
select
customer_ID,
min(time) as min_time,
max(time) as max_time,
(substr(max(time),1,2)*60 + substr(max(time),4,2)) - (substr(min(time),1,2)*60 + substr(min(time),4,2)) as nb_minutes,
case when count(*) > 3 then 3 else count(*) end as nb_views,
(((substr(max(time),1,2)*60 + substr(max(time),4,2)) - (substr(min(time),1,2)*60 + substr(min(time),4,2)))*1.0)/count(*) as ratio_hesitation
from transactions
where
record_type = 0
group by 1
) T13 on (T1.customer_ID = T13.customer_ID)
left outer join
transitions_G T15 on (T1.location = T15.location)
left outer join
transitions_F T16 on (T1.location = T16.location)
where
T1.record_type = 0
--and
--T3.record_type = 1
--and
--T1.shopping_pt = (T3.shopping_pt-1)
")
  
  dbDisconnect(con)

  return(data)
}
