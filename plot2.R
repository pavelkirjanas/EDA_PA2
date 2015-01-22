## Read the data from the National Emissions Inventory database (NEI)

NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data for 1999, 2002, 2005, and 2008
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Code Table

## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland from 1999 to 2008? 

Baltimore <- subset(NEI, fips == "24510") # subsetting for the Baltimore City
total.emission <- tapply(Baltimore$Emissions, Baltimore$year, sum) # counting totals

png(filename = "plot2.png") # opening a PNG device

plot(total.emission, 
     main="Total Emissions from PM2.5 in the Baltimore City, Maryland \nfrom 1999 to 2008",
     xlab="years", x=c(1999, 2002, 2005, 2008),
     ylab="total emissions of PM2.5, in tons", ylim=c(0,3400),
     col="deepskyblue3",
     type="b", pch=19, cex=1.5)

dev.off() # closing the device