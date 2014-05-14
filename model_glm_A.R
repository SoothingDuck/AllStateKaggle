source("reboot_data.R")

indices <- sample(1:nrow(data.train.normalized), 5000)
data.train.normalized.5000 <- data.train.normalized[indices,]

model.A.0 <- glm(I(real_A == "0") ~ ., data=data.train.normalized.5000, family=binomial)
anova.model.A.0 <- anova(model.A.0)

model.A.1 <- glm(I(real_A == "1") ~ ., data=data.train.normalized.5000, family=binomial)
anova.model.A.1 <- anova(model.A.1)

model.A.2 <- glm(I(real_A == "2") ~ ., data=data.train.normalized.5000, family=binomial)
anova.model.A.2 <- anova(model.A.2)
