library(RSQLite)

get.data.test <- function() {
  sqlitedb.filename <- "allstate_data.sqlite3"
  
  drv <- dbDriver("SQLite")
  con <- dbConnect(drv, dbname=sqlitedb.filename)
  
  data <- dbGetQuery(con,
"
select 
T1.customer_ID,
T3.state,
--T1.day as first_view_day,
T7.day as last_view_day,
--T9.day as min_cost_view_day,
T1.time as first_view_time,
T7.time as last_view_time,
T9.time as min_cost_view_time,
T4.nb_views,
-- T1.location as first_view_location,
T5.location_popularity,
T4.nb_distinct_location,
T1.group_size as first_view_group_size,
T7.group_size as last_view_group_size,
T9.group_size as min_cost_view_group_size,
T1.homeowner as first_view_homeowner,
T7.homeowner as last_view_homeowner,
T9.homeowner as min_cost_view_homeowner,
T1.car_age as first_view_car_age,
T7.car_age as last_view_car_age,
T9.car_age as min_cost_view_car_age,
T1.car_value as first_view_car_value,
T7.car_value as last_view_car_value,
T9.car_value as min_cost_view_car_value,
case
when T1.risk_factor is null then 'Not available'
else T1.risk_factor || ''
end as first_view_risk_factor,
case
when T7.risk_factor is null then 'Not available'
else T7.risk_factor || ''
end as last_view_risk_factor,
case
when T9.risk_factor is null then 'Not available'
else T9.risk_factor || ''
end as min_cost_view_risk_factor,
T1.age_oldest as first_view_age_oldest,
T7.age_oldest as last_view_age_oldest,
T9.age_oldest as min_cost_view_age_oldest,
T1.age_youngest as first_view_age_youngest,
T7.age_youngest as last_view_age_youngest,
T9.age_youngest as min_cost_view_age_youngest,
T1.married_couple as first_view_married_couple,
T7.married_couple as last_view_married_couple,
T9.married_couple as min_cost_view_married_couple,
case
when T1.C_previous is null then 'Not available'
else T1.C_previous || ''
end as first_view_C_previous,
case
when T7.C_previous is null then 'Not available'
else T7.C_previous || ''
end as last_view_C_previous,
case
when T9.C_previous is null then 'Not available'
else T9.C_previous || ''
end as min_cost_view_C_previous,
case
when T1.duration_previous is null then 6
else T1.duration_previous
end as first_view_duration_previous,
case
when T7.duration_previous is null then 6
else T7.duration_previous
end as last_view_duration_previous,
case
when T9.duration_previous is null then 6
else T9.duration_previous
end as min_cost_view_duration_previous,
T1.cost as first_view_cost,
T7.cost as last_view_cost,
T9.cost as min_cost_view_cost,
T1.A as first_view_A,
T7.A as last_view_A,
T9.A as min_cost_view_A,
T1.B as first_view_B,
T7.B as last_view_B,
T9.B as min_cost_view_B,
T1.C as first_view_C,
T7.C as last_view_C,
T9.C as min_cost_view_C,
T1.D as first_view_D,
T7.D as last_view_D,
T9.D as min_cost_view_D,
T1.E as first_view_E,
T7.E as last_view_E,
T9.E as min_cost_view_E,
T1.F as first_view_F,
T7.F as last_view_F,
T9.F as min_cost_view_F,
T1.G as first_view_G,
T7.G as last_view_G,
T9.G as min_cost_view_G,
T10.count_distinct_car_value,
T10.min_cost,
T10.max_cost,
T10.avg_cost,
-- G
T10.G1_count_customer_view,
T10.G2_count_customer_view,
T10.G3_count_customer_view,
T10.G4_count_customer_view,
T10.G1_percent_customer_view,
T10.G2_percent_customer_view,
T10.G3_percent_customer_view,
T10.G4_percent_customer_view,
-- A
coalesce(T11.A0_count_location_view, 0) as A0_count_location_view,
coalesce(T11.A1_count_location_view, 0) as A1_count_location_view,
coalesce(T11.A2_count_location_view, 0) as A2_count_location_view,
coalesce(T11.A0_percent_location_view, 0) as A0_percent_location_view,
coalesce(T11.A1_percent_location_view, 0) as A1_percent_location_view,
coalesce(T11.A2_percent_location_view, 0) as A2_percent_location_view,
coalesce(T11.A0_count_location_buy, 0) as A0_count_location_buy,
coalesce(T11.A1_count_location_buy, 0) as A1_count_location_buy,
coalesce(T11.A2_count_location_buy, 0) as A2_count_location_buy,
coalesce(T11.A0_percent_location_buy, 0) as A0_percent_location_buy,
coalesce(T11.A1_percent_location_buy, 0) as A1_percent_location_buy,
coalesce(T11.A2_percent_location_buy, 0) as A2_percent_location_buy,
-- B
coalesce(T11.B0_count_location_view, 0) as B0_count_location_view,
coalesce(T11.B1_count_location_view, 0) as B1_count_location_view,
coalesce(T11.B0_percent_location_view, 0) as B0_percent_location_view,
coalesce(T11.B1_percent_location_view, 0) as B1_percent_location_view,
coalesce(T11.B0_count_location_buy, 0) as B0_count_location_buy,
coalesce(T11.B1_count_location_buy, 0) as B1_count_location_buy,
coalesce(T11.B0_percent_location_buy, 0) as B0_percent_location_buy,
coalesce(T11.B1_percent_location_buy, 0) as B1_percent_location_buy,
-- C
coalesce(T11.C1_count_location_view, 0) as C1_count_location_view,
coalesce(T11.C2_count_location_view, 0) as C2_count_location_view,
coalesce(T11.C3_count_location_view, 0) as C3_count_location_view,
coalesce(T11.C4_count_location_view, 0) as C4_count_location_view,
coalesce(T11.C1_percent_location_view, 0) as C1_percent_location_view,
coalesce(T11.C2_percent_location_view, 0) as C2_percent_location_view,
coalesce(T11.C3_percent_location_view, 0) as C3_percent_location_view,
coalesce(T11.C4_percent_location_view, 0) as C4_percent_location_view,
coalesce(T11.C1_count_location_buy, 0) as C1_count_location_buy,
coalesce(T11.C2_count_location_buy, 0) as C2_count_location_buy,
coalesce(T11.C3_count_location_buy, 0) as C3_count_location_buy,
coalesce(T11.C4_count_location_buy, 0) as C4_count_location_buy,
coalesce(T11.C1_percent_location_buy, 0) as C1_percent_location_buy,
coalesce(T11.C2_percent_location_buy, 0) as C2_percent_location_buy,
coalesce(T11.C3_percent_location_buy, 0) as C3_percent_location_buy,
coalesce(T11.C4_percent_location_buy, 0) as C4_percent_location_buy,
-- D
coalesce(T11.D1_count_location_view, 0) as D1_count_location_view,
coalesce(T11.D2_count_location_view, 0) as D2_count_location_view,
coalesce(T11.D3_count_location_view, 0) as D3_count_location_view,
coalesce(T11.D1_percent_location_view, 0) as D1_percent_location_view,
coalesce(T11.D2_percent_location_view, 0) as D2_percent_location_view,
coalesce(T11.D3_percent_location_view, 0) as D3_percent_location_view,
coalesce(T11.D1_count_location_buy, 0) as D1_count_location_buy,
coalesce(T11.D2_count_location_buy, 0) as D2_count_location_buy,
coalesce(T11.D3_count_location_buy, 0) as D3_count_location_buy,
coalesce(T11.D1_percent_location_buy, 0) as D1_percent_location_buy,
coalesce(T11.D2_percent_location_buy, 0) as D2_percent_location_buy,
coalesce(T11.D3_percent_location_buy, 0) as D3_percent_location_buy,
-- E
coalesce(T11.E0_count_location_view, 0) as E0_count_location_view,
coalesce(T11.E1_count_location_view, 0) as E1_count_location_view,
coalesce(T11.E0_percent_location_view, 0) as E0_percent_location_view,
coalesce(T11.E1_percent_location_view, 0) as E1_percent_location_view,
coalesce(T11.E0_count_location_buy, 0) as E0_count_location_buy,
coalesce(T11.E1_count_location_buy, 0) as E1_count_location_buy,
coalesce(T11.E0_percent_location_buy, 0) as E0_percent_location_buy,
coalesce(T11.E1_percent_location_buy, 0) as E1_percent_location_buy,
-- F
coalesce(T11.F0_count_location_view, 0) as F0_count_location_view,
coalesce(T11.F1_count_location_view, 0) as F1_count_location_view,
coalesce(T11.F2_count_location_view, 0) as F2_count_location_view,
coalesce(T11.F3_count_location_view, 0) as F3_count_location_view,
coalesce(T11.F0_percent_location_view, 0) as F0_percent_location_view,
coalesce(T11.F1_percent_location_view, 0) as F1_percent_location_view,
coalesce(T11.F2_percent_location_view, 0) as F2_percent_location_view,
coalesce(T11.F3_percent_location_view, 0) as F3_percent_location_view,
coalesce(T11.F0_count_location_buy, 0) as F0_count_location_buy,
coalesce(T11.F1_count_location_buy, 0) as F1_count_location_buy,
coalesce(T11.F2_count_location_buy, 0) as F2_count_location_buy,
coalesce(T11.F3_count_location_buy, 0) as F3_count_location_buy,
coalesce(T11.F0_percent_location_buy, 0) as F0_percent_location_buy,
coalesce(T11.F1_percent_location_buy, 0) as F1_percent_location_buy,
coalesce(T11.F2_percent_location_buy, 0) as F2_percent_location_buy,
coalesce(T11.F3_percent_location_buy, 0) as F3_percent_location_buy,
-- G
coalesce(T11.G1_count_location_view, 0) as G1_count_location_view,
coalesce(T11.G2_count_location_view, 0) as G2_count_location_view,
coalesce(T11.G3_count_location_view, 0) as G3_count_location_view,
coalesce(T11.G4_count_location_view, 0) as G4_count_location_view,
coalesce(T11.G1_percent_location_view, 0) as G1_percent_location_view,
coalesce(T11.G2_percent_location_view, 0) as G2_percent_location_view,
coalesce(T11.G3_percent_location_view, 0) as G3_percent_location_view,
coalesce(T11.G4_percent_location_view, 0) as G4_percent_location_view,
coalesce(T11.G1_count_location_buy, 0) as G1_count_location_buy,
coalesce(T11.G2_count_location_buy, 0) as G2_count_location_buy,
coalesce(T11.G3_count_location_buy, 0) as G3_count_location_buy,
coalesce(T11.G4_count_location_buy, 0) as G4_count_location_buy,
coalesce(T11.G1_percent_location_buy, 0) as G1_percent_location_buy,
coalesce(T11.G2_percent_location_buy, 0) as G2_percent_location_buy,
coalesce(T11.G3_percent_location_buy, 0) as G3_percent_location_buy,
coalesce(T11.G4_percent_location_buy, 0) as G4_percent_location_buy
--T2.A as real_A,
--T2.B as real_B,
--T2.C as real_C,
--T2.D as real_D,
--T2.E as real_E,
--T2.F as real_F,
--T2.G as real_G
--T2.car_value as next_car_value
--T1.A || T1.B || T1.C || T1.D || T1.E || T1.F as first_view_ABCDEF,
--T7.A || T7.B || T7.C || T7.D || T7.E || T7.F as last_view_ABCDEF,
--T2.A || T2.B || T2.C || T2.D || T2.E || T2.F as real_ABCDEF
from
transactions T1 left outer join (
  select
  T1.location,
  -- A
  T1.A0_count_location_view,
  T1.A1_count_location_view,
  T1.A2_count_location_view,
  T1.A0_percent_location_view,
  T1.A1_percent_location_view,
  T1.A2_percent_location_view,
  -- B
  T1.B0_count_location_view,
  T1.B1_count_location_view,
  T1.B0_percent_location_view,
  T1.B1_percent_location_view,
  -- C
  T1.C1_count_location_view,
  T1.C2_count_location_view,
  T1.C3_count_location_view,
  T1.C4_count_location_view,
  T1.C1_percent_location_view,
  T1.C2_percent_location_view,
  T1.C3_percent_location_view,
  T1.C4_percent_location_view,
  -- D
  T1.D1_count_location_view,
  T1.D2_count_location_view,
  T1.D3_count_location_view,
  T1.D1_percent_location_view,
  T1.D2_percent_location_view,
  T1.D3_percent_location_view,
  -- E
  T1.E0_count_location_view,
  T1.E1_count_location_view,
  T1.E0_percent_location_view,
  T1.E1_percent_location_view,
  -- F
  T1.F0_count_location_view,
  T1.F1_count_location_view,
  T1.F2_count_location_view,
  T1.F3_count_location_view,
  T1.F0_percent_location_view,
  T1.F1_percent_location_view,
  T1.F2_percent_location_view,
  T1.F3_percent_location_view,
  -- G
  T1.G1_count_location_view,
  T1.G2_count_location_view,
  T1.G3_count_location_view,
  T1.G4_count_location_view,
  T1.G1_percent_location_view,
  T1.G2_percent_location_view,
  T1.G3_percent_location_view,
  T1.G4_percent_location_view,
  -- A
  T2.A0_count_location_buy,
  T2.A1_count_location_buy,
  T2.A2_count_location_buy,
  T2.A0_percent_location_buy,
  T2.A1_percent_location_buy,
  T2.A2_percent_location_buy,
  -- B
  T2.B0_count_location_buy,
  T2.B1_count_location_buy,
  T2.B0_percent_location_buy,
  T2.B1_percent_location_buy,
  -- C
  T2.C1_count_location_buy,
  T2.C2_count_location_buy,
  T2.C3_count_location_buy,
  T2.C4_count_location_buy,
  T2.C1_percent_location_buy,
  T2.C2_percent_location_buy,
  T2.C3_percent_location_buy,
  T2.C4_percent_location_buy,
  -- D
  T2.D1_count_location_buy,
  T2.D2_count_location_buy,
  T2.D3_count_location_buy,
  T2.D1_percent_location_buy,
  T2.D2_percent_location_buy,
  T2.D3_percent_location_buy,
  -- E
  T2.E0_count_location_buy,
  T2.E1_count_location_buy,
  T2.E0_percent_location_buy,
  T2.E1_percent_location_buy,
  -- F
  T2.F0_count_location_buy,
  T2.F1_count_location_buy,
  T2.F2_count_location_buy,
  T2.F3_count_location_buy,
  T2.F0_percent_location_buy,
  T2.F1_percent_location_buy,
  T2.F2_percent_location_buy,
  T2.F3_percent_location_buy,
  -- G
  T2.G1_count_location_buy,
  T2.G2_count_location_buy,
  T2.G3_count_location_buy,
  T2.G4_count_location_buy,
  T2.G1_percent_location_buy,
  T2.G2_percent_location_buy,
  T2.G3_percent_location_buy,
  T2.G4_percent_location_buy
  from
  (
    select
    location,
    -- A
    sum(case when A = 0 then 1 else 0 end) as A0_count_location_view,
    sum(case when A = 1 then 1 else 0 end) as A1_count_location_view,
    sum(case when A = 2 then 1 else 0 end) as A2_count_location_view,
    sum(case when A = 0 then 1 else 0 end)*1.0/count(*) as A0_percent_location_view,
    sum(case when A = 1 then 1 else 0 end)*1.0/count(*) as A1_percent_location_view,
    sum(case when A = 2 then 1 else 0 end)*1.0/count(*) as A2_percent_location_view,
    -- B
    sum(case when B = 0 then 1 else 0 end) as B0_count_location_view,
    sum(case when B = 1 then 1 else 0 end) as B1_count_location_view,
    sum(case when B = 0 then 1 else 0 end)*1.0/count(*) as B0_percent_location_view,
    sum(case when B = 1 then 1 else 0 end)*1.0/count(*) as B1_percent_location_view,
    -- C
    sum(case when C = 1 then 1 else 0 end) as C1_count_location_view,
    sum(case when C = 2 then 1 else 0 end) as C2_count_location_view,
    sum(case when C = 3 then 1 else 0 end) as C3_count_location_view,
    sum(case when C = 4 then 1 else 0 end) as C4_count_location_view,
    sum(case when C = 1 then 1 else 0 end)*1.0/count(*) as C1_percent_location_view,
    sum(case when C = 2 then 1 else 0 end)*1.0/count(*) as C2_percent_location_view,
    sum(case when C = 3 then 1 else 0 end)*1.0/count(*) as C3_percent_location_view,
    sum(case when C = 4 then 1 else 0 end)*1.0/count(*) as C4_percent_location_view,
    -- D
    sum(case when D = 1 then 1 else 0 end) as D1_count_location_view,
    sum(case when D = 2 then 1 else 0 end) as D2_count_location_view,
    sum(case when D = 3 then 1 else 0 end) as D3_count_location_view,
    sum(case when D = 1 then 1 else 0 end)*1.0/count(*) as D1_percent_location_view,
    sum(case when D = 2 then 1 else 0 end)*1.0/count(*) as D2_percent_location_view,
    sum(case when D = 3 then 1 else 0 end)*1.0/count(*) as D3_percent_location_view,
    -- E
    sum(case when E = 0 then 1 else 0 end) as E0_count_location_view,
    sum(case when E = 1 then 1 else 0 end) as E1_count_location_view,
    sum(case when E = 0 then 1 else 0 end)*1.0/count(*) as E0_percent_location_view,
    sum(case when E = 1 then 1 else 0 end)*1.0/count(*) as E1_percent_location_view,
    -- F
    sum(case when F = 0 then 1 else 0 end) as F0_count_location_view,
    sum(case when F = 1 then 1 else 0 end) as F1_count_location_view,
    sum(case when F = 2 then 1 else 0 end) as F2_count_location_view,
    sum(case when F = 3 then 1 else 0 end) as F3_count_location_view,
    sum(case when F = 0 then 1 else 0 end)*1.0/count(*) as F0_percent_location_view,
    sum(case when F = 1 then 1 else 0 end)*1.0/count(*) as F1_percent_location_view,
    sum(case when F = 2 then 1 else 0 end)*1.0/count(*) as F2_percent_location_view,
    sum(case when F = 3 then 1 else 0 end)*1.0/count(*) as F3_percent_location_view,
    -- G
    sum(case when G = 1 then 1 else 0 end) as G1_count_location_view,
    sum(case when G = 2 then 1 else 0 end) as G2_count_location_view,
    sum(case when G = 3 then 1 else 0 end) as G3_count_location_view,
    sum(case when G = 4 then 1 else 0 end) as G4_count_location_view,
    sum(case when G = 1 then 1 else 0 end)*1.0/count(*) as G1_percent_location_view,
    sum(case when G = 2 then 1 else 0 end)*1.0/count(*) as G2_percent_location_view,
    sum(case when G = 3 then 1 else 0 end)*1.0/count(*) as G3_percent_location_view,
    sum(case when G = 4 then 1 else 0 end)*1.0/count(*) as G4_percent_location_view
    from
    transactions T1, customers T2
    where
    T1.record_type = 0
    and
    T1.location <> ''
    and
    T1.customer_ID = T2.customer_ID
    and
    T2.dataset = 'train'
    group by 1
  ) T1 inner join
  (
    select
    location,
    -- A
    sum(case when A = 0 then 1 else 0 end) as A0_count_location_buy,
    sum(case when A = 1 then 1 else 0 end) as A1_count_location_buy,
    sum(case when A = 2 then 1 else 0 end) as A2_count_location_buy,
    sum(case when A = 0 then 1 else 0 end)*1.0/count(*) as A0_percent_location_buy,
    sum(case when A = 1 then 1 else 0 end)*1.0/count(*) as A1_percent_location_buy,
    sum(case when A = 2 then 1 else 0 end)*1.0/count(*) as A2_percent_location_buy,
    -- B
    sum(case when B = 0 then 1 else 0 end) as B0_count_location_buy,
    sum(case when B = 1 then 1 else 0 end) as B1_count_location_buy,
    sum(case when B = 0 then 1 else 0 end)*1.0/count(*) as B0_percent_location_buy,
    sum(case when B = 1 then 1 else 0 end)*1.0/count(*) as B1_percent_location_buy,
    -- C
    sum(case when C = 1 then 1 else 0 end) as C1_count_location_buy,
    sum(case when C = 2 then 1 else 0 end) as C2_count_location_buy,
    sum(case when C = 3 then 1 else 0 end) as C3_count_location_buy,
    sum(case when C = 4 then 1 else 0 end) as C4_count_location_buy,
    sum(case when C = 1 then 1 else 0 end)*1.0/count(*) as C1_percent_location_buy,
    sum(case when C = 2 then 1 else 0 end)*1.0/count(*) as C2_percent_location_buy,
    sum(case when C = 3 then 1 else 0 end)*1.0/count(*) as C3_percent_location_buy,
    sum(case when C = 4 then 1 else 0 end)*1.0/count(*) as C4_percent_location_buy,
    -- D
    sum(case when D = 1 then 1 else 0 end) as D1_count_location_buy,
    sum(case when D = 2 then 1 else 0 end) as D2_count_location_buy,
    sum(case when D = 3 then 1 else 0 end) as D3_count_location_buy,
    sum(case when D = 1 then 1 else 0 end)*1.0/count(*) as D1_percent_location_buy,
    sum(case when D = 2 then 1 else 0 end)*1.0/count(*) as D2_percent_location_buy,
    sum(case when D = 3 then 1 else 0 end)*1.0/count(*) as D3_percent_location_buy,
    -- E
    sum(case when E = 0 then 1 else 0 end) as E0_count_location_buy,
    sum(case when E = 1 then 1 else 0 end) as E1_count_location_buy,
    sum(case when E = 0 then 1 else 0 end)*1.0/count(*) as E0_percent_location_buy,
    sum(case when E = 1 then 1 else 0 end)*1.0/count(*) as E1_percent_location_buy,
    -- F
    sum(case when F = 0 then 1 else 0 end) as F0_count_location_buy,
    sum(case when F = 1 then 1 else 0 end) as F1_count_location_buy,
    sum(case when F = 2 then 1 else 0 end) as F2_count_location_buy,
    sum(case when F = 3 then 1 else 0 end) as F3_count_location_buy,
    sum(case when F = 0 then 1 else 0 end)*1.0/count(*) as F0_percent_location_buy,
    sum(case when F = 1 then 1 else 0 end)*1.0/count(*) as F1_percent_location_buy,
    sum(case when F = 2 then 1 else 0 end)*1.0/count(*) as F2_percent_location_buy,
    sum(case when F = 3 then 1 else 0 end)*1.0/count(*) as F3_percent_location_buy,
    -- G
    sum(case when G = 1 then 1 else 0 end) as G1_count_location_buy,
    sum(case when G = 2 then 1 else 0 end) as G2_count_location_buy,
    sum(case when G = 3 then 1 else 0 end) as G3_count_location_buy,
    sum(case when G = 4 then 1 else 0 end) as G4_count_location_buy,
    sum(case when G = 1 then 1 else 0 end)*1.0/count(*) as G1_percent_location_buy,
    sum(case when G = 2 then 1 else 0 end)*1.0/count(*) as G2_percent_location_buy,
    sum(case when G = 3 then 1 else 0 end)*1.0/count(*) as G3_percent_location_buy,
    sum(case when G = 4 then 1 else 0 end)*1.0/count(*) as G4_percent_location_buy
    from
    transactions T1
    where
    record_type = 1
    and
    location <> ''
    group by 1
  ) T2 on (T1.location = T2.location)
) T11 ON T1.location = T11.location, 
-- transactions T2, 
customers T3,
(
  select
  customer_ID,
  count(*) as nb_views,
  count(distinct location) as nb_distinct_location
  from
  transactions
  where
  record_type = 0
  group by 1
) T4,
(
  select
  location,
  count(distinct customer_ID) as location_popularity
  from
  transactions
  group by 1
) T5,
(
  select
  customer_ID,
  max(shopping_pt) as last_view_shopping_pt
  from
  transactions
  group by 1
) T6,
transactions T7,
(
  select
  A.customer_ID,
  max(B.shopping_pt) as min_cost_shopping_pt
  from
  (
    select
    customer_ID,
    min(cost) as min_cost
    from transactions
    where
    record_type = 0
    group by 1
  ) A,
  (
    select
    customer_ID,
    cost,
    shopping_pt
    from transactions
    where
    record_type = 0
  ) B,
  customers C
  where
  A.customer_ID = C.customer_ID
  and
  C.dataset = 'test'
  and
  A.customer_ID = B.customer_ID
  and
  A.min_cost = B.cost
  group by 1
) T8,
transactions T9,
(
  select
  customer_ID,
  count(distinct car_value) as count_distinct_car_value,
  min(cost) as min_cost,
  max(cost) as max_cost,
  avg(cost) as avg_cost,
  sum(case when G = 1 then 1 else 0 end) as G1_count_customer_view,
  sum(case when G = 2 then 1 else 0 end) as G2_count_customer_view,
  sum(case when G = 3 then 1 else 0 end) as G3_count_customer_view,
  sum(case when G = 4 then 1 else 0 end) as G4_count_customer_view,
  sum(case when G = 1 then 1 else 0 end)*1.0/count(*) as G1_percent_customer_view,
  sum(case when G = 2 then 1 else 0 end)*1.0/count(*) as G2_percent_customer_view,
  sum(case when G = 3 then 1 else 0 end)*1.0/count(*) as G3_percent_customer_view,
  sum(case when G = 4 then 1 else 0 end)*1.0/count(*) as G4_percent_customer_view
  from 
  transactions
  where
  record_type = 0
  group by 1
) T10
where
T1.customer_ID = T10.customer_ID
and
T1.customer_ID = T8.customer_ID
and
T8.customer_ID = T9.customer_ID
and
T8.min_cost_shopping_pt = T9.shopping_pt
and
T1.customer_ID = T6.customer_ID
and
T6.customer_ID = T7.customer_ID
and
T6.last_view_shopping_pt = T7.shopping_pt
and
T1.location = T5.location
and
T1.customer_ID = T4.customer_ID
--and
--T1.customer_ID = T2.customer_ID
and
T1.line_number = 1
--and
--T2.record_type = 1
and
T3.dataset = 'test'
and
T1.customer_ID = T3.customer_ID
                     ")
  
  dbDisconnect(con)

  return(data)
}
