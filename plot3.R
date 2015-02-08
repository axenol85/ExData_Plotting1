#Load data, create datetime(dt) column, and work with the data for 02/01/2007 and 02/02/2007
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$dt <- strptime(paste(data[[1]], data[[2]]), "%d/%m/%Y %H:%M:%S")
subdata <- data[data$dt > as.POSIXlt("2007-01-31 23:59:59") & data$dt < as.POSIXlt("2007-02-03 00:00:00"),]
subdata <- subdata[!is.na(subdata[1]),]

#Initialize the graphics device
png(file = "plot3.png", bg = "transparent")

#Create a line plot for y="Sub_metering_*" and x="dt" with a legend
par(mfcol = c(1,1))
with(subdata, plot(dt, Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering"))
with(subdata, lines(dt, Sub_metering_2, col = "red"))
with(subdata, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1, 1, 1), pch = -1, col=c("black","red","blue"))

#Render to a 480x480 PNG file
dev.off()