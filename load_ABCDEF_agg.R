library(RSQLite)
library(plyr)
library(reshape2)

# Infos de bases
sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(
  con,
  "
  select
  A || B || C || D || E || F as ABCDEF,
  G,
  count(*) as nb_achat
  from
  transactions
  where
  record_type = 1
  group by 1,2
  "
)

dbDisconnect(con)

# evaluation 

df <- ddply(
  data,
  .(ABCDEF),
  function(x) {
    tmp.1 <- ifelse(any(x$G == 1), x$nb_achat[x$G == 1], 0)
    tmp.2 <- ifelse(any(x$G == 2), x$nb_achat[x$G == 2], 0)
    tmp.3 <- ifelse(any(x$G == 3), x$nb_achat[x$G == 3], 0)
    tmp.4 <- ifelse(any(x$G == 4), x$nb_achat[x$G == 4], 0)
    
    total <- sum(x$nb_achat)
    
    data.frame(
      count_G1=tmp.1,
      count_G2=tmp.2,
      count_G3=tmp.3,
      count_G4=tmp.4,
      percent_G1=tmp.1/total,
      percent_G2=tmp.2/total,
      percent_G3=tmp.3/total,
      percent_G4=tmp.4/total
      )
  }
)

# Ecriture
drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

print("Alimentation table transactions...")
dbWriteTable(con, "ABCDEF_agg", df)

dbDisconnect(con)
