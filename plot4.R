## Read the data from the National Emissions Inventory database (NEI)

NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data for 1999, 2002, 2005, and 2008
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Code Table

## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999–2008?

SCC.subset <- subset(SCC, select=c(SCC, Short.Name)) # only relevant cols
NEI.SCC <- merge(NEI, SCC.subset) 
coal.rows <- grepl("coal", NEI.SCC$Short.Name, ignore.case=TRUE) # looking for coal
NEI.coal <- subset(NEI.SCC, coal.rows) # subsetting the relevant NEI data
total.emission <- tapply(NEI.SCC$Emissions, NEI.SCC$year, sum) # counting totals
total.emission <- total.emission / 1000000 # converting to million tons

png(filename = "plot4.png") # opening a PNG device

plot(total.emission, 
     main="Emissions from coal combustion-related sources\nin the US from 1999 to 2008",
     xlab="years", x=c(1999, 2002, 2005, 2008),
     ylab="emissions of PM2.5, in million tons", ylim=c(0,8),
     col="lavenderblush3",
     type="b", pch=19, cex=1.5)

dev.off() # closing the device