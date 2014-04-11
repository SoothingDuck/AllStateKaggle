library(ggplot2)

result <- read.csv(file="result_transition_G.csv")

ggplot(result) + 
  geom_line(aes(x=percent.train, y=prc.ko.train, color="train")) + 
  geom_line(aes(x=percent.train, y=prc.ko.test, color="test")) + 
  facet_grid(debut ~ fin)
