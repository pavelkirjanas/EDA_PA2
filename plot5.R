## Read the data from the National Emissions Inventory database (NEI)

NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data for 1999, 2002, 2005, and 2008
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Code Table

## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

SCC.subset <- subset(SCC, select=c(SCC, Short.Name)) # only relevant cols
NEI.SCC <- merge(NEI, SCC.subset) 
Baltimore <- subset(NEI.SCC, fips == "24510") # subsetting for the Baltimore City
MV.rows <- grepl("Veh", Baltimore$Short.Name) # looking for motor vehicles
NEI.MV <- subset(Baltimore, MV.rows) # subsetting for motor vehicles
total.emission <- tapply(NEI.MV$Emissions, NEI.MV$year, sum) # counting totals

png(filename = "plot5.png") # opening a PNG device

plot(total.emission, 
     main="Emissions from from motor vehicle sources \nin the Baltimore City, Maryland from 1999 to 2008",
     xlab="years", x=c(1999, 2002, 2005, 2008),
     ylab="total emissions of PM2.5, in tons", ylim=c(0,400),
     col="lightcoral",
     type="b", pch=19, cex=1.5)

dev.off() # closing the device