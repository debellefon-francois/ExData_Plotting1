setwd() #place here working directory

library(dplyr) #Used to rearrange data
library(lubridate) #Used for date functions
library(ggplot2) #Used to draw graphics
Sys.setenv(LANG = "en") #My default R interpreter is in French, so we set it to English.


#Extracting the data, subsetting to the date we use, putting date/times and other columns to the right formats.
hpc <- read.csv(file = "household_power_consumption.txt",sep=";",na.strings = "?") %>% mutate(Date = dmy(Date)) %>% filter(Date == "2007-02-01" | Date == "2007-02-02") %>% mutate(Datetime = (ymd_hms(paste(Date,Time)))) %>% mutate(Global_active_power = as.numeric(Global_active_power),Global_reactive_power = as.numeric(Global_reactive_power),Voltage = as.numeric(Voltage),Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric( Sub_metering_1),Sub_metering_2 = as.numeric( Sub_metering_2),Sub_metering_3 = as.numeric( Sub_metering_3))

#Drawing the plot
plot2 <- ggplot(data=hpc, aes(x=Datetime,y=Global_active_power)) + geom_line() + scale_x_datetime(date_breaks = "1 day",date_labels = "%a") + ylab("Global Active Power (kilowatts)") + xlab("") + theme(panel.background = element_blank(),axis.line = element_line(colour = "black"))

#Export in png
png("plot2.png",height = 480,width = 480)
plot2
dev.off()