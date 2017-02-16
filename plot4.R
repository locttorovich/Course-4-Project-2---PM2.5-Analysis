#read in data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#find SCC's that contain Coal or combustion
SCC_id <- SCC[grepl(" [Cc]oal",SCC$Short.Name)&grepl("[Cc]omb",SCC$Short.Name),]

#create new file of data on only Coal/Comb SCC's
coal <- subset(NEI, SCC %in% SCC_id$SCC)

#Sum across years
tot <- with(coal, tapply(Emissions, year, sum, na.rm=TRUE))
totdf <- data.frame(Year = as.factor(names(tot)), Emissions = tot)

#scale total emissions for better readability
totdf$Scaled = totdf$Emissions/1000

#plot results by year
png(filename="plot4.png")
bp <- barplot(totdf$Scaled,  xlab = "Year", ylab = "Total PM2.5 Emissions", 
              main = "Total Coal Combustion PM2.5 Emissions Across U.S. by Year\n(Thousands of Tons)",
              col="blue")

dev.off()

#Conclusion: Emissions from coal combustion have declined across the years.  