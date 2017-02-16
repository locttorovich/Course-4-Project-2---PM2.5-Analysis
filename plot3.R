#read in data file from working directory
NEI <- readRDS("summarySCC_PM25.rds")

#get Baltimore City data only, sum emissions by type for each year
bc <- filter(NEI, fips=="24510")
tot <- aggregate(Emissions ~ year + type, bc, sum)
tot$year <- as.factor(tot$year)

#plot results
png(filename="plot3.png")

library(ggplot2)

p <- ggplot(tot, aes(year, Emissions))  + 
    geom_bar(stat="identity", fill="blue") + 
    facet_wrap(~type) + 
    ggtitle("Baltimore City Emissions by Measurement Type by Year") + 
    theme(plot.title = element_text(hjust = 0.5),
          panel.background = element_blank(),
          panel.border = element_rect(colour = "black", fill=NA, size=2),
          strip.background = element_blank()) + 
    labs(x="Year",y="Total Emissions (Tons)") 

print(p)

dev.off()

#Conclusion:  all types of emissions were reduced from 1999 levels in 2008, 
# but "Point" measured emissions were increasing from 1999 to 2005, when they
# then dropped significantly