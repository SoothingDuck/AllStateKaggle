# fonctions
source(file.path("templates","functions.R"))
source(file.path("templates","get_data_3.R"))

submission.filename <- file.path("DATA", "SUBMISSION", "transition_glm_submission_v1.csv")

# model trans
train.data <- get.data.train()
test.data <- get.data.test()
test.data <- normalize.test.data(test.data)

# estimate G
load.model.transition.A()
load.model.transition.B()
load.model.transition.C()
load.model.transition.D()
load.model.transition.E()
load.model.transition.F()
load.model.transition.G()

# Eval transition vers

test.data <- evaluation.transition.A(test.data)
test.data <- evaluation.transition.B(test.data)
test.data <- evaluation.transition.C(test.data)
test.data <- evaluation.transition.D(test.data)
test.data <- evaluation.transition.E(test.data)
test.data <- evaluation.transition.F(test.data)
test.data <- evaluation.transition.G(test.data)

# ABCDEFG
test.data <- evaluation.prediction.ABCDEFG(test.data)

df <- data.frame(
  customer_ID=rownames(test.data),
  plan=test.data$prediction_ABCDEFG
  )

write.table(df, file = submission.filename, sep=",", row.names = FALSE, quote = FALSE)
