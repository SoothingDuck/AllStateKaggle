library(ggplot2)
library(reshape2)

data <- data.frame()

for (letter in c("A","B","C","D","E","F","G")) {
  tmp <- read.csv(file.path("DATA","OUTPUT", paste(paste("result_model", letter, sep="_"), "csv", sep=".")))
  tmp$letter <- letter
  tmp <- tmp[,2:ncol(tmp)]
  tmp <- cbind(letter, tmp)
  
  tmp.bis <- melt(tmp, id.vars=c("size.train","letter"))
  
  data <- rbind(data, tmp.bis)
}

ggplot(subset(data, letter == "G")) + 
  geom_line(aes(x=size.train, y=value, color=variable)) +
  facet_wrap(~ letter)

# next_car_value
data <- data.frame()

tmp <- read.csv(file.path("DATA","OUTPUT", "result_model_next_car_value.csv"))
tmp <- tmp[,2:ncol(tmp)]
  
tmp.bis <- melt(tmp, id.vars=c("size.train"))
  
data <- rbind(data, tmp.bis)

ggplot(data) + 
  geom_line(aes(x=size.train, y=value, color=variable))
