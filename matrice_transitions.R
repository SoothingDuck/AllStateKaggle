library(RSQLite)

sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
select
T1.location,
T1.G1_count_location_view,
T1.G2_count_location_view,
T1.G3_count_location_view,
T1.G4_count_location_view,
T1.G1_percent_location_view,
T1.G2_percent_location_view,
T1.G3_percent_location_view,
T1.G4_percent_location_view,
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
  sum(case when G = 1 then 1 else 0 end) as G1_count_location_view,
  sum(case when G = 2 then 1 else 0 end) as G2_count_location_view,
  sum(case when G = 3 then 1 else 0 end) as G3_count_location_view,
  sum(case when G = 4 then 1 else 0 end) as G4_count_location_view,
  sum(case when G = 1 then 1 else 0 end)*1.0/count(*) as G1_percent_location_view,
  sum(case when G = 2 then 1 else 0 end)*1.0/count(*) as G2_percent_location_view,
  sum(case when G = 3 then 1 else 0 end)*1.0/count(*) as G3_percent_location_view,
  sum(case when G = 4 then 1 else 0 end)*1.0/count(*) as G4_percent_location_view,
  count(*) as total_location_view
  from
  transactions T1
  where
  record_type = 0
  and
  location <> ''
  group by 1
) T1 inner join
(
  select
  location,
  sum(case when G = 1 then 1 else 0 end) as G1_count_location_buy,
  sum(case when G = 2 then 1 else 0 end) as G2_count_location_buy,
  sum(case when G = 3 then 1 else 0 end) as G3_count_location_buy,
  sum(case when G = 4 then 1 else 0 end) as G4_count_location_buy,
  sum(case when G = 1 then 1 else 0 end)*1.0/count(*) as G1_percent_location_buy,
  sum(case when G = 2 then 1 else 0 end)*1.0/count(*) as G2_percent_location_buy,
  sum(case when G = 3 then 1 else 0 end)*1.0/count(*) as G3_percent_location_buy,
  sum(case when G = 4 then 1 else 0 end)*1.0/count(*) as G4_percent_location_buy,
  count(*) as total_location_buy
  from
  transactions T1
  where
  record_type = 1
  and
  location <> ''
  group by 1
) T2 on (T1.location = T2.location)
"
)

dbDisconnect(con)

