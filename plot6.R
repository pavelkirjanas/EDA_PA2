## Read the data from the National Emissions Inventory database (NEI)

NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data for 1999, 2002, 2005, and 2008
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Code Table

## Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California.
## Which city has seen greater changes over time in motor vehicle emissions?

SCC.subset <- subset(SCC, select=c(SCC, Short.Name)) # only relevant cols
NEI.SCC <- merge(NEI, SCC.subset) 
Baltimore <- subset(NEI.SCC, fips == "24510") # subsetting for the Baltimore City
LAC <- subset(NEI.SCC, fips == "06037") # subsetting for Los Angeles County

MV.rows <- grepl("Veh", Baltimore$Short.Name) # looking for motor vehicles in Baltimore
NEI.MV <- subset(Baltimore, MV.rows) # subsetting for motor vehicles in Baltimore
MV.rows2 <- grepl("Veh", LAC$Short.Name) # looking for motor vehicles in Los Angeles County
NEI.MV2 <- subset(LAC, MV.rows2) # subsetting for motor vehicles in Los Angeles County

total.emission <- tapply(NEI.MV$Emissions, NEI.MV$year, sum) # counting totals for Baltimore
total.emission2 <- tapply(NEI.MV2$Emissions, NEI.MV2$year, sum) # counting totals for Los Angeles County

png(filename = "plot6.png") # opening a PNG device

#Using log for a more visual graph and easier change comparison

plot(log10(total.emission), 
     main="Changes in motor vehicle emissions from 1999 to 2008",
     xlab="years", x=c(1999, 2002, 2005, 2008),
     ylab="total emissions of PM2.5, in log10(tons)", ylim=c(0,4),
     col="lightcoral",
     type="b", pch=19, cex=1.5)
lines(log10(total.emission2),
      x=c(1999,2002,2005,2008),
      col="lightblue3",
      type="b", pch=19, cex=1.5)
legend("bottomright", pch=19, col = c("lightcoral", "lightblue3"), 
       legend = c("Baltimore City, Maryland", "Los Angeles County, California"))

dev.off() # closing the device