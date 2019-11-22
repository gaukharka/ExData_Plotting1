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

# convert Date and Time
dataFeb$Date <- as.Date(dataFeb$Date, format = "%d/%m/%Y")
dataFeb$Time <- strptime(dataFeb$Time, format = "%H:%M:%S")
dataFeb[1:1440, "Time"] <- format(dataFeb[1:1440, "Time"], "2007-02-01 %H:%M:%S")
dataFeb[1441:2880, "Time"] <- format(dataFeb[1441:2880, "Time"], "2007-02-02 %H:%M:%S")
dataFeb$Global_active_power <- as.numeric(dataFeb$Global_active_power)

#build plot
png("plot2.png", width=500, height=500)
plot(dataFeb$Time, dataFeb$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
title("Global Active Power Vs Time")
dev.off()
