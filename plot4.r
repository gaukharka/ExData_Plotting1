setwd("~/Desktop/coursera/course4")
library(tidyverse)
library(datasets)
library(lubridate)

#read in data, add column names
data <- read.table("household_power_consumption.txt", skip= 1, head = FALSE, sep=";", stringsAsFactors = FALSE)
columns <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
             "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
names(data) <- columns
dataFeb <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# converting
dataFeb$Date <- as.Date(dataFeb$Date, format = "%d/%m/%Y")
dataFeb$Time <- strptime(dataFeb$Time, format = "%H:%M:%S")
dataFeb[1:1440, "Time"] <- format(dataFeb[1:1440, "Time"], "2007-02-01 %H:%M:%S")
dataFeb[1441:2880, "Time"] <- format(dataFeb[1441:2880, "Time"], "2007-02-02 %H:%M:%S")
dataFeb$Global_active_power <- as.numeric(dataFeb$Global_active_power)
dataFeb$Sub_metering_1 <- as.numeric(dataFeb$Sub_metering_1)
dataFeb$Sub_metering_2 <- as.numeric(dataFeb$Sub_metering_2)
dataFeb$Sub_metering_3 <- as.numeric(dataFeb$Sub_metering_3)

#build plots
png("plot4.png", width=500, height=500)
par(mfrow = c(2,2))
plot(dataFeb$Time, dataFeb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(dataFeb$Time, dataFeb$Voltage, type = "l", xlab="datetime", ylab="Voltage")
plot(dataFeb$Time, dataFeb$Sub_metering_1, type = "n", main = "", xlab = "", ylab = "Energy sub metering")
  with(dataFeb, lines(Time, Sub_metering_1))
  with(dataFeb, lines(Time, Sub_metering_2, type = "l", col = "red"))
  with(dataFeb, lines(Time, Sub_metering_3, type = "l", col = "blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(dataFeb$Time, dataFeb$Global_reactive_power, type = "l",  xlab="datetime", ylab = "Global_active_power")
dev.off()



