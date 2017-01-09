EPC <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")
EPC$Date <- as.Date(EPC$Date, "%d/%m/%Y")
EPC$Time <- strptime(EPC$Time, format = "%H:%M:%S")
EPC$Time <- format(EPC$Time, format = "%H:%M:%S")
newEPC <- subset(EPC, Date >= "2007-02-01" & <= "2007-02-02")

#plot 1
newEPC$Global_active_power <- as.numeric(newEPC$Global_active_power)
png('Plot 1.png')
hist(newEPC$Global_active_power, col = "red", main = "Global Active Power")
dev.off()

#plot 2
newEPC$datetime <- strptime(paste(newEPC$Date, newEPC$Time), "%Y-%m-%d %H:%M:%S")
newEPC$datetime <- as.POSIXct(newEPC$datetime)
png('Plot 2.png')
plot(newEPC$Global_active_power ~ newEPC$datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()

#plot 3
plot(newEPC$Sub_metering_1 ~ newEPC$datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(newEPC$Sub_metering_2 ~ newEPC$datetime, type = "l", col = "red")
lines(newEPC$Sub_metering_3 ~ newEPC$datetime, type = "l", col = "blue")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, lwd = 2, cex = 0.5)
dev.copy(png, 'Plot 3.png', heigh = 480, width = 480)
dev.off()

#plot 4
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
plot(newEPC$Global_active_power ~ newEPC$datetime, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
newEPC$Voltage <- as.numeric(newEPC$Voltage)
plot(newEPC$Voltage ~ newEPC$datetime, type = "l", ylab = "Voltage", xlab = "datetime")
plot(newEPC$Sub_metering_1 ~ newEPC$datetime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(newEPC$Sub_metering_2 ~ newEPC$datetime, type = "l", col = "red")
lines(newEPC$Sub_metering_3 ~ newEPC$datetime, type = "l", col = "blue")
newEPC$Global_reactive_power <- as.numeric(newEPC$Global_reactive_power)
plot(newEPC$Global_reactive_power ~ newEPC$datetime, type = "l", ylab="Global_reactive_power", xlab="datetime")
dev.copy(png, 'Plot 4.png', height = 480, width = 480)
dev.off()
