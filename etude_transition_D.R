
# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data_3.R"))

# model trans
result <- data.frame()

for(p in seq(.7, .9, .1)) {
  for(debut in c(1,2,3)) {
    for(fin in c(1,2,3)) {
      cat("Prc train", p, "debut =", debut, "fin =", fin, "\n")
      tmp <- get.train.test.transition.D(data, p=p, debut=debut, fin=fin)
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
      
      result <- rbind(result,
                      data.frame(
                        percent.train=p,
                        debut=debut,
                        fin=fin,
                        ok.train=total.ok.train,
                        ko.train=total.ko.train,
                        ok.test=total.ok.test,
                        ko.test=total.ko.test,
                        prc.ko.train=prc.ko.train,
                        prc.ko.test=prc.ko.test
                      )
      )
    }    
  }
}

write.csv(x=result, file="result_transition_D.csv", row.names = FALSE)
