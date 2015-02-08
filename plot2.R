#Load data, create datetime(dt) column, and work with the data for 02/01/2007 and 02/02/2007
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?", stringsAsFactors=FALSE)
data$dt <- strptime(paste(data[[1]], data[[2]]), "%d/%m/%Y %H:%M:%S")
subdata <- data[data$dt > as.POSIXlt("2007-01-31 23:59:59") & data$dt < as.POSIXlt("2007-02-03 00:00:00"),]
subdata <- subdata[!is.na(subdata[1]),]

#Initialize the graphics device
png(file = "plot2.png", bg = "transparent")

#Create a line plot for y="Global_active_power" and x="dt"
par(mfcol = c(1,1))
plot(subdata$dt, subdata$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")

#Render to a 480x480 PNG file
dev.off()