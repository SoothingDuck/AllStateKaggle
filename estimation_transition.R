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

train.data <- evaluation.transition.G(train.data)
test.data <- evaluation.transition.G(test.data)

