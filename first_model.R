library(caret)
library(RSQLite)

sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
select 
T1.customer_ID,
T3.state,
T1.day as first_day,
T2.day as last_day,
T1.A as first_A,
T2.A as last_A
from
transactions T1, transactions T2, customers T3
where
T1.customer_ID = T2.customer_ID
and
T1.line_number = 1
and
T2.record_type = 1
and
T3.dataset = 'train'
and
T1.customer_ID = T3.customer_ID
")

dbDisconnect(con)

# Modele
data$customer_ID <- as.character(data$customer_ID)
data$state <- factor(data$state)
data$first_day <- factor(data$first_day)
data$last_day <- factor(data$last_day)
data$first_A <- factor(data$first_A)
data$last_A <- factor(data$last_A)

model <- glm(
  last_A ~ 
    . 
  - customer_ID - state
  + I(first_day == last_day)
  , family = binomial, data=data)
