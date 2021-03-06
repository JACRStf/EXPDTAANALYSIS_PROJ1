# Function to convert the Date and Time variables to Date/Time classes
date_time <- function(date, time) {
  return (strptime(paste(date, time), "%d/%m/%Y %H:%M:%S"))
}

# Set working directory and read downloaded file 
setwd("~/Documents/ExploratoryDataAnalysis")
filename <- "household_power_consumption.txt"
df <- read.table(filename,
                 header=TRUE,
                 sep=";",
                 colClasses=c("character", "character", rep("numeric",7)),
                 na="?")

df$Time <- strptime(paste(df$Date, df$Time), "%d/%m/%Y %H:%M:%S")
df$Date <- as.Date(df$Date, "%d/%m/%Y")

# select data from 2007-02-01 to 2007-02-02
dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
df <- subset(df, Date %in% dates)

# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
png("plot4.png", width=400, height=400)

par(mfrow=c(2,2))
# Graph 1
plot(df$Time, df$Global_active_power,
     type="l",
     xlab="",
     ylab="Global Active Power")
# Graph 2
plot(df$Time, df$Voltage, type="l",
     xlab="datetime", ylab="Voltage")
# Graph 3
plot(df$Time, df$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(df$Time, df$Sub_metering_2, col="red")
lines(df$Time, df$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1,
       box.lwd=0)
# Graph 4
plot(df$Time, df$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(df$Time, df$Global_reactive_power)

dev.off()
