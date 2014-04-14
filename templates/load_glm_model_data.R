library(RSQLite)

sqlitedb.filename <- file.path("db", "allstate_data.sqlite3")

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)


dbDisconnect(con)
