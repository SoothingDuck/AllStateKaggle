library(ggplot2)

data <- data.frame()

for (letter in c("A","B","C","D","E","F","G")) {
  tmp <- read.csv(file.path("DATA","OUTPUT", paste(paste("result_model", letter, sep="_"), "csv", sep=".")))
  tmp <- tmp[,2:4]
  tmp <- cbind(letter, tmp)
  
  data <- rbind(data, tmp)
}

ggplot(data) + 
  geom_line(aes(x=size.train, y=error.glm.test, color="test")) + 
  geom_line(aes(x=size.train, y=error.glm.train, color="train")) + 
  facet_wrap(~ letter)

