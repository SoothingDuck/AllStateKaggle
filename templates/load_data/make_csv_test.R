library(RSQLite)
library(plyr)

csv.filename.train <- file.path("DATA", "TMP", "glm_train_data.csv")
csv.filename.test <- file.path("DATA", "TMP", "glm_test_data.csv")

# train
data.train <- read.csv(file=csv.filename.train)

agg.location <- data.train[, c("location", "A0_location_pct", "A1_location_pct", "A2_location_pct")]
agg.location <- unique(agg.location)

# test get
sqlitedb.filename <- file.path("db", "allstate_data.sqlite3")

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data.test <- dbGetQuery(
  con,
  "
  select
  *
  from data_test_model_glm_first
  "
  )

dbDisconnect(con)

# comptage par location et risk factor
tmp <- merge(data.test, agg.location, by="location", all.x = TRUE)

cat("Ecriture de", csv.filename, "\n")
write.csv(x=data, file=csv.filename, row.names = FALSE)
