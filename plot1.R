#read in data file from working directory
NEI <- readRDS("summarySCC_PM25.rds")

# get total emissions by year
tot <- with(NEI, tapply(Emissions, year, sum, na.rm=TRUE))

#put into data frame
totdf <- data.frame(Year = as.factor(names(tot)), Emissions = tot)

#scale total emissions for better readability
totdf$Scaled = totdf$Emissions/1000

#plot the results
png(filename="plot1.png")

bp <- barplot(totdf$Scaled,  xlab = "Year", ylab = "Total PM2.5 Emissions", 
        main = "Total US PM2.5 Emissions by Year\n(Thousands of Tons)", 
        col="blue")

lines(bp,totdf$Scaled/2, lwd=2, col="red")

print(bp)

dev.off()

#Conclusion: total PM2.5 emissions from all sources have decreased over the 
#years from 1999 - 2008