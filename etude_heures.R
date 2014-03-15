library(RSQLite)

sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
  select
  T2.state,
  T1.*
  from 
  transactions T1,
  customers T2
  where
  T1.customer_ID = T2.customer_ID
  and
  T2.dataset = 'train'
"
)

dbDisconnect(con)

# Affichage
library(ggplot2)

ggplot(subset(data, record_type %in% c(0,1)) + geom_boxplot(aes(x=state, y=cost)) + facet_grid(record_type ~ A)

