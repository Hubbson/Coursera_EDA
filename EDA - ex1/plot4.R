f = read.table('household_power_consumption.txt', sep = ';', header = TRUE, na.strings = '?', stringsAsFactors = FALSE)

f$Date = as.Date(f$Date, format = "%d/%m/%Y")
f = subset(f, Date >= as.Date("2007-02-01", format = "%Y-%m-%d"))
f = subset(f, Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))
f = within(f, {timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })
f$Dtimestamp = as.POSIXct(strptime(f$timestamp, "%d/%m/%Y %H:%M:%S"))


png('plot4.png', width = 480, height = 480)
par(mfrow = c(2,2))
plot(f$Global_active_power ~ f$Dtimestamp, type = "l", xlab = '', ylab='Global Active Power')
plot(f$Voltage ~ f$Dtimestamp, type = "l", xlab = 'datetime', ylab='Voltage')
plot(f$Sub_metering_1 ~ f$Dtimestamp, col = 'black', type = "l", xlab = '', ylab='Energy sub metering')
lines(f$Sub_metering_2 ~ f$Dtimestamp, col ='red')
lines(f$Sub_metering_3 ~ f$Dtimestamp, col ='blue')
legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lwd = 1, bty = "n")
plot(f$Global_reactive_power ~ f$Dtimestamp, type = "l", xlab = 'datetime', ylab='Global_reactive_power')
dev.off()
