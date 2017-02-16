#read in data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get Baltimore City and Los Angeles data only
bc <- subset(NEI, fips=="24510")
la <- subset(NEI, fips=="06037")

#get SCC's corresponding to motor vehicles
SCC_id <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE),]

#get only cities data on motor vehicles
vehicles_bc <- subset(bc, SCC %in% SCC_id$SCC)
vehicles_la <- subset(la, SCC %in% SCC_id$SCC)

#Sum across years
totbc <- with(vehicles_bc, tapply(Emissions, year, sum, na.rm=TRUE))
totdfbc <- data.frame(Year = as.factor(names(totbc)), Emissions = totbc, City = "BC")

totla <- with(vehicles_la, tapply(Emissions, year, sum, na.rm=TRUE))
totdfla <- data.frame(Year = as.factor(names(totla)), Emissions = totla, City = "LA")


#merge datasets
merged <- rbind(totdfbc, totdfla)

#plot and send to png
library(ggplot2)

png(filename="plot6.png")

g <- ggplot(data=merged, aes(x=Year, y=Emissions, group=City, color= City, shape=City)) +
    labs(x= "Year", y= "Total PM2.5 Emissions (Tons)", title = "PM2.5 Emissions From Motor Vehicles\n(Los Angeles vs Baltimore City)" ) +
    geom_point(aes(color=City)) +
    geom_smooth(aes(color=City),method="lm") +
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5))

print(g)

dev.off()

#Conclusion: Los Angeles has seen a greater change in motor vehicle polution 
#over time than has Baltimore City - LA has increased, while BC is trending
#lower