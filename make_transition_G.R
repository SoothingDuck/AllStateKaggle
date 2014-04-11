# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data_3.R"))

# transition
get.train.test.transition.G <- function(data, p=.5, debut, fin) {
  set.seed(42)
  
  data <- subset(data, last_G == debut)
  
  trainIndex <- createDataPartition(data$real_G == fin, p = p,
                                    list = FALSE,
                                    times = 1)
  
  train <- data[trainIndex,]
  test <- data[-trainIndex,]
  
  train$y <- with(train, real_G == fin)
  test$y <- with(test, real_G == fin)
  
  train <- train[, ! grepl("real_", colnames(train))]
  test <- test[, ! grepl("real_", colnames(test))]
  
  train <- train[, ! grepl("last_G", colnames(train))]
  test <- test[, ! grepl("last_G", colnames(test))]
  
  train <- train[, ! grepl("percent_transition_F_", colnames(train))]
  test <- test[, ! grepl("percent_transition_F_", colnames(test))]
  
  return(list(train=train, test=test))
  
}

# model trans
result <- data.frame()

p <- .9

for(debut in c(1,2,3,4)) {
  for(fin in c(1,2,3,4)) {
    
    rdata.filename <- file.path("DATA","TRANSITION",paste(paste("transition", debut, "vers", fin, "G", sep = "_"), "csv", sep="."))
    
    cat("Prc train", p, "debut =", debut, "fin =", fin, "\n")
    tmp <- get.train.test.transition.G(data, p=p, debut=debut, fin=fin)
    train_model <- tmp$train
    test_model <- tmp$test
    
    model <- glm(y ~ ., data=train_model, family=binomial)
    
    train_model$predicted_y <- predict(model, newdata=train_model)
    test_model$predicted_y <- predict(model, newdata=test_model)
    
    total.ok.train <- with(train_model, sum(y == (predicted_y > 0)))
    total.ko.train <- with(train_model, sum(y != (predicted_y > 0)))
    
    total.ok.test <- with(test_model, sum(y == (predicted_y > 0)))
    total.ko.test <- with(test_model, sum(y != (predicted_y > 0)))
    
    prc.ko.train=(total.ko.train*100)/(total.ok.train+total.ko.train)
    prc.ko.test=(total.ko.test*100)/(total.ok.test+total.ko.test)
    
    cat("nb.ok.train =", total.ok.train, "nb.ok.test =", total.ok.test,"\n")
    cat("nb.ko.train =", total.ko.train, "nb.ko.test =", total.ko.test,"\n")
    cat("prc.train.error =", prc.ko.train, "prc.test.error =", prc.ko.test,"\n\n")

    cat("Sauvegarde de", rdata.filename, "\n")
    save(model, file=rdata.filename)
  }    
}

write.csv(x=result, file="result_transition_G.csv", row.names = FALSE)
