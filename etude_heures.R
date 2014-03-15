library(RSQLite)

sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
  select
  T2.state,
  T1.*,
  T3.cost as final_cost
  from 
  transactions T1,
  customers T2,
  transactions T3
  where
  T1.customer_ID = T2.customer_ID
  and
  T2.dataset = 'train'
  and
  T1.record_type = 0
  and
  T1.customer_ID = T3.customer_ID
  and
  T3.record_type = 1
"
)

dbDisconnect(con)

# Affichage
library(ggplot2)

ggplot(subset(data, record_type %in% c(0,1) & cost < 700 & cost > 500)) + geom_boxplot(aes(x=state, y=cost)) + facet_grid(record_type ~ G)

# Comparaison cout vu - cout final
ggplot(data) + geom_point(aes(x=cost, y=final_cost)) + facet_grid(car_value~G)
