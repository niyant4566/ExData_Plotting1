# Download and unzip file to create "hpc.txt"

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "dta.zip")
unzip("dta.zip", "household_power_consumption.txt")
file.rename("household_power_consumption","hpc.txt")

f <- read.table("hpc.txt",header = TRUE,sep = ";",na.strings = "?")
f$Date <- dmy(f$Date)
rel_dta <- f[f$Date == "2007-02-01" | f$Date == "2007-02-02",]
date_time <- strptime(paste(rel_dta$Date,rel_dta$Time),"%Y-%m-%d %H:%M:%S")

png("plot2.png",width = 480,height = 480)
plot(date_time,
     rel_dta$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()