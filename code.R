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
