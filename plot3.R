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
png("plot3.png", width=400, height=400)

plot(df$Time, df$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(df$Time, df$Sub_metering_2, col="red")
lines(df$Time, df$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1)

dev.off()