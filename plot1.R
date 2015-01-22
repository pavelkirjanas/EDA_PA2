## Read the data from the National Emissions Inventory database (NEI)

NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data for 1999, 2002, 2005, and 2008
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Code Table

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

### Using the base plotting system, make a plot 
### showing the total PM2.5 emission from all sources 
### for each of the years 1999, 2002, 2005, and 2008.

total.emission <- tapply(NEI$Emissions, NEI$year, sum) # counting totals
total.emission <- total.emission / 1000000 # converting to million tons

png(filename = "plot1.png") # opening a PNG device

plot(total.emission, 
     main="Total Emissions from PM2.5 in the US from 1999 to 2008",
     xlab="years", x=c(1999, 2002, 2005, 2008),
     ylab="total emissions of PM2.5, in million tons", ylim=c(0,8),
     col="cadetblue",
     type="b", pch=19, cex=1.5)

dev.off() # closing the device