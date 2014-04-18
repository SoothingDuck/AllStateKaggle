library(RSQLite)
library(plyr)

csv.filename <- file.path("DATA", "TMP", "glm_train_data.csv")

sqlitedb.filename <- file.path("db", "allstate_data.sqlite3")

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(
  con,
  "
  select
  *
  from data_train_model_glm_first
  "
  )

dbDisconnect(con)

# comptage par location et risk factor
print("Aggregation par location")
data <- ddply(
  data,
  .(location),
  transform,
  A0_location_pct=A0_count/(A0_count+A1_count+A2_count),
  A1_location_pct=A1_count/(A0_count+A1_count+A2_count),
  A2_location_pct=A2_count/(A0_count+A1_count+A2_count)  
)

cat("Ecriture de", csv.filename, "\n")
write.csv(x=data, file=csv.filename, row.names = FALSE)
