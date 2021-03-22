Census.Data <-read.csv("Censusdata.csv") #  data stored as Comma Separated Values (.csv) file
summary(Census.Data)
library("ggplot2")     
library("rgdal")     
library("rgeos")

Output.Areas<- readOGR(".", "Camden_oa11")

plot(Output.Areas)  

OA.Census <- merge(Output.Areas, Census.Data, by.x="OA11CD", by.y="OA") 
library(tmap)
library(leaflet)

qtm(OA.Census, fill = "Unemployed") 

tm_shape(OA.Census) + tm_fill("Unemployed")
library(RColorBrewer)
display.brewer.all()

tm_shape(OA.Census) + tm_fill("Unemployed", style = "quantile", palette = "Purples")

tm_shape(OA.Census) + tm_fill("Unemployed", style = "quantile", n = 7, palette = "Purples")

tm_shape(OA.Census) + tm_fill("Unemployed", palette = "Purples", style = "quantile", title = "% with a Unemployed") +tm_borders(alpha=.4)  +tm_compass()  +tm_layout(title = "Camden, London", legend.text.size = 1.1, legend.title.size = 1.4, legend.position = c("right", "top"), frame = FALSE)


houses <- read.csv("Camdenhouse15.csv")
houses <- houses[,c(1,2,8,9)]
plot(houses$oseast1m, houses$osnrth1m)
library("sp")

House.Points <-SpatialPointsDataFrame(houses[,3:4], houses, proj4string = CRS("+init=EPSG:27700"))

tm_shape(OA.Census) + tm_borders(alpha=.4)

tm_shape(OA.Census) + tm_borders(alpha=.4) +tm_shape(House.Points) + tm_dots(col = "Price", palette = "Reds", style = "quantile")

tm_shape(OA.Census) + tm_borders(alpha=.4) +tm_shape(House.Points) + tm_bubbles(size = "Price", col = "Price", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "Price Paid (£)") + tm_layout(legend.text.size = 1.1, legend.title.size = 1.4, frame = FALSE)

tm_shape(OA.Census) + tm_fill("Qualification", palette = "Reds", style = "quantile", title = "% Qualification") + tm_borders(alpha=.4) +tm_shape(House.Points) + tm_bubbles(size = "Price", col = "Price", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "Price Paid (£)", border.col = "black", border.lwd = 0.1, border.alpha = 0.1) +tm_layout(legend.text.size = 0.8, legend.title.size = 1.1, frame = FALSE)

tm_shape(OA.Census) + tm_fill("Unemployed", palette = "Reds", style = "quantile", title = "% Unemployed") + tm_borders(alpha=.4) +tm_shape(House.Points) + tm_bubbles(size = "Price", col = "Price", palette = "Blues", style = "quantile", legend.size.show = FALSE, title.col = "Price Paid (£)", border.col = "black", border.lwd = 0.1, border.alpha = 0.1) +tm_layout(legend.text.size = 0.8, legend.title.size = 1.1, frame = FALSE)