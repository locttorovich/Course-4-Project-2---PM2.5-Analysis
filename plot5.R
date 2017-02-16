#read in data files from working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get Baltimore City data only
bc <- subset(NEI, fips=="24510" )

#get SCC's corresponding to motor vehicles
SCC_id <- SCC[grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE),]

#get only bc data on motor vehicles
vehicles <- subset(bc, SCC %in% SCC_id$SCC)

#Sum across years
tot <- with(vehicles, tapply(Emissions, year, sum, na.rm=TRUE))
totdf <- data.frame(Year = as.factor(names(tot)), Emissions = tot)

#plot results by year
png(filename="plot5.png")
bp <- barplot(totdf$Emissions,  xlab = "Year", ylab = "Total PM2.5 Emissions", 
              main = "Total Vehicle PM2.5 Emissions Across Baltimore City\nby Year (Tons)",
              col="blue")

dev.off()

#Conclusion: total emissions across Baltimore City from vehicles have decreased
# almost 75% since 1999