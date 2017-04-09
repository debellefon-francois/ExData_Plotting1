setwd() #place here working directory

library(dplyr) #Used to rearrange data
library(lubridate) #Used for date functions
library(ggplot2) #Used to draw graphics
Sys.setenv(LANG = "en") #My default R interpreter is in French, so we set it to English.


#Extracting the data, subsetting to the date we use, putting date/times and other columns to the right formats.
hpc <- read.csv(file = "household_power_consumption.txt",sep=";",na.strings = "?") %>% mutate(Date = dmy(Date)) %>% filter(Date == "2007-02-01" | Date == "2007-02-02") %>% mutate(Datetime = (ymd_hms(paste(Date,Time)))) %>% mutate(Global_active_power = as.numeric(Global_active_power),Global_reactive_power = as.numeric(Global_reactive_power),Voltage = as.numeric(Voltage),Global_intensity = as.numeric(Global_intensity), Sub_metering_1 = as.numeric( Sub_metering_1),Sub_metering_2 = as.numeric( Sub_metering_2),Sub_metering_3 = as.numeric( Sub_metering_3))


#Drawing the plot
plot1 <- ggplot(data = hpc, aes(x=Global_active_power)) + geom_histogram(binwidth = 0.5,boundary=6,fill="red",color="black") + ggtitle("Global Active Power") + ylab("Frequency") + theme(plot.title = element_text(hjust = 0.5),panel.background = element_blank(),axis.line = element_line(colour = "black"))

#Export in png
png("plot1.png",height = 480,width = 480)
plot1
dev.off()