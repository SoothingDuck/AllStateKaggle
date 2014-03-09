library(RSQLite)
library(stringr)


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
  case
    when T5.location_popularity is null then 0
    else T5.location_popularity
  end as location_popularity,
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
  when T1.duration_previous is null then 'Not available'
  else T1.duration_previous || ''
  end as first_view_duration_previous,
  case
  when T7.duration_previous is null then 'Not available'
  else T7.duration_previous || ''
  end as last_view_duration_previous,
  case
  when T9.duration_previous is null then 'Not available'
  else T9.duration_previous || ''
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
  T9.G as min_cost_view_G
  -- T1.A || T1.B || T1.C || T1.D || T1.E || T1.F as first_view_ABCDEF,
  -- T7.A || T7.B || T7.C || T7.D || T7.E || T7.F as last_view_ABCDEF,
  -- T9.A || T9.B || T9.C || T9.D || T9.E || T9.F as min_cost_view_ABCDEF
  from
  transactions T1 left outer join
  (
  select
  location,
  count(distinct customer_ID) as location_popularity
  from
  transactions
  group by 1
  ) T5 on T1.location = T5.location
  , customers T3,
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
  transactions T9
  where
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
  --and
  --T1.location = T5.location
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


get.data.train <- function() {
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
  when T1.duration_previous is null then 'Not available'
  else T1.duration_previous || ''
  end as first_view_duration_previous,
  case
  when T7.duration_previous is null then 'Not available'
  else T7.duration_previous || ''
  end as last_view_duration_previous,
  case
  when T9.duration_previous is null then 'Not available'
  else T9.duration_previous || ''
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
  T2.A as real_A,
  T2.B as real_B,
  T2.C as real_C,
  T2.D as real_D,
  T2.E as real_E,
  T2.F as real_F,
  T2.G as real_G
  --T1.A || T1.B || T1.C || T1.D || T1.E || T1.F as first_view_ABCDEF,
  --T7.A || T7.B || T7.C || T7.D || T7.E || T7.F as last_view_ABCDEF,
  --T9.A || T9.B || T9.C || T9.D || T9.E || T9.F as min_cost_view_ABCDEF,
  --T2.A || T2.B || T2.C || T2.D || T2.E || T2.F as real_ABCDEF
  from
  transactions T1, transactions T2, customers T3,
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
  case
  when max(shopping_pt) = 1 then 1
  else max(shopping_pt)-1
  end as last_view_shopping_pt
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
    C.dataset = 'train'
    and
    A.customer_ID = B.customer_ID
    and
    A.min_cost = B.cost
    group by 1
  ) T8,
  transactions T9
  where
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
  and
  T1.customer_ID = T2.customer_ID
  and
  T1.line_number = 1
  and
  T2.record_type = 1
  and
  T3.dataset = 'train'
  and
  T1.customer_ID = T3.customer_ID
                     ")
  
  dbDisconnect(con)

  return(data)
}

