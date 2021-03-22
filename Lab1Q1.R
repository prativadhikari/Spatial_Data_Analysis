#check
mm<-read.table("RainIowa.txt")

library(maps) 

summary(mm)

plot(mm$Lon,mm$Lat, xlim=c(-97,-90),ylim=c(40, 43), xlab="Longitude",  ylab="Latitude", main="Locations in Iowa", "n")  

map("county", "io",add=TRUE) 

rain.colors <- c("yellow", "orange", "red", "green", "black")
rain.levels <- cut(mm$mm, c(700, 770, 789.25, 908.50, 975.75, 1043))
as.numeric(rain.levels)

points(mm$Lon, mm$Lat, cex=mm$mm/mean(mm$mm),  col=rain.colors[as.numeric(rain.levels)], pch=19)


Census.Data <-read.csv("Censusdata.csv") #  data stored as Comma Separated Values (.csv) file
summary(Census.Data)
library("ggplot2")     
library("rgdal")     
library("rgeos")

Output.Areas<- readOGR(".", "Camden_oa11")

plot(Output.Areas)  