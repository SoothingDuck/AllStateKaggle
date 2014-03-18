library(RSQLite)

# Location communes test et train
sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
select
T2.location,
count(distinct T1.state) as nb_distinct_state,
count(distinct T2.customer_ID) as nb_distinct_customer_ID
from
customers T1,
transactions T2
where
T1.customer_ID = T2.customer_ID
and
T1.dataset = 'train'
group by 1
having nb_distinct_state > 1
order by 3 desc
"
)

dbDisconnect(con)

