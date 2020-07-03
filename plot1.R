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

png(filename = "plot1.png")

hist(useful_data$Global_active_power, xlab = "Global Active Power(kilowatts)",
     main = "Global Active Power", col = "red")

dev.off()


png(filename = "plot2.png")

plot(useful_data$Global_active_power, type = "l", xaxt = "n",
     ylab = "Global Active Power(kilowatts)", xlab = "")
axis(1, c(1,1440,2880), c("Thurs", "Fri", "Sat"))

dev.off()