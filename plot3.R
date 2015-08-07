
plot3 <- function()
{
    ##read csv data and filter only 2 days of data from it
    data <- read.csv("data/household_power_consumption.txt", sep=";", na.strings = "?")
    
    data$Date = strftime(strptime(data$Date, "%d/%m/%Y"), "%m/%d/%Y")
    
    filteredData = data[data$Date == "02/01/2007" | data$Date == "02/02/2007",]
    
    ##add a new column combining date and time columns to data frame for plotting on x axis
    workingdata = data.frame(filteredData, obstime = 
                                 strptime(paste(filteredData$Date, filteredData$Time), 
                                          format = "%m/%d/%Y %H:%M:%S"))
    
    png(file="plot3.png", width=480, height=480)
    
    ##plot time vs energey sub metering 1
    plot(workingdata$obstime, workingdata$Sub_metering_1, 
         type="l", xlab="", ylab="Energy sub metering")
    
    ##use lines to add to exising plot
    lines(workingdata$obstime, workingdata$Sub_metering_2, col="red")
    lines(workingdata$obstime, workingdata$Sub_metering_3, col="blue")
    
    ##add legend to top right corner
    legend("topright", names(workingdata)[7:9], lty=1, col=c("black", "red", "blue"))
    
    dev.off()
}