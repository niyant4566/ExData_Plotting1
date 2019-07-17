# Download and unzip file to create "hpc.txt"

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "dta.zip")
unzip("dta.zip", "household_power_consumption.txt")
file.rename("household_power_consumption","hpc.txt")

f <- read.table("hpc.txt",header = TRUE,sep = ";",na.strings = "?")
f$Date <- dmy(f$Date)
rel_dta <- f[f$Date == "2007-02-01" | f$Date == "2007-02-02",]
date_time <- strptime(paste(rel_dta$Date,rel_dta$Time),"%Y-%m-%d %H:%M:%S")

png("plot4.png",width = 480,height = 480)

par(mfrow = c(2,2))

# Plot 2 on top left

plot(date_time,
     rel_dta$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

# Plot 2 but with an x axis title and comparing date_time with Voltage on top right

plot(date_time,
     rel_dta$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Plot 3 on bottom left

plot(date_time,
     rel_dta$Sub_metering_1,
     type = "l",
     xlab = "",
     ylab = "Energy sub metering")
lines(date_time,
      rel_dta$Sub_metering_2,
      type = "l",
      col = "red")
lines(date_time,
      rel_dta$Sub_metering_3,
      type = "l",
      col = "blue")
legend("topright",
       c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1)

# Plot 2 but with Global_reactive_power and x axis titled "datetime" on bottom right

plot(date_time,
     rel_dta$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()