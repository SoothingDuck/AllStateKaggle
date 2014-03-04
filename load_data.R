library(RSQLite)
library(plyr)




sqlitedb.filename <- "allstate_data.sqlite3"
unlink(sqlitedb.filename)

train.data <- read.table("DATA/train.csv", header=TRUE, sep = ",", stringsAsFactors=FALSE)
train.data$dataset <- "train"


t <- ddply(
  train.data,
  .(customer_ID),
  summarise,
  toto = length(unique(location))
  )

test.data <- read.table("DATA/test_v2.csv", header=TRUE, sep = ",", stringsAsFactors=FALSE)
test.data$dataset <- "test"

all.data <- rbind(train.data, test.data)

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

dbWriteTable(con, "transactions", train.data)

dbGetQuery(con, "select count(*) from transactions")[1,]

t <- dbGetQuery(con, "select customer_ID, state, count(distinct location) as nb_loc from transactions group by customer_ID,state")
u <- dbGetQuery(con, "select customer_ID, count(distinct group_size) as nb_group from transactions group by customer_ID")

dbGetQuery(con, "schema transactions")

dbDisconnect(con)
