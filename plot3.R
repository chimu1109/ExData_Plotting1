library(readr)
library(plyr)
library(dplyr)

consumption <- read_delim("exdata_data_household_power_consumption/household_power_consumption.txt", 
                          ";", escape_double = FALSE, trim_ws = TRUE)
consumption <- mutate(consumption, Date = strptime(Date, "%d/%m/%Y"))
useful_data <- filter(consumption, Date == "2007-02-01 00:00:00")
useful_data1 <- filter(consumption, Date == "2007-02-02 00:00:00")
useful_data <- rbind(useful_data, useful_data1)
rm(useful_data1)
rm(consumption)


png(filename = "plot3.png")

plot(useful_data$Sub_metering_1, type = "n", xaxt = "n", 
     ylab = "Global Active Power(kilowatts)", xlab = "")
points(useful_data$Sub_metering_1, type = "l", col = "black")
points(useful_data$Sub_metering_2, type = "l", col = "red")
points(useful_data$Sub_metering_3, type = "l", col = "blue")
axis(1, c(1,140,2880), c("Thurs", "Fri", "Sat"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),
       lty = 1)

dev.off()