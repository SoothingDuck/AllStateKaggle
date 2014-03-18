source("get_raw_data.R")

library(ggplot2)

# All state
ggplot(data) + geom_histogram(aes(x=hour,colour=G_final), binwidth=.5, position="stack") + facet_wrap(~state)
ggplot(subset(data, state %in% c("FL","NY","OH","PA"))) + geom_histogram(aes(x=hour,colour=G), binwidth=.5, position="stack") + facet_wrap(~state)


ggplot(data) + geom_density(aes(x=hour,colour=G_final), binwidth=.5, position="stack") + facet_wrap(~state)
ggplot(subset(data, state %in% c("FL","NY","OH","PA"))) + geom_density(aes(x=hour,colour=G), binwidth=.5, position="stack") + facet_wrap(~state)
