# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data_3.R"))

# model trans
p <- .9

trainIndex <- createDataPartition(data$state, p = p,
                                  list = FALSE,
                                  times = 1)

train.data=data[trainIndex,]
test.data=data[-trainIndex,]

# estimate G
load.model.transition.A()
load.model.transition.B()
load.model.transition.C()
load.model.transition.D()
load.model.transition.E()
load.model.transition.F()
load.model.transition.G()

# Eval transition vers

train.data <- evaluation.transition.A(train.data)
test.data <- evaluation.transition.A(test.data)
train.data.error <- with(train.data, sum(real_A != prediction_A))
test.data.error <- with(test.data, sum(real_A != prediction_A))
cat("Error Train A :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test A :", (test.data.error*100)/nrow(test.data), "\n")

train.data <- evaluation.transition.B(train.data)
test.data <- evaluation.transition.B(test.data)
train.data.error <- with(train.data, sum(real_B != prediction_B))
test.data.error <- with(test.data, sum(real_B != prediction_B))
cat("Error Train B :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test B :", (test.data.error*100)/nrow(test.data), "\n")

train.data <- evaluation.transition.C(train.data)
test.data <- evaluation.transition.C(test.data)
train.data.error <- with(train.data, sum(real_C != prediction_C))
test.data.error <- with(test.data, sum(real_C != prediction_C))
cat("Error Train C :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test C :", (test.data.error*100)/nrow(test.data), "\n")

train.data <- evaluation.transition.D(train.data)
test.data <- evaluation.transition.D(test.data)
train.data.error <- with(train.data, sum(real_D != prediction_D))
test.data.error <- with(test.data, sum(real_D != prediction_D))
cat("Error Train D :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test D :", (test.data.error*100)/nrow(test.data), "\n")

train.data <- evaluation.transition.E(train.data)
test.data <- evaluation.transition.E(test.data)
train.data.error <- with(train.data, sum(real_E != prediction_E))
test.data.error <- with(test.data, sum(real_E != prediction_E))
cat("Error Train E :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test E :", (test.data.error*100)/nrow(test.data), "\n")

train.data <- evaluation.transition.F(train.data)
test.data <- evaluation.transition.F(test.data)
train.data.error <- with(train.data, sum(real_F != prediction_F))
test.data.error <- with(test.data, sum(real_F != prediction_F))
cat("Error Train F :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test F :", (test.data.error*100)/nrow(test.data), "\n")

train.data <- evaluation.transition.G(train.data)
test.data <- evaluation.transition.G(test.data)
train.data.error <- with(train.data, sum(real_G != prediction_G))
test.data.error <- with(test.data, sum(real_G != prediction_G))
cat("Error Train G :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test G :", (test.data.error*100)/nrow(test.data), "\n")

# ABCDEFG
train.data <- evaluation.real.ABCDEFG(train.data)
test.data <- evaluation.real.ABCDEFG(test.data)
train.data <- evaluation.prediction.ABCDEFG(train.data)
test.data <- evaluation.prediction.ABCDEFG(test.data)

train.data.error <- with(train.data, sum(real_ABCDEFG != prediction_ABCDEFG))
test.data.error <- with(test.data, sum(real_ABCDEFG != prediction_ABCDEFG))
cat("Error Train ABCDEFG :", (train.data.error*100)/nrow(train.data), "\n")
cat("Error Test ABCDEFG :", (test.data.error*100)/nrow(test.data), "\n")
cat("OK Train ABCDEFG :", ((nrow(train.data)-train.data.error)*100)/nrow(train.data), "\n")
cat("OK Test ABCDEFG :", ((nrow(test.data)-test.data.error)*100)/nrow(test.data), "\n")

