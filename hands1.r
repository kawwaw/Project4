# Hands 
library(ggplot2)
library(reshape2)
setwd("C:/ide2017/opgaver/project4")

handsPCA <- read.table("hands_pca.csv", header = FALSE, sep = ",", dec = ".")
handsPCA$id <- paste0("id",c(1:nrow(handsPCA)))
write.table(handsPCA,"handsPCA.txt", sep = "\t",append = FALSE, col.names = TRUE, row.names = FALSE)

hands <- read.table("hands.csv", header = FALSE, sep = ",", dec = ".")
colnames(hands) <- c(paste0("x",c(1:56)), paste0("y",c(1:56)))



hands$id <- paste0("id",c(1:nrow(hands)))

mhands <- melt(hands, id= c("id"), measure = c(1:112), value.name="Value")
mhands$axis <- substring(mhands$variable,1,1)
mhands$point_nr <- as.numeric(substring(mhands$variable,2))


df <- dcast(mhands, id + point_nr ~ axis, value.var = "Value")
write.table(df,"hands.txt", sep = "\t",append = FALSE, col.names = TRUE, row.names = FALSE)

#p <- ggplot(subset(df,id=="id1"))
p <- ggplot(df)
#p <- p + geom_point(aes(x = x, y = y, group = id) ,stat = "identity")
p <- p + geom_path(aes(x = x, y = y, group = id) ,stat = "identity")
#p <- p + facet_wrap(~ id, ncol = 10, drop = FALSE)	
p