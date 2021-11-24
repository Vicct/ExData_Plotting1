setwd("C:/Project Files/CURSOS/DataScience-Hopkins/ExpDatW1/exdata_data_household_power_consumption")
library(plyr)
library(data.table)

##' Read the table
##' 
consumption <- read.table('./household_power_consumption.txt', header=TRUE, sep = ";", na.string = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format date to Type Date
consumption$Date <- as.Date(consumption$Date, "%d/%m/%Y")

##' Filter data set from 02/01/2007 to 02/02/2007
consumption <- subset(consumption,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Check for complete test cases 
consumption <- consumption[complete.cases(consumption),]

## Date and Time column combination
dateTime <- paste(consumption$Date, consumption$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Removing the Date and Time columns
consumption <- consumption[ ,!(names(consumption) %in% c("Date","Time"))]

## Adding the DateTime column
consumption <- cbind(dateTime, consumption)

## Formatting the dateTime Column
consumption$dateTime <- as.POSIXct(dateTime)

par(mar=c(4,4,4,4))

## PLOT 2
## Create Plot 2
plot(consumption$Global_active_power~consumption$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

