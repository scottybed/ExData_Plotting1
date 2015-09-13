library(dplyr)

epsData <- read.delim('household_power_consumption.txt', header=TRUE, sep=";", stringsAsFactors=FALSE)
epsData$DateTime <- as.POSIXct(strptime(paste(epsData$Date, epsData$Time), "%d/%m/%Y %H:%M:%S"))
epsData <- select(epsData, -Date, -Time)
epsDataF <- filter(epsData, DateTime >= as.POSIXct('2007-02-01') & DateTime < as.POSIXct('2007-02-03'), Global_active_power != '?')

epsDataF <- arrange(epsDataF, DateTime)

png("plot4.png", width=480, height=480, units="px", res=75)
par(mfrow=c(2,2))
with(epsDataF, {
    plot(DateTime, Global_active_power, type="l", xlab='', ylab='Global Active Power (kilowatts)')
    plot(DateTime, Voltage, type="l", xlab='datetime', ylab='Voltage')
    plot(DateTime, Sub_metering_1, type="l", xlab='', ylab='Energy Sub Metering')
    lines(DateTime, Sub_metering_2,col="red")
    lines(DateTime, Sub_metering_3,col="blue")
    legend("topright", lty=c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), seg.len=3, bty = "n")
    plot(DateTime, Global_reactive_power, type="l", xlab='datetime', ylab='Global_reactive_power')
})
dev.off()