normalize.data <- function(data) {
  rownames(data) <- as.character(data$customer_ID)
  data <- data[,colnames(data) != "customer_ID"]
  
  # state factor
  data$state <- factor(data$state)
  
  # day
  # data$first_view_day <- factor(data$first_view_day)
  data$last_view_day <- factor(data$last_view_day)
  # data$min_cost_view_day <- factor(data$min_cost_view_day)
  
  # time
  data$first_view_hour <- as.numeric(str_sub(data$first_view_time, 0, 2))
  data$minutes_elapsed <- (as.numeric(str_sub(data$last_view_time, 0, 2))*60 + as.numeric(str_sub(data$last_view_time, 4, 6))) - (as.numeric(str_sub(data$first_view_time, 0, 2))*60 + as.numeric(str_sub(data$first_view_time, 4, 6)))
  data <- data[,! colnames(data) %in% c("first_view_time","last_view_time","min_cost_view_time")]
  
  # homeowner
  data$first_view_homeowner <- factor(ifelse(data$first_view_homeowner == 1, "Yes", "No"))
  data$last_view_homeowner <- factor(ifelse(data$last_view_homeowner == 1, "Yes", "No"))
  data$min_cost_view_homeowner <- factor(ifelse(data$min_cost_view_homeowner == 1, "Yes", "No"))
  
  # car_value
  data$first_view_car_value <- factor(data$first_view_car_value)
  data$last_view_car_value <- factor(data$last_view_car_value)
  data$min_cost_view_car_value <- factor(data$min_cost_view_car_value)
  
  # risk_factor
  data$first_view_risk_factor <- factor(data$first_view_risk_factor)
  data$last_view_risk_factor <- factor(data$last_view_risk_factor)
  data$min_cost_view_risk_factor <- factor(data$min_cost_view_risk_factor)
  
  # married_couple
  data$first_view_married_couple <- factor(ifelse(data$first_view_married_couple == 1, "Yes", "No"))
  data$last_view_married_couple <- factor(ifelse(data$last_view_married_couple == 1, "Yes", "No"))
  data$min_cost_view_married_couple <- factor(ifelse(data$min_cost_view_married_couple == 1, "Yes", "No"))
  
  # C_previous
  data$first_view_C_previous <- factor(data$first_view_C_previous)
  data$last_view_C_previous <- factor(data$last_view_C_previous)
  data$min_cost_view_C_previous <- factor(data$min_cost_view_C_previous)
  
  # duration_previous
  # data$first_view_duration_previous <- factor(data$first_view_duration_previous)
  # data$last_view_duration_previous <- factor(data$last_view_duration_previous)
  # data$min_cost_view_duration_previous <- factor(data$min_cost_view_duration_previous)
  
  # A
  data$first_view_A <- factor(data$first_view_A)
  data$last_view_A <- factor(data$last_view_A)
  data$min_cost_view_A <- factor(data$min_cost_view_A)
  
  # B
  data$first_view_B <- factor(data$first_view_B)
  data$last_view_B <- factor(data$last_view_B)
  data$min_cost_view_B <- factor(data$min_cost_view_B)
  
  # C
  data$first_view_C <- factor(data$first_view_C)
  data$last_view_C <- factor(data$last_view_C)
  data$min_cost_view_C <- factor(data$min_cost_view_C)
  
  # D
  data$first_view_D <- factor(data$first_view_D)
  data$last_view_D <- factor(data$last_view_D)
  data$min_cost_view_D <- factor(data$min_cost_view_D)
  
  # E
  data$first_view_E <- factor(data$first_view_E)
  data$last_view_E <- factor(data$last_view_E)
  data$min_cost_view_E <- factor(data$min_cost_view_E)
  
  # F
  data$first_view_F <- factor(data$first_view_F)
  data$last_view_F <- factor(data$last_view_F)
  data$min_cost_view_F <- factor(data$min_cost_view_F)
  
  # G
  data$first_view_G <- factor(data$first_view_G)
  data$last_view_G <- factor(data$last_view_G)
  data$min_cost_view_G <- factor(data$min_cost_view_G)
  
  # ABCDEF
  # data$first_view_ABCDEF <- factor(data$first_view_ABCDEF)
  # data$last_view_ABCDEF <- factor(data$last_view_ABCDEF)
  # data$min_cost_view_ABCDEF <- factor(data$min_cost_view_ABCDEF)
  
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

  # data$real_ABCDEF <- factor(data$real_ABCDEF)
  
  return(data)
}

normalize.test.data <- function(data) {
  
  data <- normalize.data(data)
  
  return(data)
  
}

# Préparation des données
data <- get.data.train()
data <- normalize.train.data(data)

# functions
select.final.variable <- function(data, letter) {
  col <- ! (grepl("real",colnames(data)) & ! grepl(paste("real",letter, sep="_"), colnames(data)))
  return(data[,col])
}

