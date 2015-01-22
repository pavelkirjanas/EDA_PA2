## Read the data from the National Emissions Inventory database (NEI)

NEI <- readRDS("summarySCC_PM25.rds") # PM2.5 Emissions Data for 1999, 2002, 2005, and 2008
SCC <- readRDS("Source_Classification_Code.rds") # Source Classification Code Table

## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008?

Baltimore <- subset(NEI, fips == "24510") # subsetting for the Baltimore City
list <- list(Baltimore$year, Baltimore$type) # making a list to split by
total.emission <- tapply(Baltimore$Emissions, list, sum) # counting totals
total.emission <- as.data.frame(total.emission) # converting to a data frame
names(total.emission) <- make.names(names(total.emission)) # making syntactically valid names

png(filename = "plot3.png") # opening a PNG device

library(ggplot2)
ggplot(total.emission) + 
        geom_line(aes(x=c(1999,2002,2005,2008), y=NON.ROAD, color="darkorchid4")) +
        geom_line(aes(x=c(1999,2002,2005,2008), y=NONPOINT, color="forestgreen")) +
        geom_line(aes(x=c(1999,2002,2005,2008), y=ON.ROAD, color="firebrick3")) +
        geom_line(aes(x=c(1999,2002,2005,2008), y=POINT, color="deepskyblue3")) +
        xlab("years") +
        ylab("total emissions of PM2.5, in tons") +
        ggtitle("Emissions from PM2.5 in the Baltimore City, Maryland 
                \nfrom 1999 to 2008, by the type of source") +
        scale_colour_hue(name="The type of source",
                    labels=c("non-road", "point", "on-road", "non-point"))

dev.off() # closing the device