## Dowloading the file into a temporary file then loading the whole data set

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data_energy <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",na.strings="?")
unlink(temp)

## subsetting the data set for the requested dates
data_energy$Date<-as.Date(data_energy$Date, format= "%d/%m/%Y")
data_energy_small<-subset(data_energy, Date=="2007-02-01"| Date=="2007-02-02")

## Converting the time to a good format
library(lubridate)
library(plyr)
data_energy_small$Time<-as.POSIXct(as.character(data_energy_small$Time),format="%H:%M:%S")
data_energy_small<-mutate(
  data_energy_small, 
  newcol=ISOdatetime(year(Date),month(Date),day(Date),hour(Time),minute(Time), second(Time))
)

## Creating Plot 3 with the necessary labels
plot(
  data2$newcol,
  data2$Sub_metering_1, 
  type="l",
  xlab="",
  ylab="Energy sub metering")
lines(
  data2$newcol,
  data2$Sub_metering_2, 
  type="l",
  col="red")
lines(
  data2$newcol,
  data2$Sub_metering_3, 
  type="l",
  col="blue")
legend(x="topright",
       col=c("black","red","blue"),
       lty=1,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       )


## writing the plot to PNG
dev.copy(png,'Plot3.png')
dev.off()
