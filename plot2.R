#read in data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#get Baltimore City data only
bc <- subset(NEI, fips=="24510" )

# get total emissions by year for Baltimore City
tot <- with(bc, tapply(Emissions, year, sum, na.rm=TRUE))

#put into data frame
totdf <- data.frame(Year = as.factor(names(tot)), Emissions = tot)

#scale total emissions for better readability
#totdf$Scaled = totdf$Emissions/1000

#plot the results
png(filename="plot2.png")

bp <- barplot(totdf$Emissions,  xlab = "Year", ylab = "Total PM2.5 Emissions", 
              main = "Total Baltimore City PM2.5 Emissions by Year", 
              col="blue")

lines(bp,totdf$Emissions/2, lwd=2, col="red")

print(bp)

dev.off()

#Conclusion:  despite a bump in 2005, total PM2.5 emissions have decreased 
#in Baltimore City from 1999 to 2008
