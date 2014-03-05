library(caret)
library(randomForest)
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
T4.nb_views,
T1.A as first_A,
T2.A as last_A
from
transactions T1, transactions T2, customers T3,
(
  select
  customer_ID,
  count(*) as nb_views
  from
  transactions
  group by 1
) T4
where
T1.customer_ID = T4.customer_ID
and
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

# Normalisation des données
rownames(data) <- as.character(data$customer_ID)
data <- data[,-c(1)]
data$state <- factor(data$state)
data$first_day <- factor(data$first_day)
data$last_day <- factor(data$last_day)
data$first_A <- factor(data$first_A)
data$last_A <- factor(data$last_A)

# Separation train, test
trainIndex <- createDataPartition(data$last_A, p = .8,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
dataTest <- data[-trainIndex,]

# Evaluation modeles
model_0 <- glm(
  I(last_A == "0") ~ . 
  + I(first_day == last_day)
  , family = binomial, data=dataTrain)

model_1 <- glm(
  I(last_A == "1") ~ . 
  + I(first_day == last_day)
  , family = binomial, data=dataTrain)

model_2 <- glm(
  I(last_A == "2") ~  . 
  + I(first_day == last_day)
  , family = binomial, data=dataTrain)

model_rf <- randomForest(
  last_A ~ . - state
  + I(first_day == last_day),
  data=dataTrain,
  importance=TRUE,
  do.trace=TRUE
  )

dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)

dataTest$predicted_glm_A <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1)

prediction_error <- function(true_data, predicted_data) {
  
  ok_prediction <- sum(true_data == predicted_data)
  ko_prediction <- sum(true_data != predicted_data)
  
  return ((ko_prediction)/(ok_prediction+ko_prediction))
}

print(prediction_error(dataTest$last_A, dataTest$predicted_glm_A))
