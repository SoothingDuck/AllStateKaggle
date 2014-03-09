library(RSQLite)
library(ggplot2)

sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
select
T2.state,
T1.location,
count(distinct T1.customer_ID) as nb_cust
from transactions T1, customers T2
where
T1.customer_ID = T2.customer_ID
group by 1,2
")

dbDisconnect(con)

# Hist
ggplot(data) + geom_histogram(aes(x=nb_cust, fill=state), binwidth=5)

# G
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
                   "
select
A,B,C,D,E,F,G, count(*) as nb_app
from transactions
where
record_type = 1
group by 1,2,3,4,5,6,7
                   ")

dbDisconnect(con)


