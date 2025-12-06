rm(list=ls())

library(ggplot2)

# This file contains a simple example for running a script on Midway, the Chicago computing cluster
# This could be any R file that uses data in the same 

#read in dataset
dat <- read.csv(file="test-data.csv", header = T, stringsAsFactors = F)

#plot 

p1 <- ggplot(data=dat) + geom_line(aes(x=year, y=count, color=animal), size=1) + theme_bw()

#and save

ggsave(file="test-plot.png",
       plot = p1,
       scale = .5, 
       width = 40,
       height = 45,
       units="cm",
       dpi=300)
