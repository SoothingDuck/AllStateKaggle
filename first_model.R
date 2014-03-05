library(caret)
library(randomForest)
library(RSQLite)
library(stringr)

sqlitedb.filename <- "allstate_data.sqlite3"

drv <- dbDriver("SQLite")
con <- dbConnect(drv, dbname=sqlitedb.filename)

data <- dbGetQuery(con,
"
select 
T1.customer_ID,
T3.state,
T1.day as first_view_day,
T2.day as last_view_day,
T1.time as first_view_time,
T7.time as last_view_time,
T4.nb_views,
-- T1.location as first_view_location,
T5.location_popularity,
T1.group_size as first_view_group_size,
T1.homeowner as first_view_homeowner,
T1.car_age as first_view_car_age,
T1.car_value as first_view_car_value,
-- T1.risk_factor as first_view_risk_factor,
T1.age_oldest as first_view_age_oldest,
T1.age_youngest as first_view_age_youngest,
T1.married_couple as first_view_married_couple,
-- T1.C_previous as first_view_C_previous,
-- T1.duration_previous as first_view_duration_previous,
T1.A as first_view_A,
T7.A as last_view_A,
T2.A as real_A
from
transactions T1, transactions T2, customers T3,
(
  select
  customer_ID,
  count(*) as nb_views
  from
  transactions
  where
  record_type = 0
  group by 1
) T4,
(
  select
  location,
  count(distinct customer_ID) as location_popularity
  from
  transactions
  group by 1
) T5,
(
  select
  customer_ID,
  case
    when max(shopping_pt) = 1 then 1
    else max(shopping_pt)-1
  end as last_view_shopping_pt
  from
  transactions
  group by 1
) T6,
transactions T7
where
T1.customer_ID = T6.customer_ID
and
T6.customer_ID = T7.customer_ID
and
T6.last_view_shopping_pt = T7.shopping_pt
and
T1.location = T5.location
and
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

# Préparation des données
print("Prépartion des données")
rownames(data) <- as.character(data$customer_ID)
data <- data[,colnames(data) != "customer_ID"]
data$state <- factor(data$state)
data$first_view_day <- factor(data$first_view_day)
data$last_view_day <- factor(data$last_view_day)

data$first_view_hour <- as.numeric(str_sub(data$first_view_time, 0, 2))
data$minutes_elapsed <- ifelse(
  data$first_view_day == data$last_view_day,
  (as.numeric(str_sub(data$last_view_time, 0, 2))*60 + as.numeric(str_sub(data$last_view_time, 4, 6))) -  
  (as.numeric(str_sub(data$first_view_time, 0, 2))*60 + as.numeric(str_sub(data$first_view_time, 4, 6))),
  60*60*24
  )

data <- data[,! colnames(data) %in% c("first_view_time","last_view_time")]

data$first_view_A <- factor(data$first_view_A)
data$last_view_A <- factor(data$last_view_A)
data$first_view_homeowner <- factor(ifelse(data$first_view_homeowner == 1, "Yes", "No"))
data$first_view_car_value <- factor(data$first_view_car_value)
data$first_view_married_couple <- factor(ifelse(data$first_view_married_couple == 1, "Yes", "No"))

# Separation train, test
trainIndex <- createDataPartition(data$last_view_A, p = .8,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
dataTest <- data[-trainIndex,]


# Estimation modeles
prediction_error <- function(true_data, predicted_data) {
  
  ok_prediction <- sum(true_data == predicted_data)
  ko_prediction <- sum(true_data != predicted_data)
  
  return ((ko_prediction)/(ok_prediction+ko_prediction))
}

list_prob <- seq(.2, .8, .1)

list_prob <- c(.8)

result <- data.frame()

for(prob in list_prob) {
  
cat("Taille train : ", prob, "\n")

trainIndex <- createDataPartition(data$last_view_A, p = prob,
                                  list = FALSE,
                                  times = 1)

dataTrain <- data[trainIndex,]
  
# Evaluation modeles

model_0 <- glm(
  I(last_view_A == "0") ~ . 
  
  + I(first_view_day == last_view_day)
  , family = binomial, data=dataTrain)

model_1 <- glm(
  I(last_view_A == "1") ~ . 
  + I(first_view_day == last_view_day)
  , family = binomial, data=dataTrain)

model_2 <- glm(
  I(last_view_A == "2") ~  . 
  + I(first_view_day == last_view_day)
  , family = binomial, data=dataTrain)

# model_rf <- randomForest(
#   last_view_A ~ . - state
#   + I(first_view_day == last_view_day),
#   data=dataTrain,
#   importance=TRUE,
#   do.trace=TRUE,
#   ntree=20
#   )

dataTest$predict_glm_0 <- predict(model_0, newdata=dataTest)
dataTest$predict_glm_1 <- predict(model_1, newdata=dataTest)
dataTest$predict_glm_2 <- predict(model_2, newdata=dataTest)

dataTest$predicted_glm_A <- factor(max.col(dataTest[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1)
# dataTest$predicted_rf_A <- predict(model_rf, newdata=dataTest)

dataTrain$predict_glm_0 <- predict(model_0, newdata=dataTrain)
dataTrain$predict_glm_1 <- predict(model_1, newdata=dataTrain)
dataTrain$predict_glm_2 <- predict(model_2, newdata=dataTrain)

dataTrain$predicted_glm_A <- factor(max.col(dataTrain[,c("predict_glm_0","predict_glm_1", "predict_glm_2")])-1)


print("Error GLM :")
print(prediction_error(dataTest$last_view_A, dataTest$predicted_glm_A))

# print("Error RF :")
# print(prediction_error(dataTest$last_view_A, dataTest$predicted_rf_A))

result <- rbind(result, data.frame(
  size.train=prob, 
  error.glm.test=prediction_error(dataTest$last_view_A, dataTest$predicted_glm_A),
  error.glm.train=prediction_error(dataTrain$last_view_A, dataTrain$predicted_glm_A)
)
)
  
}
