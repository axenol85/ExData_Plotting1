#Load data, create datetime(dt) column, and work with the data for 02/01/2007 and 02/02/2007
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$dt <- strptime(paste(data[[1]], data[[2]]), "%d/%m/%Y %H:%M:%S")
subdata <- data[data$dt > as.POSIXlt("2007-01-31 23:59:59") & data$dt < as.POSIXlt("2007-02-03 00:00:00"),]
subdata <- subdata[!is.na(subdata[1]),]

#Initialize the graphics device
png(file = "plot4.png", bg = "transparent")

#Create four plots for x="dt" and y="Global_active_power", "Sub_metering_*", "Voltage", "Global_reactive_power"
par(mfcol = c(2,2))
with(subdata, plot(dt, Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power"))
with(subdata, plot(dt, Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering"))
with(subdata, lines(dt, Sub_metering_2, col = "red"))
with(subdata, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), pch = -1, col=c("black","red","blue"), bty="n")
with(subdata, plot(dt, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))
with(subdata, plot(dt, Global_reactive_power, type = "l", xlab = "datetime"))

#Render to a 480x480 PNG file
dev.off()