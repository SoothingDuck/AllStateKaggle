library(RSQLite)
library(plyr)

sqlitedb.filename <- "allstate_data.sqlite3"
unlink(sqlitedb.filename)

print("Chargement données Train...")
train.data <- read.table("DATA/train.csv", header=TRUE, sep = ",", stringsAsFactors=FALSE)
train.data$dataset <- "train"

print("Chargement données Test...")
test.data <- read.table("DATA/test_v2.csv", header=TRUE, sep = ",", stringsAsFactors=FALSE)
test.data$dataset <- "test"

print("Concaténation des données Train et Test...")
all.data <- rbind(train.data, test.data)

print("Tri des données")
all.data <- all.data[order(all.data$customer_ID, all.data$shopping_pt),]

print("Ajout de ordre ligne")
all.data <- ddply(all.data,
                  .(customer_ID),
                  transform,
                  line_number=1:(length(customer_ID))
                  )

# [1] "customer_ID"       "shopping_pt"       "record_type"      
# [4] "day"               "time"              "state"            
# [7] "location"          "group_size"        "homeowner"        
# [10] "car_age"           "car_value"         "risk_factor"      
# [13] "age_oldest"        "age_youngest"      "married_couple"   
# [16] "C_previous"        "duration_previous" "A"                
# [19] "B"                 "C"                 "D"                
# [22] "E"                 "F"                 "G"                
# [25] "cost"              "dataset"          

customer_columns <- c(
  "customer_ID",
  "state",
  "dataset"
  )

transactions_columns <- c(
  "customer_ID",
  "shopping_pt",
  "record_type",
  "day",
  "time",
  "location",
  "group_size",
  "homeowner",
  "car_age",
  "car_value",
  "risk_factor",
  "age_oldest",
  "age_youngest",
  "married_couple",
  "C_previous",
  "duration_previous",
  "A",
  "B",
  "C",
  "D",
  "E",
  "F",
  "G",
  "cost",
  "line_number"
  )

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

print("Alimentation table transactions...")
dbWriteTable(con, "transactions", all.data[,transactions_columns])
print("Alimentation table customers...")
dbWriteTable(con, "customers", unique(all.data[,customer_columns]))

print("Creation des indexes...")
dbGetQuery(con, "create unique index ix_customers_customer_id on customers ( customer_ID)")
dbGetQuery(con, "create index ix_transactions_customer_id on transactions ( customer_ID)")

dbDisconnect(con)
