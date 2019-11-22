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
dataFeb$Global_active_power <- as.numeric(dataFeb$Global_active_power)

# building plot
png("plot1.png", width=500, height=500)
hist(dataFeb$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frenquency", main = "", col = "red")
title(main = "Global Active Power")
dev.off()
