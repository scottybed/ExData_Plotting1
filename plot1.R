library(dplyr)

epsData <- read.delim('household_power_consumption.txt', header=TRUE, sep=";", stringsAsFactors=FALSE)
epsData$DateTime <- as.POSIXct(strptime(paste(epsData$Date, epsData$Time), "%d/%m/%Y %H:%M:%S"))
epsData <- select(epsData, -Date, -Time)
epsDataF <- filter(epsData, DateTime >= as.POSIXct('2007-02-01') & DateTime < as.POSIXct('2007-02-03'), Global_active_power != '?')

epsDataF <- arrange(epsDataF, DateTime)

png("plot1.png", width=480, height=480, units="px", res=75)
hist(as.numeric(epsDataF$Global_active_power), xlab='Global Active Power (kilowatts)', ylab='Frequency', col='Red', main='Global Active Power')
dev.off()