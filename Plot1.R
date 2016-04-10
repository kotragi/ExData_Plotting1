## Dowloading the file into a temporary file then loading the whole data set

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data_energy <- read.table(unz(temp, "household_power_consumption.txt"),header=TRUE,sep=";",na.strings="?")
unlink(temp)

## subsetting the data set for the requested dates
data_energy$Date<-as.Date(data_energy$Date, format= "%d/%m/%Y")
data_energy_small<-subset(data_energy, Date=="2007-02-01"| Date=="2007-02-02")

## Creating Plot 1 with the necessary labels
windows(width=7, height=8)
hist(
    data_energy_small$Global_active_power, 
    xlab="Global Active Power (kilowatts)", 
    col="red", 
    main="Global Active Power")
 
## writing the plot to PNG
dev.copy(png,'Plot1.png')
dev.off()

