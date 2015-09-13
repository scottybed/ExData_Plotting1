library(dplyr)

epsData <- read.delim('household_power_consumption.txt', header=TRUE, sep=";", stringsAsFactors=FALSE)
epsData$DateTime <- as.POSIXct(strptime(paste(epsData$Date, epsData$Time), "%d/%m/%Y %H:%M:%S"))
epsData <- select(epsData, -Date, -Time)
epsDataF <- filter(epsData, DateTime >= as.POSIXct('2007-02-01') & DateTime < as.POSIXct('2007-02-03'), Global_active_power != '?')

epsDataF <- arrange(epsDataF, DateTime)

png("plot3.png", width=480, height=480, units="px", res=75)
plot(epsDataF$DateTime, epsDataF$Sub_metering_1, type="l", xlab='', ylab='Energy Sub Metering')
lines(epsDataF$DateTime, epsDataF$Sub_metering_2,col="red")
lines(epsDataF$DateTime, epsDataF$Sub_metering_3,col="blue")
legend("topright", lty=c(1,1), col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), seg.len=3)
dev.off()