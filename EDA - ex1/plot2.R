f = read.table('household_power_consumption.txt', sep = ';', header = TRUE, na.strings = '?', stringsAsFactors = FALSE)

f$Date = as.Date(f$Date, format = "%d/%m/%Y")
f = subset(f, Date >= as.Date("2007-02-01", format = "%Y-%m-%d"))
f = subset(f, Date <= as.Date("2007-02-02", format = "%Y-%m-%d"))
f = within(f, {timestamp=format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S") })
f$Dtimestamp = as.POSIXct(strptime(f$timestamp, "%d/%m/%Y %H:%M:%S"))


png('plot2.png', width = 480, height = 480)
plot(f$Global_active_power ~ f$Dtimestamp, type = "l", xlab = '', ylab='Global Active Power (kilowatts)')
dev.off()
